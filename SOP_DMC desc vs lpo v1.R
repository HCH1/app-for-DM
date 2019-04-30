library(dplyr)
##input:
i1 = read.csv("130BCD_Rev0.9_5.0_PRE01_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
#i1 = read.csv("1 Editable V0100FINAL DM000450 (Rev. 1.0_0.3) - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002802 130G-LP (v33).csv", header = TRUE, stringsAsFactors=FALSE)
#i3 = read.csv("3 LM-0001.091 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
###make a sub-ALL
TV_uwant <- "DM-000282"
ly_st <- "Active"
ly_cat <- "Marker Enablement"
###
i1_v1 <- i1
i2_v1 <- i2
i1_v1$ch_ly1 <- gsub("[_]", "999", i1_v1$Description)
i1_v1$ch_ly1 <- gsub("[.]", "888", i1_v1$ch_ly1)
i1_v1$ch_ly1 <- gsub("n[']t", "777", i1_v1$ch_ly1)
i1_v1$ch_ly1 <- gsub("[[:punct:]]", " ", i1_v1$ch_ly1)
###keep _ and .
i1_v1$ch_ly1 <- gsub("999", "_", i1_v1$ch_ly1)
i1_v1$ch_ly1 <- gsub("888", ".", i1_v1$ch_ly1)
i1_v1$ch_ly1 <- gsub("777", "n't", i1_v1$ch_ly1)
i1_v1$ch_ly1 <- gsub("[.]$", "", i1_v1$ch_ly1)
#insdie dataframe is factor -> character -> list -> character
desc_split <- unlist( strsplit( i1_v1$ch_ly1, '\\s' ) )
desc_split <- as.data.frame(desc_split)
str(desc_split)
###remove end is .
desc_split$desc_split <- gsub("[.]$", "", desc_split$desc_split)
###freq
desc_split_freq <- table(desc_split)
desc_split_freq <- as.data.frame(desc_split_freq)
colnames(desc_split_freq)[1] <- "Data.Layer.Name"
str(desc_split_freq)
write.csv(x = desc_split_freq, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC_desc split v1.csv", sep = "") )
####################################################end
library(qdapDictionaries)
#create custom function
is.word <- function(x) x %in% GradyAugmented # or use any dataset from package
#use this function to filter words, df = dataframe from corpus
df0 <- desc_split_freq
df <- desc_split_freq
###dict only has lower case.
#df0$Data.Layer.Name <- tolower(df0$Data.Layer.Name)
df <- df[which(is.word(df$Data.Layer.Name)),]
###dm vs af-dict
desc_vs_dict <- full_join(df0, df, by = "Data.Layer.Name")
colnames(desc_vs_dict)[2] <- "dm.desc.split.freq"
colnames(desc_vs_dict)[3] <- "in.dict.freq"
write.csv(x = desc_vs_dict, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC_desc vs dict v1.csv", sep = "") )
####################################################end
###make a sub-ALL
sub_ALL <- i2_v1
sub_ALL <- sub_ALL[grep(TV_uwant, sub_ALL$Tech.Variant...Included.in.PDK),]
sub_ALL <- sub_ALL[grep(ly_st, sub_ALL$Layer.Status),]
sub_ALL <- sub_ALL[grep(ly_cat, sub_ALL$Layer.Category, invert = TRUE),]
#str(sub_ALL)
####################################################end
###vlookup sub-ALL vs desc_split vs dict
desc_map_lpo <- full_join( desc_vs_dict, sub_ALL, by = "Data.Layer.Name")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
#replace NA to blank
desc_map_lpo[ is.na( desc_map_lpo ) ] <- ""
#desc_map_lpo <- desc_map_lpo[ order(desc_map_lpo[4], decreasing = FALSE), ]
#desc_map_lpo <- desc_map_lpo[ order(desc_map_lpo[3], decreasing = TRUE), ]
#
desc_map_lpo2 <- desc_map_lpo
###case: dm.desc.split="" in.dict="" LV=has
desc_map_lpo2$ans.missing.ly = ifelse(
desc_map_lpo2$dm.desc.split == ""
& desc_map_lpo2$in.dict == ""
& grepl("LV",desc_map_lpo2$ï..Number),"ly do not have GR",0)

###case: dm.desc.split=has in.dict="" LV=has
desc_map_lpo2$ans.ly.in.GR.desc = ifelse(
desc_map_lpo2$dm.desc.split > 0
& desc_map_lpo2$in.dict == ""
& grepl("LV",desc_map_lpo2$ï..Number),"ly in GR desc",0)

###case: dm.desc.split=has in.dict=has LV=""
desc_map_lpo2$ans.word.in.dict = ifelse(
desc_map_lpo2$dm.desc.split > 0
& desc_map_lpo2$in.dict > 0
& grepl("",desc_map_lpo2$ï..Number),"word in dict",0)

desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[dim(desc_map_lpo2)[2]], 
decreasing = TRUE), ]
desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[dim(desc_map_lpo2)[2]-1], 
decreasing = TRUE), ]
desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[dim(desc_map_lpo2)[2]-2], 
decreasing = TRUE), ]
str(desc_map_lpo2)
write.csv(x = desc_map_lpo2, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC_desc vs dict vs sub-ALL v1.csv", sep = "") )
####################################################end
#search then replace
#gsub("[^\\(\\)\\[\\]\\{\\}]", "", x)
#i1_v1$desc2 <- gsub("[^\\( | \\) | \\ | [\\] | \\{ | \\}]", "", i1_v1$Description)
###to solve bracket issue
i1_v1 <- i1
###due to hard to code [ and ], so we replace them 1st
i1_v1$desc1 <- gsub("\\[", "@(@", i1_v1$Description)
i1_v1$desc1 <- gsub("\\]", "@)@", i1_v1$desc1)
i1_v1$desc1 <- gsub("[A-z0-9]|\\s", "", i1_v1$desc1)
i1_v1$desc1 <- gsub("\\@\\(\\@", "3", i1_v1$desc1)
i1_v1$desc1 <- gsub("\\@\\)\\@", "4", i1_v1$desc1)

i1_v1$bk1 <- gsub("[^\\(]", "", i1_v1$desc1)
i1_v1$bk2 <- gsub("[^\\)]", "", i1_v1$desc1)
###let [ and ] as 3 and 4
i1_v1$bk3 <- gsub("[^3]", "", i1_v1$desc1)
i1_v1$bk4 <- gsub("[^4]", "", i1_v1$desc1)

i1_v1$bk5 <- gsub("[^\\{]", "", i1_v1$desc1)
i1_v1$bk6 <- gsub("[^\\}]", "", i1_v1$desc1)
###replace ()[]{} to 1 2 3, then do logic check, if diff, then missing
i1_v1$bk1 <- gsub("[\\(]", "1", i1_v1$bk1)
i1_v1$bk2 <- gsub("[\\)]", "1", i1_v1$bk2)
i1_v1$bk3 <- gsub("3", "2", i1_v1$bk3)
i1_v1$bk4 <- gsub("4", "2", i1_v1$bk4)
i1_v1$bk5 <- gsub("[\\{]", "3", i1_v1$bk5)
i1_v1$bk6 <- gsub("[\\}]", "3", i1_v1$bk6)

i1_v1$bk_check12 <- ifelse(i1_v1$bk1 == i1_v1$bk2,"same","bracket missing")
i1_v1$bk_check34 <- ifelse(i1_v1$bk3 == i1_v1$bk4,"same","bracket missing")
i1_v1$bk_check56 <- ifelse(i1_v1$bk5 == i1_v1$bk6,"same","bracket missing")
str(i1_v1)
#i1_v1$desc2 <- gsub("[[:punct:]]|\\w|\\s", "", i1_v1$Description)
#i1_v1$desc2 <- gsub("[^\\(\\)]", "", i1_v1$desc2)
#i1_v1$desc2 <- gsub("\\w|\\s|[.]|[<]|[>]|[/]|[-]|[\"]|[$]|[=]|[+]|[%]|[,]|[:]|[;]|[&]|[#]|[']|[~]", 
#"", i1_v1$Description)
write.csv(x = i1_v1, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC_desc bracket v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end

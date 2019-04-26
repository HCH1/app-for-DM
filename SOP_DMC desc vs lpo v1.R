library(dplyr)
##input:
i1 = read.csv("130BCDLITE_Rev1.0_4.0_DRC03_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
i4tv = "DM-000282"
#i1 = read.csv("1 Editable V0100FINAL DM000450 (Rev. 1.0_0.3) - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("2 LCN-002718 130G-LP (v29).csv", header = TRUE, stringsAsFactors=FALSE)
#i3 = read.csv("3 LM-0001.091 130G-LP.csv", header = TRUE, stringsAsFactors=FALSE)
###make a sub-ALL
TV_uwant <- "DM-000064"
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
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC desc split v1.csv", sep = "") )
####################################################end
###make a sub-ALL
sub_ALL <- i2_v1
sub_ALL <- sub_ALL[grep(TV_uwant, sub_ALL$Tech.Variant...Included.in.PDK),]
sub_ALL <- sub_ALL[grep(ly_st, sub_ALL$Layer.Status),]
sub_ALL <- sub_ALL[grep(ly_st, sub_ALL$Layer.Category
, invert = TRUE),]
str(sub_ALL)
####################################################end
#vlookup sub-ALL vs desc_split
desc_map_lpo <- full_join(sub_ALL, desc_split_freq, by = "Data.Layer.Name")
#dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
#head(i1_v3)
#replace NA to blank
desc_map_lpo[ is.na( desc_map_lpo ) ] <- ""
desc_map_lpo <- desc_map_lpo[ order(desc_map_lpo[dim(desc_map_lpo)[2]], decreasing = TRUE), ]
write.csv(x = desc_map_lpo, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC desc split_map lpo v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end

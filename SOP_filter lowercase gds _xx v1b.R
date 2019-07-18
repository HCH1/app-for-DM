#v1b grep only e.g. _MK	|_XTOR|_TYPE|_Res|_Label|_EXCL
library(dplyr)
##input:
i11 = read.csv("2 LCN-003290 130G-LP (v44).csv", header = TRUE, stringsAsFactors=FALSE)
#grep dataframe contain keywords
#lmt_col3p3 <- "Generic"
#lmt_col1 <- "LM-0159"
#lmt_col2 <- "Layer Mapping Table"
#lmt_col4 <- "Layer"
lpo_col1 <- "LCN-003290"
colnames(i11)[1] <- "lv"
i1 <- i11
#grep words at tail
i1a <- i1[grep("_MK$|_XTOR$|_TYPE$|_Res$|_Label$|_EXCL$", i1$Data.Layer.Name),]
i1b <- i1a
#replace certain col many words 
i1b$Data.Layer.Name <- gsub("[_]MK$|[_]XTOR$|[_]TYPE$|[_]Res$|[_]Label$|[_]EXCL$", "", i1b$Data.Layer.Name)
#count freq
i1c <- table(i1b$Data.Layer.Name)
i1c <- as.data.frame(i1c)
colnames(i1c)[1] <- "Data.Layer.Name"
#map freq vs lcn
i1d <- left_join(i1c, i11, by = "Data.Layer.Name")
i1d[ is.na( i1d ) ] <- ""

###re-order 1
i1c <- i1c[ order( i1c$Freq
, na.last = FALSE, decreasing = TRUE ), ] #order reverse
###re-order 2
i1a <- i1a[ order( i1a$Data.Layer.Name
, na.last = FALSE, decreasing = FALSE ), ] #order reverse
###re-order 3
i1d <- i1d[ order( i1d$lv
, na.last = FALSE, decreasing = FALSE ), ] #order reverse

#save 1
write.csv(x = i1c, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",lpo_col1
, "_xx sum freq by R v1.csv", sep = "") )
#save 2
write.csv(x = i1a, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",lpo_col1
, "_grep lcn _xx by R v1.csv", sep = "") )
#save 3
write.csv(x = i1d, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",lpo_col1
, "_xx map vs lcn by R v1.csv", sep = "") )
####################################################end
#v1 filter many gds
library(dplyr)
##input:
i11 = read.csv("20190708_10_LM-0159_vs_LCN-002803_diff by R v1.csv", header = TRUE, stringsAsFactors=FALSE)
#grep dataframe contain keywords
lmt_col3p3 <- "Generic"
lmt_col1 <- "LM-0159"
lmt_col2 <- "Layer Mapping Table"
lmt_col4 <- "Layer"
lpo_col1 <- "LCN-002803"
i1 <- i11
#i1b <- i1[grep("124;0|130;0|201;0|234;39|28;0", i1$name),]
i1b <- i1[grep("124;0|130;0|201;0|23;39|25;0|87;0", i1$name),]
###re-order
i1b <- i1b[ order( i1b$name
, na.last = FALSE, decreasing = FALSE ), ] #order reverse
write.csv(x = i1b, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_",lmt_col1,"_vs_",lpo_col1
, "_filter many gds by R v1.csv", sep = "") )
####################################################end
#v0 dmc report then grep only lowercase
dmc = read.csv("DMC_Result_130BCDLite_DM000064 Failing Term v1.csv", header = TRUE)
dmc1 <- dmc
str(dmc1)
#https://stackoverflow.com/questions/39775133/r-grep-remove-upper-case-rows
dmc1 <- grep("^[a-z 0-9]+$|^[A-Z]{1}[a-z 0-9]+$", dmc1$Failing.Term, value = TRUE, invert = FALSE) # patterns max 2K ea
str(dmc1)
write.csv(x = dmc1, row.names = FALSE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_dmc Failing Term_only lowercase.csv", sep = "") )
####################################################end
####################################################end
####################################################end

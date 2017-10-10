#install.packages("zoo")
#library(zoo)
#lpo = read.table("LPO-000202.csv")
drc = readLines("merge22fdx1004.txt", warn = FALSE)
drc1 <- drc
drc1 <- grep("prohibit", drc1, value = TRUE)
write.table(x = drc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc1.txt", sep = "") )
##touching over space incurring straddling
##remove wordings " a-z"
#drc3 <- gsub("\\s[a-z]+", "", drc1)
#write.table(x = drc3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc3.txt", sep = "") )
##remove wordings " @ "
#drc4 <- gsub(".+@\\s", "", drc3)
#write.table(x = drc4, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc4.txt", sep = "") )
#grep invert non "space"
ddrc1 <- grep("space", drc1, value = TRUE, invert = TRUE)
write.table(x = ddrc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc1.txt", sep = "") )
#replace to "|" for split
ddrc1v1 <- gsub("touching|over|straddling|incurring|created", "\t", ddrc1)
write.table(x = ddrc1v1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc1v1.txt", sep = "") )
#replace lower a-z
ddrc3 <- gsub("\\s[a-z]+", "", ddrc1v1)
write.table(x = ddrc3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc3.txt", sep = "") )
#ddrc3 is character -> but we want dataframe
ddrc4 <- as.data.frame(ddrc3)
ddrc5 <- ddrc4[order(ddrc4[,1]), ]
#ddrc5_uni will be factor if do unique
ddrc5_uni <- unique(ddrc5)
write.table(x = ddrc5_uni, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni.txt", sep = "") )
#
ddrc5_uni1 <- as.character(ddrc5_uni)
ddrc5_uni2 <- grep("[(]|[)]", ddrc5_uni1, value = TRUE, invert = TRUE)
#split by \tab
ddrc5_uni3 <- strsplit(ddrc5_uni2, '\t')
ddrc5_uni4 <- as.data.frame(ddrc5_uni3)
ddrc5_uni4t <- t(ddrc5_uni4)
#clean \\space & @
ddrc5_uni4t[,1] <- gsub("^\\s+|[@]|$\\s", "", ddrc5_uni4t[,1])
#clean lead is \\space
ddrc5_uni4t[,2] <- gsub("^\\s+", "", ddrc5_uni4t[,2])
#head(ddrc5_uni4t)
write.csv(x = ddrc5_uni4t, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni4t.csv", sep = "") )

#
#t() for the correct dim
#
#ddrc5_uni3 <- read.csv("ddrc5_uni3.csv", sep = ";")
#head(ddrc5_uni3)
#ddrc5_uni3 <- as.data.frame(ddrc5_uni2)
#write.table(ddrc5_uni3, file = "ddrc5_uni3.csv",row.names=FALSE, na="",col.names=FALSE, dec=";")
#write.csv(x = ddrc5_uni2, dec=";", row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni2.csv", sep = ""), )
#
###grep the 1st string
dddrc1 <- grep("^LAYER", drc, value = TRUE)
write.table(x = dddrc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_dddrc1.txt", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
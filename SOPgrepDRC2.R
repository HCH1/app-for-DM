#install.packages("zoo")
#library(zoo)
#lpo = read.table("LPO-000202.csv")
drc = readLines("merge22fdx1004.txt", warn = FALSE)
drc1 <- drc
drc1 <- grep("prohibit", drc1, value = TRUE)
write.table(x = drc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc1.txt", sep = "") )
#touching|over|straddling|incurring|created|space
#replace to "\t" for future split
ddrc1v1 <- gsub("touching|over|straddling|incurring|created|space", "\t", drc1)
write.table(x = ddrc1v1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc1v1.txt", sep = "") )
#replace lower a-z, lead \\s, end \\s 
ddrc3 <- gsub("\\s[a-z]+|^[ ]+|[@]\\s|[ ]+$|[.]$", "", ddrc1v1)
ddrc3 <- gsub("\\s\t\\s", "\t", ddrc3)
write.table(x = ddrc3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc3.txt", sep = "") )
#ddrc3 is character -> but we want dataframe
ddrc4 <- as.data.frame(ddrc3)
ddrc5 <- ddrc4[order(ddrc4[,1]), ]
#ddrc5_uni will be factor if do unique
ddrc5_uni <- unique(ddrc5)
write.table(x = ddrc5_uni, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni.txt", sep = "") )
#
ddrc5_uni1 <- as.character(ddrc5_uni)
ddrc5_uni2 <- grep("[(]|[)]|[>]", ddrc5_uni1, value = TRUE, invert = TRUE)
#split by \tab
ddrc5_uni3 <- strsplit(ddrc5_uni2, '\t')
ddrc5_uni4 <- as.data.frame(ddrc5_uni3)
ddrc5_uni4t <- t(ddrc5_uni4)
#ddrc5_uni4t <- ddrc5_uni4t[-(3:4)]
write.csv(x = ddrc5_uni4t, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni4t.csv", sep = "") )
###grep the 1st string
#dddrc1 <- grep("^LAYER", drc, value = TRUE)
#write.table(x = dddrc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_dddrc1.txt", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
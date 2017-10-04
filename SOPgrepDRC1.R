#install.packages("zoo")
#library(zoo)
#lpo = read.table("LPO-000202.csv")
drc = readLines("merge22fdx1004.txt", warn = FALSE)
drc1 <- drc
drc1 <- grep("prohibit", drc1, value = TRUE)
write.table(x = drc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc1.txt", sep = "") )
##touching over space incurring straddling
##remove wordings " a-z"
drc3 <- gsub("\\s[a-z]+", "", drc1)
write.table(x = drc3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc3.txt", sep = "") )
##remove wordings " @ "
drc4 <- gsub(".+@\\s", "", drc3)
write.table(x = drc4, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc4.txt", sep = "") )
###
ddrc1 <- grep("space", drc1, value = TRUE, invert = TRUE)
write.table(x = ddrc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc1.txt", sep = "") )
ddrc3 <- gsub("\\s[a-z]+", "", ddrc1)
write.table(x = ddrc3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc3.txt", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
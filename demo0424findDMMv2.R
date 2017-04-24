#install.packages("zoo")
#library(zoo)
dmmis = read.csv("20170424DMMlog2.csv", header = TRUE)
dmmwas = read.csv("0424wasDMMv1.csv", header = TRUE)

dmmis2 <- dmmis[dmmis[3]=="22FDSOI", ]
dmmis2 <- dmmis2[dmmis2[4]!="Canceled", ]
dmmis2 <- dmmis2[dmmis2[4]!="Closed", ]
write.csv(x = dmmis2, file = paste(format(Sys.time(), "%Y%m%d"), "_dmmis2.csv", sep = "") )

dmmis3 <- t(dmmis2[1])
dmmwas3 <- t(dmmwas)
#https://www.rstudio.com/resources/cheatsheets/
dmmdiff <- setdiff(dmmis3,dmmwas3)
#length(dmmdiff)
dmm_and <- intersect(dmmis3,dmmwas3)
#length(dmm_and)
dmmis4 <- dmmis2
for (i in 1:length(dmm_and) ){
  dmmis4 <- dmmis4[ dmmis4[1]!=dmm_and[i],]
}
#dim(dmmis4)
write.csv(x = dmmis4, file = paste(format(Sys.time(), "%Y%m%d"), "_dmm_and.csv", sep = "") )

#dmmdiff <- setdiff(dmmis3,dmmwas3)
#write.csv(x = dmmdiff, file = paste(format(Sys.time(), "%Y%m%d"), "_dmmdiff.csv", sep = "") )
#dmmdiff2 = read.csv(paste(format(Sys.time(), "%Y%m%d"), "_dmmdiff.csv", sep = ""), header = TRUE)
#dim(dmmdiff2)

#######end

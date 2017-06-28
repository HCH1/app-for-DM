#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
#install.packages("diffobj")
library(diffobj)
#vignette("diffobj", package="diffobj")
#sum2 = read.csv("0628will.csv", header = TRUE)
#sum1 = read.csv("0628was.csv", header = TRUE)
##in WIN7, use 
##copy /a *.dita dita1.txt
sum2 = readLines("0628will.txt", warn = FALSE)
sum1 = readLines("0628was.txt", warn = FALSE)
length(sum2)
length(sum1)
diffChr(sum1, sum2, color.mode="rgb")
############################################################end
#write.csv(x = sum2v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum2v1.csv", sep = "") )
#write.csv(x = sum1v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum1v1.csv", sep = "") )
#diffChr(sum1, sum2, mode="sidebyside")
#diffPrint(target=sum2, current=sum1, color.mode="rgb")
#ses(sum1, sum2)
#diffStr(sum1, sum2)

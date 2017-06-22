#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
#install.packages("diffobj")
library(diffobj)
#vignette("diffobj", package="diffobj")
#sum2 = read.csv("22FDX_22FDX_V1200QA01_Base_Editable 0523v3.csv", header = TRUE)
#sum1 = read.csv("22FDX_Rev1.2_0.0_DRC03v2.csv", header = TRUE)
##in WIN7, use 
##copy /a *.dita dita1.txt
sum2 = readLines("0524dita1.txt", warn = FALSE)
sum1 = readLines("0522dita1.txt", warn = FALSE)

length(sum2)
length(sum1)
sum2 <- sum2[ -(1:length(sum2)*0.95) ]
sum1 <- sum1[ -(1:length(sum1)*0.95) ]
length(sum2)
length(sum1)

sum2 <- gsub("<entry", "\n<entry", sum2)
sum2 <- gsub("<title", "\n<title", sum2)
sum1 <- gsub("<entry", "\n<entry", sum1)
sum1 <- gsub("<title", "\n<title", sum1)

sum2v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum2, value = TRUE) #grep /entry & /title & _-fn#
sum1v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum1, value = TRUE) #grep /entry & /title & _-fn#

write(x = sum2v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum2v1.txt", sep = "") )
write(x = sum1v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum1v1.txt", sep = "") )

#write.csv(x = sum2v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum2v1.csv", sep = "") )
#write.csv(x = sum1v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum1v1.csv", sep = "") )

diffPrint(target=sum2v1, current=sum1v1, color.mode="rgb")
############################################################end
#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
#install.packages("diffobj")
library(diffobj)
#vignette("diffobj", package="diffobj")
#sum2 = read.csv("22FDX_22FDX_V1200QA01_Base_Editable 0523v3.csv", header = TRUE)
#sum1 = read.csv("22FDX_Rev1.2_0.0_DRC03v2.csv", header = TRUE)
##in WIN7, use 
##copy /a *.dita dita1.txt
sum2 = readLines("22FDX_22FDX_V1200QA01_Base_Editable0523v2.txt", warn = FALSE)
sum1 = readLines("22FDX_Rev1.2_0.0_DRC03.txt", warn = FALSE)

sum2v1 <- grep("Technology Design Manual", sum2, value = TRUE, invert = TRUE)
sum2v1 <- grep("GLOBALFOUNDRIES Confidential", sum2v1, value = TRUE, invert = TRUE)
sum2v1 <- grep("[[:punct:]]{10,}", sum2v1, value = TRUE, invert = TRUE)
sum2v1 <- grep("^Page[[:blank:]]{1}[0-9]{1,}$", sum2v1, value = TRUE, invert = TRUE)
sum2v1 <- grep("^Use Only", sum2v1, value = TRUE, invert = TRUE)

from2v1 <- grep("^Technology[[:blank:]]{1}Introduction", sum2v1)
end2v1 <- grep("^14.1[[:blank:]]{1}Revision[[:blank:]]{1}History", sum2v1)
end2v2 <- end2v1-from2v1
sum2v1 <- sum2v1[ -(1:from2v1) ]
sum2v1 <- sum2v1[ -(end2v2:length(sum2v1)) ]

sum1v1 <- grep("Technology Design Manual", sum1, value = TRUE, invert = TRUE)
sum1v1 <- grep("GLOBALFOUNDRIES Confidential", sum1v1, value = TRUE, invert = TRUE)
sum1v1 <- grep("[[:punct:]]{10,}", sum1v1, value = TRUE, invert = TRUE)
sum1v1 <- grep("^Page[[:blank:]]{1}[0-9]{1,}$", sum1v1, value = TRUE, invert = TRUE)
sum1v1 <- grep("^Use Only", sum1v1, value = TRUE, invert = TRUE)

from1v1 <- grep("^Technology[[:blank:]]{1}Introduction", sum1v1)
end1v1 <- grep("^14.1[[:blank:]]{1}Revision[[:blank:]]{1}History", sum1v1)
end1v2 <- end1v1-from1v1
sum1v1 <- sum1v1[ -(1:from1v1) ]
sum1v1 <- sum1v1[ -(end1v2:length(sum1v1)) ]

write.csv(x = sum2v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum2v1.csv", sep = "") )
write.csv(x = sum1v1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum1v1.csv", sep = "") )

diffPrint(target=sum2v1, current=sum1v1, color.mode="rgb")
####################################################end

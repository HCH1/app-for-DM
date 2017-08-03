diffdm = read.csv("LPO-000172.csv", header = TRUE)
#col2 7 9 17 18
diffdm2 <- cbind( diffdm[2], diffdm[17], diffdm[18], diffdm[9], diffdm[7] )
diffdm2 <- diffdm2[order(diffdm2[1]), ]
write.csv(x = diffdm2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2.csv", sep = "") )
##
#輸入ch2
sum1 = read.csv("22FDXch2p2.csv", header = TRUE)
sum1 <- sum1[order(sum1[1]), ]
#輸入LPO
sum2 <- diffdm2
#head(sum2)
##sum2 = read.csv("20170803_13_lpo2.csv", header = TRUE)
##sum2 <- sum2[,-1]
#LPO的欄位名稱
#Data.Layer.Name GDS.Number GDS.Datatype Layer.Description Layer.Category
colnames(sum1)[1] <- "Data.Layer.Name"
#head(sum1)
###library(dplyr)
#讓LPO只選某些rows 基於ch2 這樣比較好做diff
#類似vlookup
#sum22 <- semi_join(sum2, sum1[1], by = "Data.Layer.Name" )
sum33 <- merge(sum2, sum1[1])
head(sum33)
dim(sum33)
dim(sum1)
#sum33 <- vlookup(sum2, sum1[1], result_column='Data.Layer.Name')
write.csv(x = sum22, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo3.csv", sep = "") )
#head(ans1)
#install.packages("diffobj")
#library(diffobj)
#vignette("diffobj", package="diffobj")
write.csv(x = sum1, file = "ch2v1.csv")
write.csv(x = sum22, file = "lpov1.csv")
ch2v1 = read.csv("ch2v1.csv", header = TRUE)
lpov1 = read.csv("lpov1.csv", header = TRUE)
write.csv(x = ch2v1[,-1], file = "ch2v1.csv")
write.csv(x = lpov1[,-1], file = "lpov1.csv")
diffCsv(target="ch2v1.csv", current="lpov1.csv", color.mode="rgb")
####################################################end
####################################################end

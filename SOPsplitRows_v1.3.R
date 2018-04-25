#library(dplyr)
library(xlsx)
i1 = read.csv("2018_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur,slphv,lpse - Copy6 v5.2 for Tom.csv", header = FALSE, stringsAsFactors=FALSE)
dim(i1) #15000 37
mx_name <- i1[1,]
dim(mx_name) #1 37
mx_rows <- dim(t(i1))[2]-1 #14999
mx_rows #14999
mx_ratio <- 1 + mx_rows %/% 250 #1+59=60
mx_ratio #60
#2 to 251 
#252 to 501
#etc
#250(n-1)+2 to 250n+1
#for ( i in 1:2 ) {
for ( i in 1:(mx_ratio-1) ) {
from1 <- 250*(i - 1) + 2
end1 <- 250*i + 1
#want file name rule: 28SL_Migration__Bulk_Upload_0xx_start_0xxxx_end_0xxxx
num1 <- paste( "00", i, sep="" )
num1_r3 <- substr(num1, nchar(num1)-2, nchar(num1)) #0xx

num2 <- paste( "0000", from1-1, sep="" )
num2_r5 <- substr(num2, nchar(num2)-4, nchar(num2)) #0xxxx

num3 <- paste( "0000", end1-1, sep="" )
num3_r5 <- substr(num3, nchar(num3)-4, nchar(num3)) #0xxxx

mx_split <- rbind(mx_name, i1[from1:end1, ])
filename1 <- paste( "28SL_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".xls", sep="" )
#write.csv(x = mx_split, col.names=FALSE, file = filename1)
#will save as xlsx or xls
write.xlsx(mx_split, file = filename1, sheetName="Sheet1",  col.names=FALSE, row.names=FALSE, append=FALSE, showNA=TRUE)
#write.table( mx_split, file = filename1, sep= "\t", quote = FALSE, col.names=FALSE, row.names=FALSE)
#write.xlsx(x = mx_split, col.names = FALSE, file = filename1)
}
##for the last excel, due to rows might != 250ea
for ( i in mx_ratio:mx_ratio ) {
from1 <- 250*(i - 1) + 2
#end1 <- 250*i + 1
#want file name rule: 28SL_Migration__Bulk_Upload_0xx_start_0xxxx_end_0xxxx
num1 <- paste( "00", i, sep="" )
num1_r3 <- substr(num1, nchar(num1)-2, nchar(num1)) #0xx

num2 <- paste( "0000", from1-1, sep="" )
num2_r5 <- substr(num2, nchar(num2)-4, nchar(num2)) #0xxxx

num3 <- paste( "0000", dim(i1)[1]-1, sep="" )
num3_r5 <- substr(num3, nchar(num3)-4, nchar(num3)) #0xxxx

mx_split <- rbind(mx_name, i1[from1:dim(i1)[1], ])
filename1 <- paste( "28SL_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".xls", sep="" )
write.table( mx_split, file = filename1, sep= "\t", quote = FALSE, col.names=FALSE, row.names=FALSE)
}
####################################################end
####################################################end
####################################################end

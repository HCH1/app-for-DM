#library(dplyr)
#library(xlsx)
##for 28slphv
#i1 = read.csv("20180531_LPO_draft5_28slphv for Thomas L and Tom M v3.5 - Copy.csv", header = FALSE, stringsAsFactors=FALSE)
##for 28g
i1 = read.csv("20180531_LPO_draft5_28g for Amir K and Tom M v7.5 - Copy.csv", header = FALSE, stringsAsFactors=FALSE)
dim(i1) #110000 37
mx_name <- i1[1,]
dim(mx_name) #1 37
mx_rows <- dim(t(i1))[2]-1 #14999
mx_rows #14999
mx_ratio <- 1 + mx_rows %/% 1000 #1+59=60
mx_ratio #60
#2 to 251 
#252 to 501
#etc
#1000(n-1)+2 to 1000n+1
#for ( i in 1:2 ) {
for ( i in 1:(mx_ratio-1) ) {
from1 <- 1000*(i - 1) + 2
end1 <- 1000*i + 1
#want file name rule: 28SL_Migration__Bulk_Upload_0xx_start_0xxxx_end_0xxxx
num1 <- paste( "00", i, sep="" )
num1_r3 <- substr(num1, nchar(num1)-2, nchar(num1)) #0xx

num2 <- paste( "0000", from1-1, sep="" )
num2_r5 <- substr(num2, nchar(num2)-4, nchar(num2)) #0xxxx

num3 <- paste( "0000", end1-1, sep="" )
num3_r5 <- substr(num3, nchar(num3)-4, nchar(num3)) #0xxxx

mx_split <- rbind(mx_name, i1[from1:end1, ])
#1.1
#filename1 <- paste( "28SL_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".xlsx", sep="" )
#write.xlsx( mx_split, file = filename1, sheetName="Sheet1",  col.names=FALSE, row.names=FALSE, append=FALSE, showNA=TRUE )
#1.2
##1.2.1 for 28slphv
#filename1 <- paste( "28SL_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".csv", sep="" )
##1.2.2 for 28g
filename1 <- paste( "28G_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".csv", sep="" )
write.table( x = mx_split, file = filename1, sep=",",  col.names=FALSE, row.names=FALSE )
#write.csv(x = mx_split, col.names=FALSE, file = filename1)
#will save as xlsx or xls
#write.table( mx_split, file = filename1, sep= "\t", quote = FALSE, col.names=FALSE, row.names=FALSE)
#write.xlsx(x = mx_split, col.names = FALSE, file = filename1)
}
##for the last excel, due to rows might != 1000ea
for ( i in mx_ratio:mx_ratio ) {
from1 <- 1000*(i - 1) + 2
#end1 <- 1000*i + 1
#want file name rule: 28SL_Migration__Bulk_Upload_0xx_start_0xxxx_end_0xxxx
num1 <- paste( "00", i, sep="" )
num1_r3 <- substr(num1, nchar(num1)-2, nchar(num1)) #0xx

num2 <- paste( "0000", from1-1, sep="" )
num2_r5 <- substr(num2, nchar(num2)-4, nchar(num2)) #0xxxx

num3 <- paste( "0000", dim(i1)[1]-1, sep="" )
num3_r5 <- substr(num3, nchar(num3)-4, nchar(num3)) #0xxxx

mx_split <- rbind(mx_name, i1[from1:dim(i1)[1], ])
##1.2.1 for 28slphv
#filename1 <- paste( "28SL_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".csv", sep="" )
##1.2.2 for 28g
filename1 <- paste( "28G_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".csv", sep="" )
write.table( x = mx_split, file = filename1, sep=",",  col.names=FALSE, row.names=FALSE )
}
####################################################end
####################################################end
####################################################end

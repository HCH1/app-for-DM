#library(dplyr)
#library(xlsx)
i1 = read.csv("2018_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur,slphv,lpse - Copy6 V4 for Tom.csv", header = FALSE, stringsAsFactors=FALSE)
dim(i1)
mx_name <- i1[1,]
dim(mx_name)
mx_rows <- dim(t(i1))[2]-1 #4999
mx_rows
mx_ratio <- 1 + mx_rows %/% 250 #1+59=60
mx_ratio
#2 to 251 
#252 to 501
#etc
#250(n-1)+2 to 250n+1
#for ( i in 1:2 ) {
for ( i in 1:mx_ratio ) {
from1 <- 250*(i - 1) + 2
end1 <- 250*i + 1
mx_split <- rbind(mx_name, i1[from1:end1, ])
filename1 <- paste( "28SL_Migration__Bulk_Upload_", i, "_start_", from1-1, "_end_", end1-1, ".xls", sep="" )
#write.csv(x = mx_split, col.names=FALSE, file = filename1)
write.table( mx_split, file = filename1, sep= "\t", quote = FALSE, col.names=FALSE, row.names=FALSE)
#write.xlsx(x = mx_split, col.names = FALSE, file = filename1)
}
####################################################end
####################################################end
####################################################end

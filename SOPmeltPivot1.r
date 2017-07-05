#https://stackoverflow.com/questions/24858823/extract-data-from-pivot-table-to-data-frame-i-e-reverse-the-pivot
#install.packages("reshape2")
#library(reshape2)
i1 = read.csv("0705DTT.csv", header = TRUE)
o1 <- melt(i1, id.vars = "Structure")
write.csv(x = o1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT.csv", sep = "") )

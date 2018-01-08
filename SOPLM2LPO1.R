#input csv
i1 = read.csv("LM-0053.175 Export_Layers_By_LMT.csv", header = TRUE)
i2 = read.csv("LPO-000242.csv", header = TRUE)
dim(i1)
dim(i2)
coln2 <- colnames(i2)
coln2[1] <- c("Number")
str(coln2)
dumx3 <- matrix( NA, nrow=dim(i1)[1], ncol=3 )
dumx4 <- matrix( NA, nrow=dim(i1)[1], ncol=4 )
dumx5 <- matrix( NA, nrow=dim(i1)[1], ncol=5 )
dim(dumx0)
mx1 <- cbind( i1[1],i1[3],i1[2],dumx5,i1[5],dumx3,i1[4],dumx3,i1[7],i1[8],i1[9],i1[10],dumx4 )
colnames(mx1) <- coln2[1:dim(t(mx1))[1]]
str(mx1)
write.csv(x = mx1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft1.csv", sep = "") )
####################################################end
####################################################end
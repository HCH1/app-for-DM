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
for footstop "."
dumx_fs <- matrix( ".", nrow=dim(i1)[1], ncol=1 )
dim(dumx0)
#create LPO_draft
mx1 <- cbind( i1[1],i1[3],i1[2],dumx5,
#create "." or ".." at the end
paste( i1$Description, dumx_fs, sep = "", collapse = NULL ),
dumx3,i1[4],dumx3,i1[7],i1[8],i1[9],i1[10],dumx4 )
#replace colnames base on formal LPO
colnames(mx1) <- coln2[1:dim(t(mx1))[1]]
#replace ".." -> "."
mx1$Layer.Description <- gsub("[.]{2}", ".", mx1$Layer.Description )
str(mx1)
write.csv(x = mx1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft1.csv", sep = "") )
####################################################end
####################################################end

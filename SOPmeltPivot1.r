#https://stackoverflow.com/questions/24858823/extract-data-from-pivot-table-to-data-frame-i-e-reverse-the-pivot
#install.packages("reshape2")
#library(reshape2)
i1 = read.csv("0927DTT.csv", header = TRUE)
i2 <- i1
o1 <- melt(i2, id.vars = "Structure", warn = FALSE)

o1 <- o1[order(o1[3]), ]
o1 <- o1[order(o1[2]), ]
o1 <- o1[order(o1[1]), ]
write.csv(x = o1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT.csv", sep = "") )

o2 <- o1
o2_0 <- o2[ which( o2[3]=="0" ), ]
write.csv(x = o2_0, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_0.csv", sep = "") )

o2_1 <- o2[ which( o2[3]=="1" ), ]
write.csv(x = o2_1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_1.csv", sep = "") )

#o2_x <- o2[ which( o2[3]=="x" ), ]
#write.csv(x = o2_x, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_x.csv", sep = "") )
#
o2_col1_uni <- unique(o2_0[1])

o22 <- o2_0[-3]
#o22$x <- paste( "touching {", collapse = NULL )
#o22$y <- paste( "}", collapse = NULL )
#o22 <- cbind(o22[1], o22[4], o22[3], o22[2])

o22_1 <- o2_1[-3]

ans1 <- matrix( NA, nrow=dim(o2_col1_uni)[1], ncol=1 ) #create dummy n*1
ans2 <- matrix( NA, nrow=dim(o2_col1_uni)[1], ncol=1 ) #create dummy n*1
for ( i in 1:dim(o2_col1_uni)[1] ){
#val = 1
o222_1 <- o22_1[o22_1[1]==paste( o2_col1_uni[i,],collapse=" " ), ]
o222t_vec_1 <- as.vector(t(o222_1))
o222t_vec_uni_1 <- o222t_vec_1[!duplicated(o222t_vec_1)]
o222t_vec_uni_1 <- paste( t(o222t_vec_uni_1), collapse=" " )
#
o222_1_col1 <- o222_1
o222_1_col1 <- o222_1_col1[-1]
o222t_vec_1_col1 <- as.vector(t(o222_1_col1))
o222t_vec_uni_1_col1 <- o222t_vec_1_col1[!duplicated(o222t_vec_1_col1)]
o222t_vec_uni_1_col1 <- paste( t(o222t_vec_uni_1_col1), collapse=" " )
#val = 0
o222 <- o22[o22[1]==paste( o2_col1_uni[i,],collapse=" " ), ]
o222 <- o222[-1]
o222t_vec <- as.vector(t(o222))
o222t_vec_uni <- o222t_vec[!duplicated(o222t_vec)]
o222t_vec_uni <- paste( t(o222t_vec_uni), collapse=" " )
#{A} touching {B} is prohibited.
ans1[i] <- paste( "{", o222t_vec_uni_1, "}","touching", "{", o222t_vec_uni, "} is prohibited.", collapse=" " )
ans2[i] <- paste( "{", o222t_vec_uni_1_col1, "}","touching", "{", o222t_vec_uni, "} is prohibited.", collapse=" " )
}
#
write.csv(x = ans1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_touching_0_prohibited.csv", sep = "") )
write.csv(x = ans2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_touching_0_prohibited_v2.csv", sep = "") )
#
ans22 = read.csv(file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_touching_0_prohibited_v2.csv", sep = ""), header = TRUE)
ans22 <- ans22[order(ans22[2]), ]
ans222 <- unique(ans22[2])
ans22 <- ans22[-1]
dim(ans22)
dim(ans222)
write.csv(x = ans22, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_touching_0_prohibited_v2order.csv", sep = "") )
write.csv(x = ans222, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_touching_0_prohibited_v2_uni.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end

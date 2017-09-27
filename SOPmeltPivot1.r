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

o2 <- o1[ which( o1[3]=="0" ), ]
write.csv(x = o2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_0.csv", sep = "") )

o2_col1_uni <- unique(o2[1])

o22 <- o2[-3]
o22$x <- paste( "touching {", collapse = NULL )
o22$y <- paste( "}", collapse = NULL )


o22 <- cbind(o22[1], o22[4], o22[3], o22[2])

o22 <- o22[o22[1]==paste( o2_col1_uni[1,],collapse=" " ), ]
o22t_vec <- as.vector(t(o22))
o22t_vec_uni <- o22t_vec[!duplicated(o22t_vec)]
o22t_vec_uni <- paste( t(o22t_vec_uni), collapse=" " )
o22t_vec_uni <- paste( "{", o22t_vec_uni, "} is prohibited.", collapse=" " )
write.csv(x = o22t_vec_uni, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_o22t_vec_uni.csv", sep = "") )

#A touching {B} is prohibited.



dim(o2_col2_uni)
dim(o1)
dim(o2)



####################################################end
####################################################end
####################################################end
####################################################end
####################################################end
####################################################end
####################################################end
####################################################end
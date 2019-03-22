#input csv
diffdm = read.csv("22FDX_Rev1.3_3.0_PRE01_D1vs22FDX_Rev1.3_2.0_20180423DRCTrack.csv", header = TRUE)
#extract 3 columns
diffdm1 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
str(diffdm1)
##replace df text, use gsub, only can add new col.
#diffdm1$v1 <- gsub("Same", "Updated", diffdm1$Type)
#diffdm1
#filter Type
diffdm2 <- diffdm1[ which( diffdm1[2]=="Added"|diffdm1[2]=="Removed"|diffdm1[2]=="Modified"|diffdm1[2]=="Same"), ]
#order Section
diffdm2 <- diffdm2[order(diffdm2[1]), ]
#length(t(diffdm4_uni)) == 113
diffdm4_uni <- unique(diffdm2[1]) 
#create dummy 113*1
ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 ) 

#write a loop, run 113ea
for ( i in 1:length(t(diffdm4_uni)) ){
#filter the i-th Scetion, e.g. i=1 to 113 
a3 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[i,],collapse=" " ), ]
#e.g. 1st Section, then extract columns of "Type & Rule"
#due to we want to merge them
a4 <- cbind( a3[2], a3[3] ) #n*2 matrix
a4t <- as.matrix( t(a4) ) #2*n matrix
a4tv <- as.vector(a4t) #convert to line
#due to repeat "Added or Removed or Modified", so need to do de-duplicated this vector
a4t_v_d <- a4tv[!duplicated(a4tv)]
#lines -> character (~ 1*1)
a5 <- paste( t(a4t_v_d),collapse=" " )
#save to i-th row
ans_o1[i] <- a5
}
#create opuput format
ans_o2 <- cbind( diffdm4_uni, ans_o1 )
write.csv(x = ans_o2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist.csv", sep = "") )
####################################################end
####################################################end
####################################################end
###create a col follow DCC format.
##load GR csv
gr_ref1 = read.csv("130BCDLITE_Rev1.0_4.0_DRC02_internal.psv.csv", header = TRUE)
str(gr_ref1)
##need table title and ID
gr_ref1_v2 <- gr_ref1[8:9]
colnames(gr_ref1_v2)[1] <- "Section"
str(gr_ref1_v2)
##de-duplicate
gr_ref1_v2 <- unique(gr_ref1_v2)
#str(gr_ref1_v2)
write.csv(x = gr_ref1_v2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "gr_ref1_v2.csv", sep = "") )
##vlookup base on rev logs
ans_o3 <- left_join(ans_o2, gr_ref1_v2, by = "Section")
#str(ans_o3)
ans_o3 <- ans_o3[ order(ans_o3[3]), ] #order reverse
#str(ans_o3)
##create dummy n*1
ans_o2_dmy <- matrix( NA, nrow=dim(ans_o2)[1], ncol=1 )
ans_o2_dmy[ is.na( ans_o2_dmy ) ] <- "Section"
#str(ans_o2_dmy)
#ans_o4 <- cbind(ans_o3[1:2], ans_o2_dmy[1], ans_o3[3], ans_o3[2])
ans_o4 <- cbind(ans_o3, ans_o2_dmy)
#str(ans_o4)
###if want to connect col texts, use paste and save as new col.
ans_o4$id.for.DCC <- paste(ans_o4$ans_o2_dmy, ans_o4$Table.ID, sep=" ")
#str(ans_o4)
ans_o4 <- cbind(ans_o4, ans_o4[2])
#str(ans_o4)
write.csv(x = ans_o4, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist_id.csv", sep = "") )
####################################################end
####################################################end
####################################################end

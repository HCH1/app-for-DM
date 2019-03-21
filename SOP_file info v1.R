###https://stackoverflow.com/questions/33018282/list-file-information-in-a-text-file-for-all-the-files-in-a-directory
###http://astrostatistics.psu.edu/su07/R/html/base/html/file.info.html
locpath <- getwd()
locpath_bf <- file.path( locpath, "Images" )
locpath_af <- file.path( locpath, "Images2" )
###https://stat.ethz.ch/pipermail/r-help/2010-October/255439.html
###extract files info with correct path
#f1 <- file.info( list.files( path = "." ) ) #this is getwd()
f1bf <- file.info( list.files( path = locpath_bf, full.names=TRUE ) )
f1af <- file.info( list.files( path = locpath_af, full.names=TRUE  ) )
#write.csv(x = f1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info v1.csv", sep = "") )
write.csv(x = f1bf, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = "") )
write.csv(x = f1af, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = "") )
###read info only 1-2 cols
i1bf = read.csv( file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = ""), header = TRUE, stringsAsFactors=FALSE)
i1bf_v1 <- i1bf[1:2]
i1af = read.csv( file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = ""), header = TRUE, stringsAsFactors=FALSE)
i1af_v1 <- i1af[1:2]
str(i1bf_v1)
str(i1af_v1)
###full path -> only need base name
i1bf_v1$file.type <- basename( i1bf_v1[,1] )
i1af_v1$file.type <- basename( i1af_v1[,1] )
str(i1bf_v1)
str(i1af_v1)
###vlookup full matrix
#i1bfaf_v1_diff <- left_join(i1bf_v1[1:2], i1bf_v1[1:2], by = "X")
i1bfaf_v1_diff <- full_join(i1af_v1, i1bf_v1, by = "file.type")
str(i1bfaf_v1_diff)
###verify size if diff
i1bfaf_v1_diff$size.diff <- ifelse(i1bfaf_v1_diff$size.x != i1bfaf_v1_diff$size.y
,"1","2")
str(i1bfaf_v1_diff)
###re-order
i1bfaf_v1_diff <- i1bfaf_v1_diff[ order( i1bfaf_v1_diff[ dim(i1bfaf_v1_diff)[2] ] ), ] #order reverse
str(i1bfaf_v1_diff)
###save as
write.csv(x = i1bfaf_v1_diff, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af bf diff.csv", sep = "") )
####################################################end
####################################################end
####################################################end

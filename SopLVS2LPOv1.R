library(dplyr)
i1 = readLines("cmos28g_tech - Copy lm.txt", warn = FALSE)
length(i1)
i1v1 <- i1

fw1 <- gregexpr( pattern ="[|]", i1v1[60] ) #find position
str(fw1)
char1 <- as.character(fw1) #c(17, 34, 42, 50, 63, 71, 92, 103, 112, 131)
df1 <- as.data.frame(fw1) #10r
df2 <- rbind(c(0), df1) #11r
df2v2 <- df2[ -dim(df2)[1], ] #10r
fw1_gap <- df1 - df2v2 #shift row
#fw1_gap2 <- fw1_gap[ -dim(fw1_gap)[1], ]
fw1_gap2 <- as.character(fw1_gap) #c(17, 17, 8, 8, 13, 8, 21, 11, 9, 19)
t1 = read.fwf( "cmos28g_tech - Copy lm.txt", skip=60, width = fw1_gap2 ) #split by fixed width
#t1 = read.fwf( "cmos28g_tech - Copy lm.txt", skip=60, width = as.character(fw1_gap) )
str(t1)
head(t1)
#colnames(t1) <- c("Layer Name","Purpose Name","Layer no","Data type","Material","Mask","Qualifier","Photo","Color","Layer Name")
write.csv(x = t1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LVS_lm1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end



i1v1 <- grep("^[A-z0-9]", i1, value = TRUE)
length(i1v1)
write.csv(x = i1v1, row.names = FALSE, file = "cmos28g_tech - Copy lm2.txt")





t2 = read.fwf( "cmos28g_tech - Copy lm.txt", width = c(17, 34, 42, 50, 63, 71, 92, 103, 112) )
head(t2)
str(t2)

grepl("[|]", strsplit( i1[60],"" ) )
table( strsplit( i1[60],"" ) )
str( strsplit( i1[60],"" ) )
str(i1[60])
#gregexpr( pattern ='|', strsplit( i1[60],"" ) )
t11 = read.fwf("cmos28g_tech - Copy lm.txt", width=c(17, 34, 42, 50, 63, 71))
head(t11)




i1v1 <- grep("^[A-z0-9]", i1, value = TRUE)
length(i1v1)
i1v2 <- gsub("[ ]{1,99}", "\\t", i1v1)
head(i1v2)
i1v3 <- strsplit(i1v2, " ")
length(i1v3)
head(i1v3)
str(i1v3)

i1v4 <- as.data.frame( unlist(i1v3) )
dim(i1v4)
write.csv(x = i1v4, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LVS_lm1.csv", sep = "") )




#i1v3 <- c(i1v2)
#i1v3 <- as.data.frame(i1v2)
#dim(i1v3)
write.csv(x = i1v2, row.names = FALSE, file = "i1v2.csv")

my_data <- read.table(file.choose(), 
                      sep ="|", header = TRUE, dec =".")
					  
i2 = read.csv2("i1v2.csv", header = TRUE, stringsAsFactors=FALSE)
dim(i2)


i3 <- read.delim("i1v2.csv", header = TRUE, sep = " ", quote = "\"",
           dec = ".", fill = TRUE, comment.char = "" )
dim(i3)

i2 = read.csv("i1v2.csv", header = TRUE, stringsAsFactors=FALSE)



write.table(x = i1v3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LVS_lm1.csv", sep = "") )



i2 = read.csv("LPO-000253.csv", header = TRUE, stringsAsFactors=FALSE)
dim(i1) #24c
dim(i2) #37c
coln2 <- colnames(i2)
coln2[1] <- c("Number")
str(coln2)
dumx3 <- matrix( NA, nrow=dim(i1)[1], ncol=3 )
dumx4 <- matrix( NA, nrow=dim(i1)[1], ncol=4 )
dumx5 <- matrix( NA, nrow=dim(i1)[1], ncol=5 )
dumx13 <- matrix( NA, nrow=dim(i1)[1], ncol=13 )
#footstop "."
dumx_fs <- matrix( ".", nrow=dim(i1)[1], ncol=1 )
dim(dumx0)
#create LPO_draft1
mx1 <- cbind( i1[1],i1[3],i1[2],dumx5,
#create "." or ".." at the end
paste( i1$Description, dumx_fs, sep = "", collapse = NULL ),
dumx3,i1[4],dumx3,i1[7],i1[8],i1[9],i1[10],dumx4,dumx13 )
#replace colnames base on formal LPO
dim(mx1)
colnames(mx1) <- coln2[1:dim(t(mx1))[1]]
#replace ".." -> "."
mx1$Layer.Description <- gsub("[.]{2}", ".", mx1$Layer.Description )
#replace start is "." -> ""
mx1$Layer.Description <- gsub("^[.]{1}", "", mx1$Layer.Description )
str(mx1)
mx11 <- mx1
#replace NA -> blank
mx11[is.na(mx11)] <- ""
str(mx11)
write.csv(x = mx11, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft1.csv", sep = "") )
#library(dplyr)
mx1_v2 <- mx11
#vs 22's LPO
#i2_v2 <- cbind( i2[2:7],i2[9],i2[10],i2[11],i2[13],i2[17:24] )
#i2_v2 <- cbind( i2[2:dim(t(mx1))[1]] )
#dim(i2_v2)
#mx1_v2 <- left_join(mx1_v2, i2_v2, by = "Data.Layer.Name")
#vlookup
mx1_v2 <- left_join(mx11, i2, by = "Data.Layer.Name")
str(mx1_v2)
mx1_v3 <- mx1_v2
#replace NA -> blank
mx1_v3[is.na(mx1_v3)] <- ""
str(mx1_v3)
write.csv(x = mx1_v3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft2.csv", sep = "") )
#re-cbind draft LPO
mx2 <- cbind( mx1_v3[1:3], mx1_v3[40:44], mx1_v3[9], mx1_v3[46:48], mx1_v3[13]
, mx1_v3[50:52], mx1_v3[17:20], mx1_v3[57:73] )
str(mx2)
write.csv(x = mx2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft3.csv", sep = "") )
#replace
mx22 <- mx2
mx22[is.na(mx22)] <- ""
str(mx22)

mx22$Layer.Technology.Node.y <- gsub("22FD", "28SL"
, mx22$Layer.Technology.Node.y)

mx22$Tech.Variant...Included.in.PDK.y <- gsub("22FDX", "28SLP-HV;28LPSe;28SLP;28HPP"
, mx22$Tech.Variant...Included.in.PDK.y)

mx22$Cadence.Material.Type.Qualifier.y <- gsub("NIL", "NA"
, mx22$Cadence.Material.Type.Qualifier.y)
, mx22$Cadence.Material.Type.Qualifier.y)

mx22$Cadence.Photo.Mask.Color.Color.State.y <- gsub("NIL", "NA"
, mx22$Cadence.Photo.Mask.Color.Color.State.y)

mx22[is.na(mx22)] <- ""
str(mx22)
write.csv(x = mx22, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4.csv", sep = "") )
##
#merge(a, b, all = TRUE)
#l1 <- list(a,b)
#ldply(l1, data.table)
mx33 <- cbind( mx22[4:7], mx22[10:14] )
dumx2 <- matrix( NA, nrow=1, ncol=1 )
for ( i in 1:dim(t(mx33))[1] ){
tb1 <- table( mx33[i] )
tb2 <- as.data.frame( tb1 )
#tb2 <- as.data.frame( tb1, row.names = TRUE )
dumx2 <- merge( dumx2, tb2, all = TRUE )
}
write.csv(x = dumx2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_freq4.csv", sep = "") )
####################################################end
####################################################end
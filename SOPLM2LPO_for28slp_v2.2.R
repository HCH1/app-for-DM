library(dplyr)
i1 = read.csv("LM-0053.183 Export_Layers_By_LMT.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("LPO-000292.csv", header = TRUE, stringsAsFactors=FALSE)
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
mx1 <- cbind( paste( i1$Input.GDS.Number, i1$Input.GDS.Data.Type, sep = ";", collapse = NULL ) #combine gds# as unique
,i1[3],i1[2],dumx5
#create "." or ".." at the end
,paste( i1$Description, dumx_fs, sep = "", collapse = NULL ),
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
mx11[is.na(as.character(mx11))] <- ""
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
i2v1 <- i2
str(i2v1)
i2v2 <- cbind( paste( i2v1$GDS.Number, i2v1$GDS.Datatype, sep = ";", collapse = NULL ), i2v1 )
colnames(i2v2)[1] <- "Number"
mx1_v2 <- left_join(mx11, i2v2, by = "Number")
#mx1_v2 <- left_join(mx11, i2, by = "Data.Layer.Name")
str(mx1_v2)
mx1_v3 <- mx1_v2
#replace NA -> blank
mx1_v3[is.na(as.character(mx1_v3))] <- ""
dim(mx1_v3)
mx1_v3 <- mx1_v3[-38]
dim(mx1_v3)
str(mx1_v3)
write.csv(x = mx1_v3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft2.csv", sep = "") )
#re-cbind draft LPO
mx2 <- cbind( mx1_v3[1:3], mx1_v3[40:44], mx1_v3[9], mx1_v3[46:48], mx1_v3[13]
, mx1_v3[50:52], mx1_v3[17:20], mx1_v3[57:73] )
str(mx2)
write.csv(x = mx2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft3.csv", sep = "") )
#replace
mx22 <- mx2
mx22[is.na(as.character(mx22))] <- ""
str(mx22)

mx22$Layer.Technology.Node.y <- gsub("22FD", "28SL"
, mx22$Layer.Technology.Node.y)

mx22$Tech.Variant...Included.in.PDK.y <- gsub("22FDX", "28SLPHV;28SLP"
, mx22$Tech.Variant...Included.in.PDK.y)

mx22$Cadence.Material.Type.Qualifier.y <- gsub("NIL", "NA"
, mx22$Cadence.Material.Type.Qualifier.y)
, mx22$Cadence.Material.Type.Qualifier.y)

mx22$Cadence.Photo.Mask.Color.Color.State.y <- gsub("NIL", "NA"
, mx22$Cadence.Photo.Mask.Color.Color.State.y)

mx22[is.na(as.character(mx22))] <- ""
str(mx22)
write.csv(x = mx22, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4.csv", sep = "") )
####################################################end
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
##1 prepare .lm data #+6 col AL-AQ
lvs_lm1 = read.csv("cmos28slp_hv_tech - Copy lm2.csv", header = FALSE, stringsAsFactors=FALSE)
str(lvs_lm1)
lvs_lm2 <- lvs_lm1
lvs_lm2 <- cbind( paste( lvs_lm1$V3, lvs_lm1$V4, sep = ";", collapse = NULL ) #combine gds# as unique
,lvs_lm1[1:4],paste( lvs_lm1$V5, lvs_lm1$V6, sep = " ", collapse = NULL )
#,lvs_lm1[8])
)
str(lvs_lm2)
lm_name <- c("Number","Cadence.Layer.Name.x","Cadence.Layer.Purpose.y","GDS.Number.x"
,"GDS.Datatype.x","Cadence.Material.Type.Qualifier.y"
#,"Data.Layer.Name.x")
)
colnames(lvs_lm2) <- lm_name
str(lvs_lm2)
#left_join
lvs_lm3 <- left_join(mx22, lvs_lm2, by = "Number")
str(lvs_lm3)
lvs_lm3[is.na(as.character(lvs_lm3))] <- ""
str(lvs_lm3)
write.csv(x = lvs_lm3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm.csv", sep = "") )
####################################################end
##2 prepare .om data #+3 col AR-AT
lvs_om1 = read.csv("cmos28slp_hv_tech - Copy om.csv", header = FALSE, stringsAsFactors=FALSE)
str(lvs_om1)
lvs_om2 <- lvs_om1
lvs_om2 <- cbind( paste( lvs_om1$V4, lvs_om1$V5, sep = ";", collapse = NULL ) #combine gds# as unique
#,lvs_om1[7]
,lvs_om1[3],lvs_om1[1])
str(lvs_om2)
om_name <- c("Number"
#,"Data.Layer.Name.x"
,"Cadence.Layer.Name.x","Cadence.Layer.Purpose.y")
colnames(lvs_om2) <- om_name
str(lvs_om2)
#left_join
lvs_om3 <- left_join(lvs_lm3, lvs_om2, by = "Number")
str(lvs_om3)
lvs_om3[is.na(lvs_om3)] <- ""
str(lvs_om3)
write.csv(x = lvs_om3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm,om.csv", sep = "") )
####################################################end
##3.1 prepare .tf OA layer & ic oa layer #+1 col AU
#tf_oa_lay0 = read.csv("cmos28g_tech - Copy tf OA layer.csv", header = TRUE, stringsAsFactors=FALSE)
#ic_oa_lay0 = read.csv("cdsDefTechLib_IC616 - Copy ic oa lay.csv", header = TRUE, stringsAsFactors=FALSE)
#colnames(ic_oa_lay0) <- colnames(tf_oa_lay0)
#tf_oa_lay1 <- rbind(tf_oa_lay0, ic_oa_lay0)
#str(tf_oa_lay1)
#
tf_oa_lay1 = read.csv("cmos28slp_hv_tech vs 32g - Copy tf OA layer.csv", header = TRUE, stringsAsFactors=FALSE)
tf_oa_lay2 <- tf_oa_lay1[,-3]
#tf_oa_lay2 <- cbind( paste( tf_oa_lay1$V4, tf_oa_lay1$V5, sep = ";", collapse = NULL ) #ctf_oa_laybine gds# as unique
#,tf_oa_lay1[7],tf_oa_lay1[3],tf_oa_lay1[1])
str(tf_oa_lay2)
tf_oa_lay_name <- c("Cadence.Layer.Name.x.y","Cadence.Name.OA.Number.y")
colnames(tf_oa_lay2) <- tf_oa_lay_name
str(tf_oa_lay2)
#left_join, align .lm data
tf_oa_lay3 <- left_join(lvs_om3, tf_oa_lay2, by = "Cadence.Layer.Name.x.y")
str(tf_oa_lay3)
tf_oa_lay3[is.na(tf_oa_lay3)] <- ""
str(tf_oa_lay3)
write.csv(x = tf_oa_lay3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm,om,tf_ic_oa_lay.csv", sep = "") )
####################################################end
##3.2 prepare .tf OA purpose & ic oa purpose #+1 col AV
#tf_oa_pur0 = read.csv("cmos28g_tech - Copy tf OA purpose.csv", header = TRUE, stringsAsFactors=FALSE)
#ic_oa_pur0 = read.csv("cdsDefTechLib_IC616 - Copy ic oa pur.csv", header = TRUE, stringsAsFactors=FALSE)
#ic_oa_pur0 <- ic_oa_pur0[-3]
#colnames(ic_oa_pur0) <- colnames(tf_oa_pur0)
#tf_oa_pur1 <- rbind(tf_oa_pur0, ic_oa_pur0)
#str(tf_oa_pur1)
#
tf_oa_pur1 = read.csv("cmos28slp_hv_tech vs 32g - Copy tf OA purpose.csv", header = TRUE, stringsAsFactors=FALSE)
tf_oa_pur2 <- tf_oa_pur1
#tf_oa_pur2 <- cbind( paste( tf_oa_pur1$V4, tf_oa_pur1$V5, sep = ";", collapse = NULL ) #ctf_oa_purbine gds# as unique
#,tf_oa_pur1[7],tf_oa_pur1[3],tf_oa_pur1[1])
str(tf_oa_pur2)
tf_oa_pur_name <- c("Cadence.Layer.Purpose.y.y","Cadence.Purpose.OA.Number.y")
colnames(tf_oa_pur2) <- tf_oa_pur_name
str(tf_oa_pur2)
#left_join, align .lm data
tf_oa_pur3 <- left_join(tf_oa_lay3, tf_oa_pur2, by = "Cadence.Layer.Purpose.y.y")
str(tf_oa_pur3)
tf_oa_pur3[is.na(tf_oa_pur3)] <- ""
str(tf_oa_pur3) #has col A-AV
write.csv(x = tf_oa_pur3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur.csv", sep = "") )
####################################################end
##4 vs 28SLP-HV ch2 #+4 col
slphv1 = read.csv("28SLP-HV_Rev0.1_0.0 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(slphv1)
slphv2 <- slphv1
slphv2 <- cbind( paste( slphv1$v3, slphv1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
,slphv1[2],slphv1[5],slphv1[3:4] )
str(slphv2)
slphv_name <- c("Number","Data.Layer.Name","Layer.Description.x"
,"GDS.Number.x.x","GDS.Datatype.x.x")
colnames(slphv2) <- slphv_name
str(slphv2)
slphv22 <- slphv2[ which( slphv2[1]!="-;-" ), ]
str(slphv22)
#left_join
slphv3 <- left_join(tf_oa_pur3, slphv22, by = "Number")
str(slphv3)
slphv3[is.na(slphv3)] <- ""
str(slphv3) #add 4 new col AW-AZ
write.csv(x = slphv3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur,slphv.csv", sep = "") )
####################################################end
##4.2 vs 28LPSe ch2 #+4 col
lpse1 = read.csv("28LPSe_Rev1.0_3.0 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(lpse1)
lpse2 <- lpse1
lpse2 <- cbind( paste( lpse1$v3, lpse1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
,lpse1[2],lpse1[5],lpse1[3:4] )
str(lpse2)
lpse_name <- c("Number","Data.Layer.Name.x","Layer.Description.x.x"
,"GDS.Number.x.x.x","GDS.Datatype.x.x.x")
colnames(lpse2) <- lpse_name
str(lpse2)
lpse22 <- lpse2[ which( lpse2[1]!="-;-" ), ]
str(lpse22)
#left_join
lpse3 <- left_join(slphv3, lpse22, by = "Number")
str(lpse3)
lpse3[is.na(lpse3)] <- ""
str(lpse3) #add 4 new col BA-BD
#combine OA# as unique put in 1st col
lpse4 <- cbind( paste( lpse3$Cadence.Name.OA.Number.y.x, lpse3$Cadence.Purpose.OA.Number.y.x, sep = ";", collapse = NULL ) 
, paste( lpse3$Cadence.Name.OA.Number.y.y, lpse3$Cadence.Purpose.OA.Number.y.y, sep = ";", collapse = NULL ) 
, lpse3 )
colnames(lpse4)[1] <- "oa.ref.only.22fdx"
colnames(lpse4)[2] <- "oa.from.lvs"
str(lpse4)
write.csv(x = lpse4, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur,slphv,lpse.csv", sep = "") )
####################################################end
##replace whole col values, lvs lmt data is key, 22 is only ref
lpse4$Cadence.Layer.Name.x.x <- lpse4$Cadence.Layer.Name.x.y
lpse4$Cadence.Layer.Purpose.y.x <- lpse4$Cadence.Layer.Purpose.y.y
lpse4$Oasis.Number.x <- lpse4$GDS.Number.x.x.x.x
lpse4$Oasis.Datatype.x <- lpse4$GDS.Datatype.x.x.x.x
lpse4$Cadence.Material.Type.Qualifier.y.x <- lpse4$Cadence.Material.Type.Qualifier.y.y
lpse4$Cadence.Name.OA.Number.y.x <- lpse4$Cadence.Name.OA.Number.y.y
lpse4$Cadence.Purpose.OA.Number.y.x <- lpse4$Cadence.Purpose.OA.Number.y.y
lpse4 <- lpse4[order(lpse4[2]), ] #order oa.from.lvs
#ifelse as excel
lpse4$in.slphv <- ifelse(lpse4$GDS.Number.x.x.y > 0,"1","0")
lpse4$in.lpse <- ifelse(lpse4$GDS.Number.x.x.x.y > 0,"1","0")
#lpse4$in.lpse <- lpse4$GDS.Number.x.x.x.y > 0
lpse4$Tech.Variant.v1 <- ifelse(lpse4$in.slphv == 1 & lpse4$in.lpse == 1,"28SLP-HV;28LPSe"
	,ifelse(lpse4$in.slphv == 1 & lpse4$in.lpse == 0,"28SLP-HV"
	,ifelse(lpse4$in.slphv == 0 & lpse4$in.lpse == 1,"28LPSE","NA")))
lpse4$check.oa.lvs.22fdx <- ifelse(lpse4$oa.from.lvs != ";" & lpse4$oa.from.lvs %in% lpse4$oa.ref.only.22fdx,"1","0")
str(lpse4)
#table(lpse4[length(lpse4)-1])
#table(lpse4[length(lpse4)])
write.csv(x = lpse4, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur,slphv,lpse.csv", sep = "") )
####################################################end
####################################################end
####################################################end

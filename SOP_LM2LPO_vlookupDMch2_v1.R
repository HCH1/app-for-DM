library(dplyr)
##1 use draft 28slphv
#i1 = read.csv("201805_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur for 28slphv for Thomas L and Tom M v2.csv", header = TRUE, stringsAsFactors=FALSE)
i1 = read.csv("20180531_LPO_draft5_28slphv for Thomas L and Tom M v3.5.csv", header = TRUE, stringsAsFactors=FALSE)
dim(i1) #24c
i1$gds1 <- paste( i1$GDS.Number, i1$GDS.Datatype , sep = ";", collapse = NULL ) #combine gds# as unique
str(i1)
####################################################end
##1.1 draft vs 28SLP-HV_Rev0.1_0.0 ch2
slphv1 = read.csv("28SLP-HV_Rev0.1_0.0 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(slphv1)
dumx_slphv1 <- matrix( "1", nrow=dim(slphv1)[1], ncol=1 )
str(dumx_slphv1)
#slphv2 <- slphv1
slphv2 <- cbind( paste( slphv1$v3, slphv1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
#,slphv1[2],slphv1[5],slphv1[3:4] )
,dumx_slphv1[1],slphv1[5] )
slphv2 <- as.data.frame(slphv2)
str(slphv2)

slphv_name <- c("gds1","slphv.check","slphv.des")
colnames(slphv2) <- slphv_name
str(slphv2)
slphv22 <- slphv2[ which( slphv2[1]!="-;-" ), ]
str(slphv22)
#left_join
i1v1 <- left_join(i1, slphv22, by = "gds1")
str(i1v1)
i1v1[is.na(i1v1)] <- ""
str(i1v1) #add 1 new col
####################################################end
##1.2 draft vs 28SLP_Rev1.1_5.0_DRC02 ch2
slp1 = read.csv("28SLP_Rev1.1_5.0_DRC02 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(slp1)
dumx_slp1 <- matrix( "1", nrow=dim(slp1)[1], ncol=1 )
str(dumx_slp1)
#slp2 <- slp1
slp2 <- cbind( paste( slp1$v3, slp1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
#,slp1[2],slp1[5],slp1[3:4] )
,dumx_slp1[1],slp1[5] )
slp2 <- as.data.frame(slp2)
str(slp2)

slp_name <- c("gds1","slp.check","slp.des")
colnames(slp2) <- slp_name
str(slp2)
slp22 <- slp2[ which( slp2[1]!="-;-" ), ]
str(slp22)
#left_join
i1v2 <- left_join(i1v1, slp22, by = "gds1")
str(i1v2)
i1v2[is.na(i1v2)] <- ""
str(i1v2) #add 1 new col
####################################################end
##1.2.1 vlookup DM ch2, replace draft col
#let factor -> chr
i1v2$slphv.check <- as.character(i1v2$slphv.check)
i1v2$slp.check <- as.character(i1v2$slp.check)
#replace NA
i1v2[is.na(i1v2)] <- 0
#vlookup
i1v2$ans1 <- ifelse(i1v2$slphv.check == 1 & i1v2$slp.check == 1,"28SLPHV;28SLP"
, ifelse(i1v2$slphv.check == 1 & i1v2$slp.check == 0,"28SLPHV"
, ifelse(i1v2$slphv.check == 0 & i1v2$slp.check == 1,"28SLP","")))
str(i1v2)
head(i1v2,11)
i1v2$Tech.Variant...Included.in.PDK <- i1v2$ans1
i1v3 <- i1v2
#export 1-24 col
##clean description footstop.
dumx_fs <- matrix( ".", nrow=dim(i1v5)[1], ncol=1 )
i1v3 <- cbind(i1v3[1:24], i1v3[25]
, i1v3[26]
, paste( i1v3$slphv.des, dumx_fs, sep = "", collapse = NULL )
, i1v3[28]
, paste( i1v3$slp.des, dumx_fs, sep = "", collapse = NULL )
, i1v3[30]
)
str(i1v3)
#replace col name
coln1 <- colnames(i1v2)
colnames(i1v3) <- coln1
str(i1v3)
##replace ".." -> "."
i1v3$slphv.des <- gsub("[.]{2}", ".", i1v3$slphv.des )
i1v3$slp.des <- gsub("[.]{2}", ".", i1v3$slp.des )
write.csv(x = i1v3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft5_28slphv for Thomas L and Tom M v4.csv", sep = "") )
####################################################end
####################################################end
####################################################end
##2 use draft 28g
library(dplyr)
#i1 = read.csv("201805_LPO_draft4,lvs_lm,om,tf_ic_oa_lay,tf_ic_oa_pur for 28g for Amir K and Tom M v6.csv", header = TRUE, stringsAsFactors=FALSE)
i1 = read.csv("20180531_LPO_draft5_28g for Amir K and Tom M v7.5.csv", header = TRUE, stringsAsFactors=FALSE)
dim(i1) #24c
i1$gds1 <- paste( i1$GDS.Number, i1$GDS.Datatype , sep = ";", collapse = NULL ) #combine gds# as unique
str(i1)
####################################################end
##2.1 draft vs 28SLP-HV_Rev0.1_0.0 ch2
lpse1 = read.csv("28LPSe_Rev1.0_3.0 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(lpse1)
dumx_lpse1 <- matrix( "1", nrow=dim(lpse1)[1], ncol=1 )
str(dumx_lpse1)
#lpse2 <- lpse1
lpse2 <- cbind( paste( lpse1$v3, lpse1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
#,lpse1[2],lpse1[5],lpse1[3:4] )
,dumx_lpse1[1],lpse1[5] )
lpse2 <- as.data.frame(lpse2)
str(lpse2)

lpse_name <- c("gds1","lpse.check","lpse.des")
colnames(lpse2) <- lpse_name
str(lpse2)
lpse22 <- lpse2[ which( lpse2[1]!="-;-" ), ]
str(lpse22)
#left_join
i1v1 <- left_join(i1, lpse22, by = "gds1")
str(i1v1)
i1v1[is.na(i1v1)] <- ""
str(i1v1) #add 1 new col
####################################################end
##2.2 draft vs 28HPP_Rev1.1_4.0 ch2
hpp1 = read.csv("28HPP_Rev1.1_4.0 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(hpp1)
dumx_hpp1 <- matrix( "1", nrow=dim(hpp1)[1], ncol=1 )
str(dumx_hpp1)
#hpp2 <- hpp1
hpp2 <- cbind( paste( hpp1$v3, hpp1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
#,hpp1[2],hpp1[5],hpp1[3:4] )
,dumx_hpp1[1],hpp1[5] )
hpp2 <- as.data.frame(hpp2)
str(hpp2)

hpp_name <- c("gds1","hpp.check","hpp.des")
colnames(hpp2) <- hpp_name
str(hpp2)
hpp22 <- hpp2[ which( hpp2[1]!="-;-" ), ]
str(hpp22)
#left_join
i1v2 <- left_join(i1v1, hpp22, by = "gds1")
str(i1v2)
i1v2[is.na(i1v2)] <- ""
str(i1v2) #add 1 new col
####################################################end
##2.3 draft vs 28LPQ_RF_Rev1.0_6.0 ch2
lpqrf1 = read.csv("28LPQ_RF_Rev1.0_6.0 ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(lpqrf1)
dumx_lpqrf1 <- matrix( "1", nrow=dim(lpqrf1)[1], ncol=1 )
str(dumx_lpqrf1)
#lpqrf2 <- lpqrf1
lpqrf2 <- cbind( paste( lpqrf1$v3, lpqrf1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
#,lpqrf1[2],lpqrf1[5],lpqrf1[3:4] )
,dumx_lpqrf1[1],lpqrf1[5] )
lpqrf2 <- as.data.frame(lpqrf2)
str(lpqrf2)

lpqrf_name <- c("gds1","lpqrf.check","lpqrf.des")
colnames(lpqrf2) <- lpqrf_name
str(lpqrf2)
lpqrf22 <- lpqrf2[ which( lpqrf2[1]!="-;-" ), ]
str(lpqrf22)
#left_join
i1v3 <- left_join(i1v2, lpqrf22, by = "gds1")
str(i1v3)
i1v3[is.na(i1v3)] <- ""
str(i1v3) #add 1 new col
####################################################end
##2.4 draft vs 28LPQRF_QCA_Rev1.1_0.0_ENG ch2
lpqrfqca1 = read.csv("28LPQRF_QCA_Rev1.1_0.0_ENG ch2.csv", header = TRUE, stringsAsFactors=FALSE)
str(lpqrfqca1)
dumx_lpqrfqca1 <- matrix( "1", nrow=dim(lpqrfqca1)[1], ncol=1 )
str(dumx_lpqrfqca1)
#lpqrfqca2 <- lpqrfqca1
lpqrfqca2 <- cbind( paste( lpqrfqca1$v3, lpqrfqca1$v4, sep = ";", collapse = NULL ) #combine gds# as unique
#,lpqrfqca1[2],lpqrfqca1[5],lpqrfqca1[3:4] )
,dumx_lpqrfqca1[1],lpqrfqca1[5] )
lpqrfqca2 <- as.data.frame(lpqrfqca2)
str(lpqrfqca2)

lpqrfqca_name <- c("gds1","lpqrfqca.check","lpqrfqca.des")
colnames(lpqrfqca2) <- lpqrfqca_name
str(lpqrfqca2)
lpqrfqca22 <- lpqrfqca2[ which( lpqrfqca2[1]!="-;-" ), ]
str(lpqrfqca22)
#left_join
i1v4 <- left_join(i1v3, lpqrfqca22, by = "gds1")
str(i1v4)
i1v4[is.na(i1v4)] <- ""
str(i1v4) #add 1 new col
####################################################end
##2.4.1 vlookup DM ch2, replace draft col
#let factor -> chr
i1v4$lpse.check <- as.character(i1v4$lpse.check)
i1v4$hpp.check <- as.character(i1v4$hpp.check)
i1v4$lpqrf.check <- as.character(i1v4$lpqrf.check)
i1v4$lpqrfqca.check <- as.character(i1v4$lpqrfqca.check)
#replace NA
i1v4[is.na(i1v4)] <- 0
#vlookup
i1v4$ans0 <- paste( i1v4$lpse.check, i1v4$hpp.check, i1v4$lpqrf.check, i1v4$lpqrfqca.check, sep = ";", collapse = NULL )
str(i1v4)
#vlookup
i1v4$ans1 <- ifelse(i1v4$ans0 == "1;1;1;1","28LPSE;28HPP;28LPQRF;28LPQRFQCA"
#if one 0
, ifelse(i1v4$ans0 == "1;1;1;0","28LPSE;28HPP;28LPQRF"
, ifelse(i1v4$ans0 == "1;1;0;1","28LPSE;28HPP;28LPQRFQCA"
, ifelse(i1v4$ans0 == "1;0;1;1","28LPSE;28LPQRF;28LPQRFQCA"
, ifelse(i1v4$ans0 == "0;1;1;1","28HPP;28LPQRF;28LPQRFQCA"
#if two 0
, ifelse(i1v4$ans0 == "1;1;0;0","28LPSE;28HPP"
, ifelse(i1v4$ans0 == "1;0;1;0","28LPSE;28LPQRF"
, ifelse(i1v4$ans0 == "0;1;1;0","28HPP;28LPQRF"
, ifelse(i1v4$ans0 == "1;0;0;1","28LPSE;28LPQRFQCA"
, ifelse(i1v4$ans0 == "0;1;0;1","28HPP;28LPQRFQCA"
, ifelse(i1v4$ans0 == "0;0;1;1","28LPQRF;28LPQRFQCA"
#if three 0
, ifelse(i1v4$ans0 == "1;0;0;0","28LPSE"
, ifelse(i1v4$ans0 == "0;1;0;0","28HPP"
, ifelse(i1v4$ans0 == "0;0;1;0","28LPQRF"
, ifelse(i1v4$ans0 == "0;0;0;1","28LPQRFQCA",
#if all 0
""))))
))))))
))))
)
str(i1v4)
head(i1v4,11)
i1v4$Tech.Variant...Included.in.PDK <- i1v4$ans1
i1v5 <- i1v4
#export 1-24 col
#i1v5 <- cbind(i1v5[1:24])
##clean description footstop.
dumx_fs <- matrix( ".", nrow=dim(i1v5)[1], ncol=1 )
i1v5 <- cbind(i1v5[1:24], i1v5[25]
, i1v5[26]
, paste( i1v5$lpse.des, dumx_fs, sep = "", collapse = NULL )
, i1v5[28]
, paste( i1v5$hpp.des, dumx_fs, sep = "", collapse = NULL )
, i1v5[30]
, paste( i1v5$lpqrf.des, dumx_fs, sep = "", collapse = NULL )
, i1v5[32]
, paste( i1v5$lpqrfqca.des, dumx_fs, sep = "", collapse = NULL )
, i1v5[33:34]
)
#replace col name
coln1 <- colnames(i1v4)
colnames(i1v5) <- coln1
str(i1v5)
##replace ".." -> "."
i1v5$lpse.des <- gsub("[.]{2}", ".", i1v5$lpse.des )
i1v5$hpp.des <- gsub("[.]{2}", ".", i1v5$hpp.des )
i1v5$lpqrf.des <- gsub("[.]{2}", ".", i1v5$lpqrf.des )
i1v5$lpqrfqca.des <- gsub("[.]{2}", ".", i1v5$lpqrfqca.des )
write.csv(x = i1v5, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_LPO_draft5_28g for Amir K and Tom M v8.csv", sep = "") )
####################################################end
####################################################end
####################################################end
###check if duplicate
#input csv
ip = read.csv("0601amir1.csv", header = TRUE)
ip3 <- ip
ip4 <- table(ip3)
ip5 <- as.data.frame(ip4)
ip6 <- ip5[order(ip5[2], decreasing = TRUE), ]
str(ip6)
head(ip6)
write.csv(x = ip6, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_0601amir1.csv", sep = "") )
####################################################end
####################################################end
####################################################end

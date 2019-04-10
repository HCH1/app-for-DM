library(dplyr)
##input:
i1 = read.csv("LCN-002718 130G-LP (v29).csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("LPO-000395 130G-LP (v15).csv", header = TRUE, stringsAsFactors=FALSE)
###
###SOP to check two files diff: add new key col > xxx_join() > logic check > replace NA > save as
i1_v1 <- i1
i2_v1 <- i2
#str(i1_v1)
###create unique key name into new col
i1_v1$ans <- paste( i1_v1$Data.Layer.Name, i1_v1$GDS.Number, i1_v1$GDS.Datatype, 
i1_v1$Cadence.Name.OA.Number, i1_v1$Cadence.Purpose.OA.Number, 
sep = ";", collapse = NULL )
###2 cols
i1_v1 <- cbind( i1_v1[ dim(i1_v1)[2] ], i1_v1[1] )
i1_v1 <- i1_v1[ order(i1_v1[1]), ]
###
i2_v1$ans <- paste( i2_v1$Data.Layer.Name, i2_v1$GDS.Number, i2_v1$GDS.Datatype, 
i2_v1$Cadence.Name.OA.Number, i2_v1$Cadence.Purpose.OA.Number, 
sep = ";", collapse = NULL )
i2_v1 <- cbind( i2_v1[ dim(i2_v1)[2] ], i2_v1[1] )
i2_v1 <- i2_v1[ order(i2_v1[1]), ]
#str(i1_v1)
###bf is key
ans1 <- full_join(i2_v1, i1_v1, by = "ans")
###order by name
###replace NA -> 1 for logic check
ans1[ is.na( ans1 ) ] <- "1"
ans1$check_bf <- ifelse(ans1$ï..Number.x==1,"1","0")
ans1$check_af <- ifelse(ans1$ï..Number.y==1,"1","0")
#str(ans1)
###if af has LV#, means re-updated
ans1$check_all <- ifelse(ans1$check_bf==1 & ans1$check_af==0,"bf",
ifelse(ans1$check_bf==0 & ans1$check_af==1,"af",0)
)
#ans1$check_na <- ifelse(ans1$ï..Number.x=="NA" | ans1$ï..Number.y=="NA",1,0)
ans1 <- ans1[ order(ans1[ dim(ans1)[2] ], decreasing = TRUE), ]
ans1 <- ans1[ order(ans1[1]), ]
#str(ans1)
write.csv(x = ans1, row.names = TRUE
, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_2 LCN vs diff.csv", sep = "") )
###do diff for layer name
af_ <- as.vector( t( i1_v1[ order(i1_v1[dim(i1_v1)[2]]), ]$ans ) )
bf_ <- as.vector( t( i2_v1[ order(i2_v1[dim(i2_v1)[2]]), ]$ans ) )
length(bf_)
length(af_)
diffChr(bf_, af_, color.mode="rgb")

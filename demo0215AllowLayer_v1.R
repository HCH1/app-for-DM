#install.packages("zoo")
#library(zoo)
lpo = read.csv("LPO-000080.csv", header = TRUE)
#merge column 2 6 7 17 18
lpo2 <- cbind(lpo[2],lpo[17],lpo[18],lpo[6],lpo[7],lpo[11])
write.csv(x = lpo2, file = paste(format(Sys.time(), "%Y%m%d"), "_lpo2.csv", sep = "") )
#filter Tech Variant != blank
lpo2_22fdx <- lpo2[lpo2[6]!="", ]
#filter Layer Status == Active
lpo2_22fdx_act <- lpo2_22fdx[lpo2_22fdx[4]=="Active", ]
#filter Layer Category != 
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="Cadence Auxiliary", ]
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="Generated Mask", ]
write.csv(x = lpo2_22fdx_act_cate, file = paste(format(Sys.time(), "%Y%m%d"), "_lpo2_22fdx_act_cate.csv", sep = "") )
#re-bind 3 columns
lpo2_22fdx_act_cate_3cols <- cbind(lpo2_22fdx_act_cate[1],lpo2_22fdx_act_cate[2],lpo2_22fdx_act_cate[3])
lpo2_22fdx_act_cate_dedup <- unique(lpo2_22fdx_act_cate_3cols) 
write.csv(x = lpo2_22fdx_act_cate_dedup, file = paste(format(Sys.time(), "%Y%m%d"), "_lpo2_22fdx_act_cate_dedup.csv", sep = "") )
#do summary
sum_count <- rbind( dim(lpo2_22fdx),dim(lpo2_22fdx_act),dim(lpo2_22fdx_act_cate),dim(lpo2_22fdx_act_cate_dedup) )
#rownames(sum_count) <- c("open_DM","open_Enhance","open_Work","open_Ques","open_Invalid","open_Blank","close_all")
#colnames(sum_count) <- c("bug (ea)","")
write.csv(x = sum_count, file = paste(format(Sys.time(), "%Y%m%d"), "_sum_count.csv", sep = "") )
###
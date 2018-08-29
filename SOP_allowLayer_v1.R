#install.packages("zoo")
#library(zoo)
lpo = read.csv("LPO-000354 28SL.csv", header = TRUE)
#merge column 2 6 7 17 18
lpo2 <- cbind(lpo[2],lpo[17],lpo[18],lpo[6],lpo[7],lpo[11])
write.csv(x = lpo2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2.csv", sep = "") )
#filter Tech Variant != blank
lpo2_22fdx <- lpo2[lpo2[6]!="", ]
colnames(lpo2_22fdx)[6] <- c("TV")
str(lpo2_22fdx)
##2 ways to do filter
##lpo2_22fdx <- lpo2_22fdx[lpo2_22fdx[6]=="22FDX", ]
##or
lpo2_22fdx <- lpo2_22fdx[grep("28SLPHV", lpo2_22fdx$TV),]
##or grep not SLPHV
##lpo2_22fdx <- lpo2_22fdx[grep("28SLPHV", lpo2_22fdx$TV, invert = TRUE),]
#filter Layer Status == Active
lpo2_22fdx_act <- lpo2_22fdx[lpo2_22fdx[4]=="Active", ]
#filter Layer Category != 
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="Cadence Auxiliary", ]
lpo2_22fdx_act_cate <- lpo2_22fdx_act_cate[lpo2_22fdx_act_cate[5]!="Generated Mask", ]
lpo2_22fdx_act_cate <- lpo2_22fdx_act_cate[lpo2_22fdx_act_cate[5]!="Unknown", ]
write.csv(x = lpo2_22fdx_act_cate, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2_22fdx_act_cate.csv", sep = "") )
#re-bind 3 columns
lpo2_22fdx_act_cate_3cols <- cbind(lpo2_22fdx_act_cate[1],lpo2_22fdx_act_cate[2],lpo2_22fdx_act_cate[3])
#remove duplicates
lpo2_22fdx_act_cate_dedup <- unique(lpo2_22fdx_act_cate_3cols) 
#re-order col 2 & 3
lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[ order(lpo2_22fdx_act_cate_dedup[,2], lpo2_22fdx_act_cate_dedup[,3]), ]
#remove last row -> why?
#lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[-dim(lpo2_22fdx_act_cate_dedup)[1],]
#will rbind c("Customer_Reserved_layers", "2000-2300", "0-9999")
last_row <- matrix(c("Customer_Reserved_layers", "2000-2300", "0-9999"), nrow = 1)
colnames(last_row) <- colnames(lpo2_22fdx_act_cate_dedup)
allowlayer1 <- rbind(lpo2_22fdx_act_cate_dedup, last_row)
write.csv(x = allowlayer1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_allow_layer_ans.csv", sep = "") )
#do summary table
sum_count <- rbind( dim(lpo2_22fdx),dim(lpo2_22fdx_act),dim(lpo2_22fdx_act_cate),dim(lpo2_22fdx_act_cate_dedup) )
rownames(sum_count) <- c("LPO_22FDX","LPO_filter1","LPO_filter2","LPO_ans")
colnames(sum_count) <- c("ea rows","ea columns")
write.csv(x = sum_count, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum_count.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end

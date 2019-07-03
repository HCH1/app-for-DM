#v4 old
#v5 re-coded
lpo = read.csv("2 LCN-003290 130G-LP (v44).csv", header = TRUE)
TV_uwant <- "DM-000282"
lpo2 <- lpo
colnames(lpo2)[1] <- c("LV")
colnames(lpo2)[11] <- c("TV")
table(lpo2$Layer.Category)
#str(lpo2)
#grep dataframe contain keywords
lpo2 <- lpo2[grep("Cadence Auxiliary", lpo2$Layer.Category, invert = TRUE),]
lpo2 <- lpo2[grep("Generated Mask", lpo2$Layer.Category, invert = TRUE),]
#lpo2 <- lpo2[grep("Marker Enablement", lpo2$Layer.Category, invert = TRUE),]
table(lpo2$Layer.Category)
#str(lpo2)
lpo2 <- lpo2[grep(TV_uwant, lpo2$TV, invert = FALSE),]
lpo2 <- lpo2[grep("Active", lpo2$Layer.Status, invert = FALSE),]
#str(lpo2)
#re-bind 3 columns
lpo2_22fdx_act_cate <- lpo2
lpo2_22fdx_act_cate_3cols <- cbind(lpo2_22fdx_act_cate[2],lpo2_22fdx_act_cate[17],lpo2_22fdx_act_cate[18])
#remove duplicates
lpo2_22fdx_act_cate_dedup <- unique(lpo2_22fdx_act_cate_3cols) 
#re-order col 2 & 3
lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[ order(lpo2_22fdx_act_cate_dedup[,2], lpo2_22fdx_act_cate_dedup[,3]), ]
#remove last row -> why?
#lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[-dim(lpo2_22fdx_act_cate_dedup)[1],]
#will rbind c("Customer_Reserved_layers", "2000-2300", "0-9999")
###for 22nm
#last_row <- matrix(c("Customer_Reserved_layers", "2000-2300", "0-9999"), nrow = 1)
#colnames(last_row) <- colnames(lpo2_22fdx_act_cate_dedup)
#allowlayer1 <- rbind(lpo2_22fdx_act_cate_dedup, last_row)
###for normal
allowlayer1 <- lpo2_22fdx_act_cate_dedup
write.csv(x = allowlayer1, row.names = FALSE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"),"_",TV_uwant, "_Allowed_Layers.csv", sep = "") )
#do summary table
#sum_count <- rbind( dim(lpo2_22fdx),dim(lpo2_22fdx_act),dim(lpo2_22fdx_act_cate),dim(lpo2_22fdx_act_cate_dedup) )
#rownames(sum_count) <- c("LPO_22FDX","LPO_filter1","LPO_filter2","LPO_ans")
#colnames(sum_count) <- c("ea rows","ea columns")
#write.csv(x = sum_count, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum_count.csv", sep = "") )
####################################################end
####################################################end
####################################################end

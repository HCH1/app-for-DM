###v4: copy from ALL, for dm ly using, due to excel app can not work on SS.
lpo = read.csv("2 LCN-003181 130G-LP (v42).csv", header = TRUE)
TV_uwant <- "DM-000450"
#merge col 2 6 7 17 18 8 9
lpo2 <- cbind(lpo[2],lpo[17],lpo[18],lpo[6],lpo[7],lpo[11],lpo[8],lpo[9])
#str(lpo2)
###or replace same col
lpo2$Layer.Category <- gsub("Cadence Auxiliary", "", lpo2$Layer.Category)
lpo2$Layer.Category <- gsub("Generated Mask", "", lpo2$Layer.Category)
#str(lpo2)
lpo2 <- cbind(lpo2[1:4],
paste(lpo2$Layer.Category,lpo2$Layer.Sub.Category,sep=""),
lpo2[6],lpo[9])
colnames(lpo2)[5] <- c("Layer.Category")
colnames(lpo2)[6] <- c("TV")
#str(lpo2)
lpo2_22fdx <- lpo2[lpo2[6]!="", ]
#str(lpo2_22fdx)
#grep dataframe contain TV
lpo2_22fdx <- lpo2_22fdx[grep(TV_uwant, lpo2_22fdx$TV),]
lpo2_22fdx_act <- lpo2_22fdx[lpo2_22fdx[4]=="Active", ]
#filter new Layer Category != 
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="", ]
#rename
dm_ly_v1 <- lpo2_22fdx_act_cate
dm_ly_v1 <- cbind(dm_ly_v1[1],dm_ly_v1[7],
#use ;, but webdm is :
paste(dm_ly_v1$GDS.Number, dm_ly_v1$GDS.Datatype,sep=";") )
colnames(dm_ly_v1)[1:3] <- c("CAD Level","Description","GDS")
dm_ly_v1 <- dm_ly_v1[ order(dm_ly_v1[1], decreasing = FALSE), ]
###ALPad 130;0
write.csv(x = dm_ly_v1, row.names = FALSE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), 
"_",TV_uwant,"_dm_layers_ans.csv", sep = "") )
####################################################end
####################################################end
####################################################end

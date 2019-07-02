###v4: copy from ALL, for dm ly using, due to excel app can not work on SS.
lpo = read.csv("2 LCN-003260 130G-LP (v43).csv", header = TRUE)
TV_uwant <- "DM-000450"
lpo2 <- lpo
colnames(lpo2)[1] <- c("LV")
colnames(lpo2)[11] <- c("TV")
#str(lpo2)
#grep dataframe contain keywords
lpo2 <- lpo2[grep("Cadence Auxiliary", lpo2$Layer.Category, invert = TRUE),]
lpo2 <- lpo2[grep("Generated Mask", lpo2$Layer.Category, invert = TRUE),]
lpo2 <- lpo2[grep("Marker Enablement", lpo2$Layer.Category, invert = TRUE),]
#str(lpo2)
lpo2 <- lpo2[grep(TV_uwant, lpo2$TV, invert = FALSE),]
lpo2 <- lpo2[grep("Active", lpo2$Layer.Status, invert = FALSE),]
#str(lpo2)
#rename
dm_ly_v1 <- lpo2
dm_ly_v1 <- cbind(dm_ly_v1[2],dm_ly_v1[9],
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

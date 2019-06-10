#library(reshape2)
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
####################################################
output$DRC_grep <- renderTable({
req(input$file1)
diffdm0 <- read.csv(input$file1$datapath, header = TRUE)
lpo <- diffdm0
##
#merge column 2 6 7 17 18 8
lpo2 <- cbind(lpo[2],lpo[17],lpo[18],lpo[6],lpo[7],lpo[11],lpo[8])
#str(lpo2)
###or replace same col
lpo2$Layer.Category <- gsub("Cadence Auxiliary", "", lpo2$Layer.Category)
lpo2$Layer.Category <- gsub("Generated Mask", "", lpo2$Layer.Category)
#str(lpo2)
lpo2 <- cbind(lpo2[1:4],
paste(lpo2$Layer.Category,lpo2$Layer.Sub.Category,sep=""),
lpo2[6])
colnames(lpo2)[5] <- c("Layer.Category")
colnames(lpo2)[6] <- c("TV")
#str(lpo2)
lpo2_22fdx <- lpo2[lpo2[6]!="", ]
#str(lpo2_22fdx)
#grep dataframe contain keywords
lpo2_22fdx <- lpo2_22fdx[grep(input$text1, lpo2_22fdx$TV),]
#str(lpo2_22fdx)
lpo2_22fdx_act <- lpo2_22fdx[lpo2_22fdx[4]=="Active", ]
#filter new Layer Category != 
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="", ]
#re-bind 3 columns
lpo2_22fdx_act_cate_3cols <- cbind(lpo2_22fdx_act_cate[1],
lpo2_22fdx_act_cate[2],lpo2_22fdx_act_cate[3])
#remove duplicates
lpo2_22fdx_act_cate_dedup <- unique(lpo2_22fdx_act_cate_3cols) 
#re-order col 2 & 3
lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[ 
order(lpo2_22fdx_act_cate_dedup[,2], lpo2_22fdx_act_cate_dedup[,3]), ]
###
last_row <- matrix(c("Customer_Reserved_layers", "2000-2300", "0-9999"), nrow = 1)
colnames(last_row) <- colnames(lpo2_22fdx_act_cate_dedup)
allowlayer1 <- rbind(lpo2_22fdx_act_cate_dedup, last_row)
###
allowlayer1
###
})
###
}
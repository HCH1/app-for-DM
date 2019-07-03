#library(reshape2)
###v2 2018
###v3 2019 June; re-write 
###v4 use DT
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
####################################################
#renderDT renderTable 1
output$op1 <- renderDT({
req(input$file2)
diffdm0 <- read.csv(input$file2$datapath, header = TRUE)
lpo <- diffdm0
###
TV_uwant <- input$text1
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
###
###DT e.g.
#https://datatables.net/examples/basic_init/
DT::datatable(allowlayer1, 
              ###col search
              #https://rstudio.github.io/DT/009-searchable.html
              #https://shiny.rstudio.com/articles/datatables.html
              #filter = list(position = 'top', clear = FALSE),
              ###download
              #https://github.com/rstudio/DT/issues/267
              extensions = 'Buttons'
              , options = list( 
                ###highlight color
                #https://rstudio.github.io/DT/006-highlight.html
                lengthMenu = c(99999, -1), pageLength = 99999, searchHighlight = TRUE
                , dom = "Blfrtip"
                , buttons = 
                  list("copy", list(
                    extend = "collection"
                    #, buttons = c("csv", "excel", "pdf")
                    , buttons = c("csv")
                    , text = "Download"
                  ) ) )# end of buttons customization
              )
###
})
###
###
###
#renderDT renderTable 2
output$op2 <- renderDT({
  req(input$file1)
  i1 <- read.csv(input$file1$datapath, header = TRUE)
  i1_v1 <- i1
  ##
  req(input$file2)
  i2 <- read.csv(input$file2$datapath, header = TRUE)
  i2_v1 <- i2
  ##
  TV_uwant <- input$text1
  ly_st <- "Active"
  ly_cat <- "Marker Enablement"
  ly_cat2 <- "Generated Mask"
  ly_cat3 <- "Cadence Auxiliary"
  ###
  i1_v1 <- i1
  i2_v1 <- i2
  i1_v1$ch_ly1 <- gsub("[_]", "999", i1_v1$Description)
  i1_v1$ch_ly1 <- gsub("[.]", "888", i1_v1$ch_ly1)
  i1_v1$ch_ly1 <- gsub("n[']t", "777", i1_v1$ch_ly1)
  i1_v1$ch_ly1 <- gsub("[[:punct:]]", " ", i1_v1$ch_ly1)
  ###keep _ and .
  i1_v1$ch_ly1 <- gsub("999", "_", i1_v1$ch_ly1)
  i1_v1$ch_ly1 <- gsub("888", ".", i1_v1$ch_ly1)
  i1_v1$ch_ly1 <- gsub("777", "n't", i1_v1$ch_ly1)
  i1_v1$ch_ly1 <- gsub("[.]$", "", i1_v1$ch_ly1)
  #insdie dataframe is factor -> character -> list -> character
  desc_split <- unlist( strsplit( i1_v1$ch_ly1, '\\s' ) )
  desc_split <- as.data.frame(desc_split)
  #str(desc_split)
  ###remove end is .
  desc_split$desc_split <- gsub("[.]$", "", desc_split$desc_split)
  ###freq
  desc_split_freq <- table(desc_split)
  desc_split_freq <- as.data.frame(desc_split_freq)
  colnames(desc_split_freq)[1] <- "Data.Layer.Name"
  #str(desc_split_freq)
  #write.csv(x = desc_split_freq, row.names = TRUE, 
  #file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC desc_split v1.csv", sep = "") )
  ####################################################end
  library(qdapDictionaries)
  #create custom function
  is.word <- function(x) x %in% GradyAugmented # or use any dataset from package
  #use this function to filter words, df = dataframe from corpus
  df0 <- desc_split_freq
  df <- desc_split_freq
  ###dict only has lower case.
  #df0$Data.Layer.Name <- tolower(df0$Data.Layer.Name)
  df <- df[which(is.word(df$Data.Layer.Name)),]
  ###dm vs af-dict
  desc_vs_dict <- full_join(df0, df, by = "Data.Layer.Name")
  colnames(desc_vs_dict)[2] <- "dm.desc.split.freq"
  colnames(desc_vs_dict)[3] <- "in.dict.freq"
  #write.csv(x = desc_vs_dict, row.names = TRUE, 
  #          file = paste(format(Sys.time(), "%Y%m%d_%H"),"_",TV_uwant, 
  #                       "_DMC desc vs dict v1.csv", sep = "") )
  ####################################################end
  ###create a sub_ly_ch
  sub_ly_ch <- i2_v1
  sub_ly_ch <- sub_ly_ch[grep(TV_uwant, sub_ly_ch$Tech.Variant...Included.in.PDK),]
  sub_ly_ch <- sub_ly_ch[grep(ly_st, sub_ly_ch$Layer.Status),]
  sub_ly_ch <- sub_ly_ch[grep(ly_cat, sub_ly_ch$Layer.Category, invert = TRUE),]
  sub_ly_ch <- sub_ly_ch[grep(ly_cat2, sub_ly_ch$Layer.Category, invert = TRUE),]
  sub_ly_ch <- sub_ly_ch[grep(ly_cat3, sub_ly_ch$Layer.Category, invert = TRUE),]
  #str(sub_ly_ch)
  ####################################################end
  ###map sub-ALL vs desc split freq
  sub_ly_ch_vs_desc_split <- full_join(sub_ly_ch, desc_split_freq, by = "Data.Layer.Name")
  #replace NA to blank
  sub_ly_ch_vs_desc_split[ is.na( sub_ly_ch_vs_desc_split ) ] <- ""
  colnames(sub_ly_ch_vs_desc_split)[1] <- "lv.Number"
  sub_ly_ch_vs_desc_split <- sub_ly_ch_vs_desc_split[
    grep("LV", sub_ly_ch_vs_desc_split$lv.Number),]
  
  len1 <- dim(sub_ly_ch_vs_desc_split)
  sub_ly_ch_vs_desc_split <- sub_ly_ch_vs_desc_split[ 
    order(sub_ly_ch_vs_desc_split[len1[2]], decreasing = TRUE), ]
  
  #write.csv(x = sub_ly_ch_vs_desc_split, row.names = TRUE, 
  #file = paste(format(Sys.time(), "%Y%m%d_%H"), 
  #"_DMC sub-ALL map desc_freq v1.csv", sep = "") )
  ####################################################end
  ###vlookup sub-ALL vs desc_split vs dict
  desc_map_lpo <- full_join( desc_vs_dict, sub_ly_ch, by = "Data.Layer.Name")
  #dim(i1_v3) #sometimes will suffer more dim, due to duplicate gds.pair
  #head(i1_v3)
  #replace NA to blank
  desc_map_lpo[ is.na( desc_map_lpo ) ] <- ""
  #desc_map_lpo <- desc_map_lpo[ order(desc_map_lpo[4], decreasing = FALSE), ]
  #desc_map_lpo <- desc_map_lpo[ order(desc_map_lpo[3], decreasing = TRUE), ]
  #
  desc_map_lpo2 <- desc_map_lpo
  colnames(desc_map_lpo2)[4] <- "lv.Number"
  ###case: dm.desc.split="" in.dict="" LV=has
  desc_map_lpo2$ans.missing.ly = ifelse(
    desc_map_lpo2$dm.desc.split == ""
    & desc_map_lpo2$in.dict == ""
    & grepl("LV",desc_map_lpo2$lv.Number),"ly do not have GR",0)
  
  ###case: dm.desc.split=has in.dict="" LV=has
  desc_map_lpo2$ans.ly.in.GR.desc = ifelse(
    desc_map_lpo2$dm.desc.split > 0
    & desc_map_lpo2$in.dict == ""
    & grepl("LV",desc_map_lpo2$lv.Number),"ly in GR desc",0)
  
  ###case: dm.desc.split=has in.dict=has LV=""
  desc_map_lpo2$ans.word.in.dict = ifelse(
    desc_map_lpo2$dm.desc.split > 0
    & desc_map_lpo2$in.dict > 0
    & grepl("",desc_map_lpo2$lv.Number),"word in dict",0)
  
  ###case: dm.desc.split="" in.dict="" LV=""
  desc_map_lpo2$ans.word.not.in.dict = ifelse(
    desc_map_lpo2$ans.missing.ly < 1
    & desc_map_lpo2$ans.ly.in.GR.desc < 1
    & desc_map_lpo2$ans.word.in.dict < 1,"word not in dict",0)
  
  len2 <- dim(desc_map_lpo2)[2]
  desc_map_lpo2 <- cbind(desc_map_lpo2[(len2-3):len2],
                         desc_map_lpo2[4],
                         desc_map_lpo2[1],
                         desc_map_lpo2[5:(len2-4)],
                         desc_map_lpo2[2:3])
  
  desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[4], 
                                        decreasing = TRUE), ]
  desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[3], 
                                        decreasing = TRUE), ]
  desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[2], 
                                        decreasing = TRUE), ]
  desc_map_lpo2 <- desc_map_lpo2[ order(desc_map_lpo2[1], 
                                        decreasing = TRUE), ]
  #str(desc_map_lpo2)
  ###write.csv(x = desc_map_lpo2, row.names = TRUE, 
  #          file = paste(format(Sys.time(), "%Y%m%d_%H"),"_",TV_uwant, 
  #                       "_DMC summary sub-ALL vs ly GR missing; desc_split; dict v1.csv", sep = "") )
  ####################################################end
  ###DT e.g.
  #https://datatables.net/examples/basic_init/
  DT::datatable(desc_map_lpo2, 
                ###col search
                #https://rstudio.github.io/DT/009-searchable.html
                #https://shiny.rstudio.com/articles/datatables.html
                #filter = list(position = 'top', clear = FALSE),
                ###download
                #https://github.com/rstudio/DT/issues/267
                extensions = 'Buttons'
                , options = list( 
                  ###highlight color
                  #https://rstudio.github.io/DT/006-highlight.html
                  lengthMenu = c(99999, -1), pageLength = 99999, searchHighlight = TRUE
                  , dom = "Blfrtip"
                  , buttons = 
                    list("copy", list(
                      extend = "collection"
                      #, buttons = c("csv", "excel", "pdf")
                      , buttons = c("csv")
                      , text = "Download"
                    ) ) )# end of buttons customization
  )
  ###
})
###
###
}
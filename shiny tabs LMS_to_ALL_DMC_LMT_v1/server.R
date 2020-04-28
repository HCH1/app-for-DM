#v1 combine 3 apps in 1
#v2 add DM layers
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
  ####################################################
  #renderDT renderTable 1 for ALL
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
  #renderDT renderTable 1b for DMC pre-check
  output$op1b <- renderDT({
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
  #renderDT renderTable 2 for LM draft
  output$op2b <- renderDT({
    req(input$file2)
    i11 <- read.csv(input$file2$datapath, header = TRUE)
    ##
    req(input$file3)
    i22 <- read.csv(input$file3$datapath, header = TRUE)
    ###
    #TV_uwant <- input$text1
    lmt_col3p3 <- "Generic"
    lmt_col1 <- "LM-0001.091"
    lmt_col2 <- "Layer Mapping Table"
    lmt_col4 <- "Layer"
    lpo_col1 <- "LCN-003290"
    ###
    i1 <- i11
    i2 <- i22
    #str(i1)
    i1 <- i1[grep("Mask|Drawn", i1$Layer.Type),]
    i1 <- i1[grep("Active", i1$Layer.Status),]
    #str(i1)
    #i1 <- i1[grep("", i1$Tech.Variant...Included.in.PDK, invert = TRUE),]
    ##combine LPO col M B == LMT col C
    col3 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col3[ is.na( col3 ) ] <- lmt_col3p3
    
    col1 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col1[ is.na( col1 ) ] <- lmt_col1
    
    col2 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col2[ is.na( col2 ) ] <- lmt_col2
    
    col4 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col4[ is.na( col4 ) ] <- lmt_col4
    ###LMT Layer.Number = LPO col 13 2 36 dummy
    ###col 17 18 25 26
    i1_v1 <- cbind( col1,col2,
                    paste( i1[,13],i1[,2],i1[,36],col3, sep = "_", collapse = NULL )
                    ,col4,i1[17:18],i1[25:26] )
    colnames(i1_v1) <- colnames(i2[1,])[1:8]
    #str(i1_v1)
    i1_v1$Layer.Number <- gsub("__", "_", i1_v1$Layer.Number, ignore.case = TRUE)
    #str(i1_v1)
    i1_v1[ is.na( i1_v1 ) ] <- ""
    #str(i1_v1)
    ###
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(i1_v1, 
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
  #renderDT renderTable 2b for LM pre-check
  output$op2 <- renderDT({
    req(input$file2)
    i11 <- read.csv(input$file2$datapath, header = TRUE)
    ##
    req(input$file3)
    i22 <- read.csv(input$file3$datapath, header = TRUE)
    ###
    #TV_uwant <- input$text1
    lmt_col3p3 <- "Generic"
    lmt_col1 <- "LM-0001.091"
    lmt_col2 <- "Layer Mapping Table"
    lmt_col4 <- "Layer"
    lpo_col1 <- "LCN-003290"
    ###
    i1 <- i11
    i2 <- i22
    #str(i1)
    i1 <- i1[grep("Mask|Drawn", i1$Layer.Type),]
    i1 <- i1[grep("Active", i1$Layer.Status),]
    #str(i1)
    #i1 <- i1[grep("", i1$Tech.Variant...Included.in.PDK, invert = TRUE),]
    ##combine LPO col M B == LMT col C
    col3 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col3[ is.na( col3 ) ] <- lmt_col3p3
    
    col1 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col1[ is.na( col1 ) ] <- lmt_col1
    
    col2 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col2[ is.na( col2 ) ] <- lmt_col2
    
    col4 <- matrix( NA, nrow=dim(i1)[1], ncol=1 ) #create dummy n*1
    col4[ is.na( col4 ) ] <- lmt_col4
    ###LMT Layer.Number = LPO col 13 2 36 dummy
    ###col 17 18 25 26
    i1_v1 <- cbind( col1,col2,
                    paste( i1[,13],i1[,2],i1[,36],col3, sep = "_", collapse = NULL )
                    ,col4,i1[17:18],i1[25:26] )
    colnames(i1_v1) <- colnames(i2[1,])[1:8]
    #str(i1_v1)
    i1_v1$Layer.Number <- gsub("__", "_", i1_v1$Layer.Number, ignore.case = TRUE)
    #str(i1_v1)
    i1_v1[ is.na( i1_v1 ) ] <- ""
    ###col 5 6 3
    i1_v2 <- cbind( paste( i1_v1[,5],i1_v1[,6],i1_v1[,3],
                           sep = ";", collapse = NULL ) )
    i1_v2 <- as.data.frame(table(i1_v2))
    colnames(i1_v2)[1] <- "name"
    
    i2_v2 <- cbind( paste( i2[,5],i2[,6],i2[,3],
                           sep = ";", collapse = NULL ) )
    i2_v2 <- as.data.frame(table(i2_v2))
    colnames(i2_v2)[1] <- "name"
    
    sublpo_lmt_diff <- full_join( i1_v2, i2_v2, by = "name")
    colnames(sublpo_lmt_diff)[2:3] <- c("sub-lpo","sub-lmt")
    ###re-order
    sublpo_lmt_diff <- sublpo_lmt_diff[ order( sublpo_lmt_diff[3]
                                               , na.last = FALSE, decreasing = TRUE ), ] #order reverse
    sublpo_lmt_diff <- sublpo_lmt_diff[ order( sublpo_lmt_diff[2]
                                               , na.last = FALSE, decreasing = TRUE ), ] #order reverse
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(sublpo_lmt_diff, 
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
  #renderDT renderTable 3 for GDS# table
  output$op3 <- renderDT({
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
    lpo2 <- lpo2[grep("Marker Enablement", lpo2$Layer.Category, invert = TRUE),]
    table(lpo2$Layer.Category)
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
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(dm_ly_v1, 
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
  #renderDT renderTable 3 for CAD# table
  output$op3c <- renderDT({
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
    lpo2 <- lpo2[grep("Marker Enablement", lpo2$Layer.Category, invert = TRUE),]
    table(lpo2$Layer.Category)
    #str(lpo2)
    lpo2 <- lpo2[grep(TV_uwant, lpo2$TV, invert = FALSE),]
    lpo2 <- lpo2[grep("Active", lpo2$Layer.Status, invert = FALSE),]
    #str(lpo2)
    #rename
    dm_ly_v1 <- lpo2
    dm_ly_v1 <- cbind(dm_ly_v1[2],
                      #Cadence Layer Name	
                      #Cadence Layer Purpose
                      paste(dm_ly_v1$Cadence.Layer.Name, 
                            dm_ly_v1$Cadence.Layer.Purpose, sep=":") )
    colnames(dm_ly_v1)[1:2] <- c("v1",
                                 "v2")
    #replace same col
    dm_ly_v1$v2 <- gsub("_PDKdummy", "", dm_ly_v1$v2)
    dm_ly_v1 <- dm_ly_v1[ order(dm_ly_v1[1], decreasing = FALSE), ]
    ###ALPad 130;0
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(dm_ly_v1, 
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
  #renderDT renderTable 3b for rev history
  output$op3b <- renderDT({
    req(input$file4)
    diffdm0 <- read.csv(input$file4$datapath, header = TRUE)
    diffdm <- diffdm0
    ###
    #extract 3 columns
    diffdm1 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
    diffdm2 <- diffdm1[ which( diffdm1[2]=="Added"|diffdm1[2]=="Removed"|diffdm1[2]=="Modified"|diffdm1[2]=="Same"), ]
    #order Section
    diffdm2 <- diffdm2[order(diffdm2[1]), ]
    #length(t(diffdm4_uni)) == 113
    diffdm4_uni <- unique(diffdm2[1]) 
    #create dummy 113*1
    ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 ) 
    #write a loop, run 113ea
    for ( i in 1:length(t(diffdm4_uni)) ){
      #filter the i-th Scetion, e.g. i=1 to 113 
      a3 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[i,],collapse=" " ), ]
      #e.g. 1st Section, then extract columns of "Type & Rule"
      #due to we want to merge them
      a4 <- cbind( a3[2], a3[3] ) #n*2 matrix
      a4t <- as.matrix( t(a4) ) #2*n matrix
      a4tv <- as.vector(a4t) #convert to line
      #due to repeat "Added or Removed or Modified", so need to do de-duplicated this vector
      a4t_v_d <- a4tv[!duplicated(a4tv)]
      #lines -> character (~ 1*1)
      a5 <- paste( t(a4t_v_d),collapse=" " )
      #save to i-th row
      ans_o1[i] <- a5
    }
    #create opuput format
    ans_o2 <- cbind( diffdm4_uni, ans_o1 )
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(ans_o2, 
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
  #renderDT renderTable 4 for check missing bracket ()[]{}
  output$op4 <- renderDT({
    req(input$file1)
    diffdm0 <- read.csv(input$file1$datapath, header = TRUE)
    diffdm <- diffdm0
    ###
    #search then replace
    #gsub("[^\\(\\)\\[\\]\\{\\}]", "", x)
    #i1_v1$desc2 <- gsub("[^\\( | \\) | \\ | [\\] | \\{ | \\}]", "", i1_v1$Description)
    ###to solve bracket issue
    i1_v1 <- diffdm
    ###due to hard to code [ and ], so we replace them 1st
    i1_v1$desc1 <- gsub("\\[", "@(@", i1_v1$Description)
    i1_v1$desc1 <- gsub("\\]", "@)@", i1_v1$desc1)
    i1_v1$desc1 <- gsub("[A-z0-9]|\\s", "", i1_v1$desc1)
    i1_v1$desc1 <- gsub("\\@\\(\\@", "3", i1_v1$desc1)
    i1_v1$desc1 <- gsub("\\@\\)\\@", "4", i1_v1$desc1)
    
    i1_v1$bk1 <- gsub("[^\\(]", "", i1_v1$desc1)
    i1_v1$bk2 <- gsub("[^\\)]", "", i1_v1$desc1)
    ###let [ and ] as 3 and 4
    i1_v1$bk3 <- gsub("[^3]", "", i1_v1$desc1)
    i1_v1$bk4 <- gsub("[^4]", "", i1_v1$desc1)
    
    i1_v1$bk5 <- gsub("[^\\{]", "", i1_v1$desc1)
    i1_v1$bk6 <- gsub("[^\\}]", "", i1_v1$desc1)
    ###replace ()[]{} to 1 2 3, then do logic check, if diff, then missing
    i1_v1$bk1 <- gsub("[\\(]", "1", i1_v1$bk1)
    i1_v1$bk2 <- gsub("[\\)]", "1", i1_v1$bk2)
    i1_v1$bk3 <- gsub("3", "2", i1_v1$bk3)
    i1_v1$bk4 <- gsub("4", "2", i1_v1$bk4)
    i1_v1$bk5 <- gsub("[\\{]", "3", i1_v1$bk5)
    i1_v1$bk6 <- gsub("[\\}]", "3", i1_v1$bk6)
    
    i1_v1$bk_check12 <- ifelse(i1_v1$bk1 == i1_v1$bk2,"same","bracket missing")
    i1_v1$bk_check34 <- ifelse(i1_v1$bk3 == i1_v1$bk4,"same","bracket missing")
    i1_v1$bk_check56 <- ifelse(i1_v1$bk5 == i1_v1$bk6,"same","bracket missing")
    #str(i1_v1)
    #i1_v1$desc2 <- gsub("[[:punct:]]|\\w|\\s", "", i1_v1$Description)
    #i1_v1$desc2 <- gsub("[^\\(\\)]", "", i1_v1$desc2)
    #i1_v1$desc2 <- gsub("\\w|\\s|[.]|[<]|[>]|[/]|[-]|[\"]|[$]|[=]|[+]|[%]|[,]|[:]|[;]|[&]|[#]|[']|[~]", 
    #"", i1_v1$Description)
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(i1_v1, 
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
  #renderDT renderTable 4b for check missing full stop .
  output$op4b <- renderDT({
    req(input$file1)
    diffdm0 <- read.csv(input$file1$datapath, header = TRUE)
    diffdm <- diffdm0
    ###
    ###dig out lack full stop dot.
    ###grep invert = TRUE
    i1_v1_v1 <- diffdm
    ###end is not .
    i1_v1_v1 <- i1_v1_v1[grep("[.]$", i1_v1_v1$Description, invert = TRUE),]
    ###end is not ]
    i1_v1_v1 <- i1_v1_v1[grep("\\]$", i1_v1_v1$Description, invert = TRUE),]
    #replace NA to blank
    i1_v1_v1[ is.na( i1_v1_v1 ) ] <- ""
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(i1_v1_v1, 
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
  #renderDT renderTable 4c spell typo
  output$op4c <- renderDT({
    req(input$file1)
    diffdm0 <- read.csv(input$file1$datapath, header = TRUE)
    diffdm <- diffdm0
    ###
    ##input:
    text <- diffdm$Description
    write.csv(x = text, row.names = TRUE, 
              file = "file.csv" )
    #only read certain col
    text2 <- readLines("file.csv", warn = FALSE)
    ##https://cran.r-project.org/web/packages/hunspell/vignettes/intro.html
    ##hunspell
    bad_words <- hunspell(text2, format = "latex")
    bad2 <- sort(unique(unlist(bad_words)))
    #bad3 is df
    bad3 <- as.data.frame(bad2)
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(bad3, 
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
  #renderDT renderTable 5 for TT melt
  output$op5 <- renderDT({
    req(input$file5)
    diffdm0 <- read.csv(input$file5$datapath, header = TRUE)
    diffdm <- diffdm0
    
    req(input$file5b)
    diffdm0b <- read.csv(input$file5b$datapath, header = TRUE)
    diffdmb <- diffdm0b
    ###
    ##input:
    ##TT convert
    #install.packages('reshape')

    ##input:
    i1_v1 <- diffdm
    colnames(i1_v1)[1] <- c("TT")
    i2_v1 <- diffdmb
    colnames(i2_v1) <- c("DL.Description","DL")
    #clean
    i1_v1$TT <- gsub("__", "_", i1_v1$TT)
    i1_v1$TT <- gsub("[_]$", "", i1_v1$TT)
    #clean
    i2_v1$DL <- gsub(" ", "", i2_v1$DL)
    i2_v1$DL <- gsub("__", "_", i2_v1$DL)
    #end is _
    i2_v1$DL <- gsub("[_]$", "", i2_v1$DL)
    #https://stackoverflow.com/questions/7980030/how-to-pivot-unpivot-cast-melt-data-frame
    #un-pivot
    unpivot1 <- melt(i1_v1, id = c("TT"))
    unpivot1[ is.na( unpivot1 ) ] <- ""
    unpivot1 <- unpivot1[ order(unpivot1[1], decreasing = FALSE, na.last = FALSE), ]
    #clean
    unpivot1$TT <- gsub("__", "_", unpivot1$TT)
    #end is _
    unpivot1$TT <- gsub("[_]$", "", unpivot1$TT)
    unpivot1$variable <- gsub("__", "_", unpivot1$variable)
    #end is _
    unpivot1$variable <- gsub("[_]$", "", unpivot1$variable)
    #x -> X
    unpivot1$value <- gsub("x", "X", unpivot1$value)
    #str(unpivot1)
    unpivot1$variable <- gsub("X1", "1", unpivot1$variable)
    unpivot1$variable <- gsub("X2", "2", unpivot1$variable)
    unpivot1$variable <- gsub("X3", "3", unpivot1$variable)
    unpivot1$variable <- gsub("X4", "4", unpivot1$variable)
    unpivot1b <- unpivot1
    #let x X align to X
    unpivot1b$value2 <- toupper(unpivot1b$value)
    #exclude 0
    unpivot1c <- unpivot1b[ which( unpivot1b[3]!="0"), ]
    #replace word
    unpivot1c$value2 <- gsub("X", "or (", unpivot1c$value2)
    unpivot1c$value2 <- gsub("1", "touching (", unpivot1c$value2)
    #re-rank, start from touching, then or
    unpivot1c <- unpivot1c[ order(unpivot1c[3], decreasing = FALSE, na.last = FALSE), ]
    unpivot1c <- unpivot1c[ order(unpivot1c[1], decreasing = FALSE, na.last = FALSE), ]
    #str(unpivot1c)
    #new 1 col, rows=unpivot
    newcol2 <- matrix( "=", nrow=dim(unpivot1c)[1], ncol=1 ) #create dummy n*1
    newcol2 <- as.data.frame(newcol2)
    newcol2b <- matrix( ",", nrow=dim(unpivot1c)[1], ncol=1 ) #create dummy n*1
    newcol2b <- as.data.frame(newcol2b)
    unpivot1c$TT2 <- paste(unpivot1c$TT,newcol2$V1, sep = " ", collapse = NULL )
    unpivot1c$variable2 <- paste(unpivot1c$variable,newcol2b$V1, sep = " ", 
                                 collapse = NULL )
    #choose uppercase col 1 X
    unpivot2 <- cbind( unpivot1c[5], unpivot1c[4], unpivot1c[6] )
    #str(newcol1)
    #make 1 col is only "device list ="
    DLcol1 <- unique(unpivot2$TT2)
    DLcol1 <- as.data.frame(DLcol1)
    #new 1 col, rows=device list, will be used in for loop 
    newcol1 <- matrix( NA, nrow=dim(DLcol1)[1], ncol=1 ) #create dummy n*1
    #str(DLcol1)
    #for loop
    for (i in 1:length( t(DLcol1) ) ) {
      unpivot2b <- unpivot2
      #unpivot choose DL row by row; use paste to let cell become text
      unpivot2b <- unpivot2b[ which( unpivot2b[1]==paste( DLcol1[i,],collapse="" ) ), ]
      unpivot2b <- cbind(unpivot2b[2],unpivot2b[3])
      unpivot2b <- as.data.frame(unpivot2b)
      #become long list
      unpivot3 <- as.vector(t(unpivot2b))
      #str(unpivot3)
      #in this long list, remove same words
      unpivot3 <- unpivot3[!duplicated(unpivot3)]
      #str(unpivot3)
      #use paste to merge many chara into 1 chara
      unpivot3 <- paste( t(unpivot3), collapse=" " )
      #str(unpivot3)
      #save to new col row by row
      newcol1[i,] <- unpivot3
    }
    newcol1 <- as.data.frame(newcol1)
    #make 1 col is only "device list ="
    DLcol2 <- unique(unpivot1c$TT)
    DLcol2 <- as.data.frame(DLcol2)
    #make ans format
    unpivot3 <- cbind( DLcol2, newcol1 )
    unpivot3 <- as.data.frame(unpivot3)
    #replace word
    unpivot3$V1 <- gsub(" ,", ",", unpivot3$V1)
    #end is ,
    unpivot3$V1 <- gsub("[ ,]$", " ).", unpivot3$V1)
    unpivot3$V1 <- gsub(", or", " ) or", unpivot3$V1)
    #full_join description
    colnames(unpivot3)[1] <- c("DL")
    unpivot3 <- full_join(unpivot3, i2_v1, by = "DL")
    #save
    
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(unpivot3, 
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
  #renderDT renderTable 5b TT unpivot
    output$op5b <- renderDT({
      req(input$file5)
      diffdm0 <- read.csv(input$file5$datapath, header = TRUE)
      diffdm <- diffdm0
      
      req(input$file5b)
      diffdm0b <- read.csv(input$file5b$datapath, header = TRUE)
      diffdmb <- diffdm0b
      ###
      ##input:
      ##TT convert
      #install.packages('reshape')
      
      ##input:
      i1_v1 <- diffdm
      colnames(i1_v1)[1] <- c("TT")
      i2_v1 <- diffdmb
      colnames(i2_v1) <- c("DL.Description","DL")
      #clean
      i1_v1$TT <- gsub("__", "_", i1_v1$TT)
      i1_v1$TT <- gsub("[_]$", "", i1_v1$TT)
      #clean
      i2_v1$DL <- gsub(" ", "", i2_v1$DL)
      i2_v1$DL <- gsub("__", "_", i2_v1$DL)
      #end is _
      i2_v1$DL <- gsub("[_]$", "", i2_v1$DL)
      #https://stackoverflow.com/questions/7980030/how-to-pivot-unpivot-cast-melt-data-frame
      #un-pivot
      unpivot1 <- melt(i1_v1, id = c("TT"))
      unpivot1[ is.na( unpivot1 ) ] <- ""
      unpivot1 <- unpivot1[ order(unpivot1[1], decreasing = FALSE, na.last = FALSE), ]
      #clean
      unpivot1$TT <- gsub("__", "_", unpivot1$TT)
      #end is _
      unpivot1$TT <- gsub("[_]$", "", unpivot1$TT)
      unpivot1$variable <- gsub("__", "_", unpivot1$variable)
      #end is _
      unpivot1$variable <- gsub("[_]$", "", unpivot1$variable)
      #x -> X
      unpivot1$value <- gsub("x", "X", unpivot1$value)
      #str(unpivot1)
      unpivot1$variable <- gsub("X1", "1", unpivot1$variable)
      unpivot1$variable <- gsub("X2", "2", unpivot1$variable)
      unpivot1$variable <- gsub("X3", "3", unpivot1$variable)
      unpivot1$variable <- gsub("X4", "4", unpivot1$variable)
    ####################################################end
    ###DT e.g.
    #https://datatables.net/examples/basic_init/
    DT::datatable(unpivot1, 
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
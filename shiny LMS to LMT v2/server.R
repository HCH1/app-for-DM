#library(reshape2)
###v2 2018
###v3 2019 June; re-write 
###v4 use DT
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
####################################################
#renderDT renderTable 1
output$op1 <- renderDT({
  req(input$file1)
  i11 <- read.csv(input$file1$datapath, header = TRUE)
  ##
  req(input$file2)
  i22 <- read.csv(input$file2$datapath, header = TRUE)
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
#renderDT renderTable 2
output$op2 <- renderDT({
  req(input$file1)
  i11 <- read.csv(input$file1$datapath, header = TRUE)
  ##
  req(input$file2)
  i22 <- read.csv(input$file2$datapath, header = TRUE)
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
}
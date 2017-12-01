options(shiny.maxRequestSize=30*1024^2) 
library(quanteda)
library(tm)
library(SnowballC)
library(wordcloud)
server <- function(input, output) {
####################################################
output$table1 <- renderTable({
req(input$file1)
in0 <- read.csv(input$file1$datapath, header = TRUE)
in1 <- in0
##


write.csv(x = tb2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_WC_byTokens.csv", sep = "") )
head(tb2,22)
})
##
# Our dataset
  data <- tb2
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(Sys.Date(), "_WC_byTokens", ".csv", sep="")
    },
    content = function(file) {
      write.csv(data, file)
    }
  )
##

}
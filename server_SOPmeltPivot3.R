# Define server logic to read selected file ----
library(reshape2)

server <- function(input, output) {
####################################################
output$TT_1d <- renderTable({
req(input$file1)
i1 <- read.csv(input$file1$datapath, header = TRUE)
i2 <- i1
o1 <- melt(i2, id.vars = "Structure", warn = FALSE)
#
o1 <- o1[order(o1[3]), ]
o1 <- o1[order(o1[2]), ]
o1 <- o1[order(o1[1]), ]
write.csv(x = o1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT.csv", sep = "") )
o1
#head(o1, n = 20L)
})
####################################################
# Downloadable csv of selected dataset ----
#  output$downloadData <- downloadHandler(
#    filename = function() {
#      paste(input$file1, "to1D.csv", sep = "")
#    },
#    content = function(file) {
#      write.csv(o1, file, row.names = FALSE)
#    }
#  )


}
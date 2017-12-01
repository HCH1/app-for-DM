library(shiny)

basicPage(

fileInput("file1", "Pls input _internal.csv -> word counts",
                multiple = TRUE,
                accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".csv")),

#plotOutput('plot1', width = "300px", height = "300px"),
#plotOutput("plot1")
##https://shiny.rstudio.com/reference/shiny/0.14/downloadHandler.html
downloadButton("downloadData", "Download"),
tableOutput("table1")
#  radioButtons('style', 'Progress bar style', c('notification', 'old')),
#  actionButton('goPlot', 'Go plot'),
#  actionButton('goTable', 'Go table')
)
#runApp()
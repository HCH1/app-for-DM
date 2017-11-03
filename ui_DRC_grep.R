library(shiny)

ui <- fluidPage(

  titlePanel("Uploading Files"),

  sidebarLayout(

    sidebarPanel(

      fileInput("file1", "pls input DTT.csv -> DTT_1_0_prohibit.cvs",
                multiple = TRUE,
                accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".csv")),

      tags$hr(),

      checkboxInput("header", "Header", TRUE),

      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),

      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),

      tags$hr(),

      radioButtons("disp", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head")

#      downloadButton("downloadData", "Download")
    ),

    mainPanel(

      tableOutput("DRC_grep")

    )

  )
)
#runApp()
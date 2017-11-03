library(shiny)

ui <- fluidPage(

  titlePanel("Uploading Files"),

  sidebarLayout(

    sidebarPanel(

      fileInput("file1", "Choose CSV, TT -> 1D",
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

      tableOutput("TT_1d")

    )

  )
)
#runApp()
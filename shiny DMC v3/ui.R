###app - DMC desc split vs dict vs lpo
###2019 June
###v2 typo: colnames(desc_map_lpo2)[4] <- "lv.Number"
###v3 use DT
library(shiny)
library(DT)
ui <- fluidPage(
  titlePanel("app - DMC GR description split vs lpo/dict"),
  sidebarLayout(
    sidebarPanel(
      textInput("text1", "what's your Tech Variant?", value = "DM-000282"),
      fileInput("file1", "File 1 = DM_layers.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      fileInput("file2", "File 2 = LCN.csv",
                multiple = TRUE,
                accept = c("text/csv",
	                        "text/comma-separated-values,text/plain",
	                        ".csv")),
##code HTML in shiny
##https://shiny.rstudio.com/articles/tag-glossary.html
tags$a(
  href="http://mptweb1/~pdkwadm/design_rules_diff_reports/WIP/130NM/BCD/Rev0.9_5.0_DRC02_D1/PSV/", 
    "e.g. PSV"),
#tags$a(href="https://text-compare.com/", "(2) Suggest to check text_diff"),
## <a href="www.rstudio.com">Click here!</a>
tags$br(),
tags$br(),
tags$a(
  href="https://drive.google.com/open?id=1cQLD3LPuqlf46k_puNMeIvux5tGXoks0", 
  "e.g. LCN"),
#tags$a(href="https://drive.google.com/open?id=1MKb-9hGF7S4KKJ16Cv54CuJrdXpNd_6G", "(3) Upload to google drive"),

tags$br(),
tags$br()
#            downloadButton("downloadData", "Download")
    ),
    mainPanel(
      #DTOutput tableOutput
      DTOutput("op1")
    )
  )
)
####################################################end
####################################################end
#Warning: Error in runApp: Can't call `runApp()` from within `runApp()`. 
#If your application code contains `runApp()`, please remove it.
#must below command separately
#runApp()
####################################################end
####################################################end
#Deploying applications
#http://docs.rstudio.com/shinyapps.io/getting-started.html#deploying-applications
#rsconnect::setAccountInfo(name='hch1', token='41CC9A84435E2E7CAE08CE65D932569D', secret='mEv+SQx+ACmrHLfl1qbGFdH/cc9EQj7lP8fymw3x')
##library(rsconnect)
##deployApp()
####################################################end
####################################################end
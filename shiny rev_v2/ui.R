###v1 2018
###v2 use DT
library(shiny)
library(DT)
ui <- fluidPage(
  titlePanel("app - DM's rev history"),
  sidebarLayout(
    sidebarPanel(
#	  textInput("text1", "what's your Tech Variant?", value = "000282"),
	  fileInput("file1", "File 1 = DRCTrack.csv",
	            multiple = TRUE,
	            accept = c("text/csv",
	                       "text/comma-separated-values,text/plain",
	                       ".csv")),
##code HTML in shiny
##https://shiny.rstudio.com/articles/tag-glossary.html
tags$a(
  href="http://mptweb1/~pdkwadm/design_rules_diff_reports/130NM/BCDLITE/Rev1.0_4.0_20190424/DRC/", 
  "e.g. DRCTrack.csv"),
#tags$a(href="https://text-compare.com/", "(2) Suggest to check text_diff"),
## <a href="www.rstudio.com">Click here!</a>
tags$br(),
tags$br()
#tags$a(
# href="https://drive.google.com/open?id=1cQLD3LPuqlf46k_puNMeIvux5tGXoks0", 
#  "e.g. LCN"),
    ),
    #mainPanel(
      #DTOutput tableOutput
      #DTOutput("DRC_grep")
###2 tables
#https://stackoverflow.com/questions/47915924/conditional-format-multiple-tables-in-shiny-r
fluidRow(
  column(12 
         , fluidRow(
           column(6, DT::dataTableOutput('op1'), style = "font-size: 
                  100%; width: 50%"),
           column(6, DT::dataTableOutput('op2'), style = "font-size: 
                  100%; width: 50%")
        )))
    #)
  )
)
####################################################end
####################################################end
#must below command separately
##runApp()
####################################################end
####################################################end
#Deploying applications
#http://docs.rstudio.com/shinyapps.io/getting-started.html#deploying-applications
#rsconnect::setAccountInfo(name='hch1', token='41CC9A84435E2E7CAE08CE65D932569D', secret='mEv+SQx+ACmrHLfl1qbGFdH/cc9EQj7lP8fymw3x')
##library(rsconnect)
##deployApp()
####################################################end
####################################################end
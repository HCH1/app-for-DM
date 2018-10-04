library(shiny)

ui <- fluidPage(
  
  titlePanel("Auto-export rev history app"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      fileInput("file1", "(1) Pls input DRCTrack.csv -> rev_hist",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),

##code HTML in shiny
##https://shiny.rstudio.com/articles/tag-glossary.html

tags$a(href="http://scgtweb/~pdkwadm/private/CLOO/22NM/FDX/Rev1.3_3.0_DRC02_D4/DRC/", "(1) e.g. DRCTrack.csv"),
## <a href="www.rstudio.com">Click here!</a>

tags$br(),
tags$br(),

tags$a(href="http://webdm.gfoundries.com:9080/WebDesignManual/Loginfail.jsp?message=%20You%20do%20not%20have%20access%20to%20any%20resources%20in%20WebDM.%20%20Please%20have%20WebDM%20support%20check%20your%20Company%20Group.", "(2) Pls upload to webDM")

      #      downloadButton("downloadData", "Download")
    ),
    
    mainPanel(
      
      tableOutput("DRC_grep")
      
    )
    
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
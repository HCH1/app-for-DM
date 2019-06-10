library(shiny)

ui <- fluidPage(
  
  titlePanel("Auto-export allow layer list app"),
  
  sidebarLayout(
    
    sidebarPanel(
	
	
	  textInput("text1", "what's your Tech Variant?", value = "22FDX"),
      
      fileInput("file1", "(1) Pls input LPO***.csv -> ALL",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),

##code HTML in shiny
##https://shiny.rstudio.com/articles/tag-glossary.html

tags$a(href="https://text-compare.com/", "(2) Suggest to check text_diff"),
## <a href="www.rstudio.com">Click here!</a>

tags$br(),
tags$br(),

tags$a(href="https://drive.google.com/open?id=1MKb-9hGF7S4KKJ16Cv54CuJrdXpNd_6G", "(3) Upload to google drive"),

tags$br(),
tags$br()

#            downloadButton("downloadData", "Download")
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
#v1 combine 3 apps in 1
#v2 add DM layers
#install.packages("shiny")
#install.packages("DT")
#install.packages("dplyr")
#install.packages("reshape2")
#install.packages("qdap")
library(shiny)
library(DT)
library(dplyr)
library(reshape2)
library(qdapDictionaries)
library(hunspell)
library(qdap)
library(reshape)
##https://cran.r-project.org/web/packages/textclean/readme/README.html#stashing-character-pre-sub
library(textclean)
#
#
ui <- fluidPage(
  titlePanel("app - automation of DM layers/ALL/DMC pre-check/LMT draft/pre-check/rev history/
             missing bracket,full-stop,typo"),
  sidebarLayout(
    sidebarPanel(
      textInput("text1", "what's your Tech Variant?", value = "DM-000064"),
      fileInput("file1", "File 1 = DM_GR_psv.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      fileInput("file2", "File 2 = LCN.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      #draft###################################################
      fileInput("file3", "File 3 = LM#.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      fileInput("file4", "File 4 = datamart_DRCTrack.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),		
      fileInput("file5", "File 5 = beautiful Truth Table.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),	
      fileInput("file5b", "File 5b = beautiful DL and description.csv",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),	
      ####################################################
      ##code HTML in shiny
      ##https://shiny.rstudio.com/articles/tag-glossary.html
      tags$a(
        href="http://scgtweb/~pdkwadm/design_rules_diff_reports/130NM/BCD/Rev0.9_5.0/PSV/", 
        "e.g. PSV"),
      #tags$a(href="https://text-compare.com/", "(2) Suggest to check text_diff"),
      ## <a href="www.rstudio.com">Click here!</a>
      tags$br(),
      tags$br(),
      tags$a(
        href="https://drive.google.com/open?id=1cQLD3LPuqlf46k_puNMeIvux5tGXoks0", 
        "e.g. LCN"),
      #tags$a(href="https://drive.google.com/open?id=1MKb-9hGF7S4KKJ16Cv54CuJrdXpNd_6G", "ALL uUpload to google drive"),
      tags$br(),
      tags$br(),
      tags$a(
        href="https://www.global-foundryview.com/Agile/PLMServlet?fromPCClient=true&module=ItemHandler&requestUrl=module%3DItemHandler%26opcode%3DdisplayObject%26classid%3D10000%26objid%3D444828717%26tabid%3D0%26", 
        "e.g. LM#"),
      tags$br(),
      tags$br(),
      tags$a(
        href="http://mptweb1/~pdkwadm/design_rules_diff_reports/130NM/BCDLITE/Rev1.0_4.0_20190424/DRC/", 
        "e.g. DRCTrack.csv"),
      tags$br(),
      tags$br(),
      ###
      tags$a(href="https://text-compare.com/", "Suggest to check ALL text_diff"),
      ## <a href="www.rstudio.com">Click here!</a>
      tags$br(),
      tags$br(),
      tags$a(href="https://drive.google.com/open?id=1MKb-9hGF7S4KKJ16Cv54CuJrdXpNd_6G", "Upload to google drive"),
      tags$br(),
      tags$br()
      #            downloadButton("downloadData", "Download")
    ),
    #mainPanel(
    #DTOutput tableOutput
    #DTOutput("DRC_grep")
    ###2 tables
    #https://stackoverflow.com/questions/47915924/conditional-format-multiple-tables-in-shiny-r
    #fluidRow(
    #  column(12 
    #         , fluidRow(
    #           column(6, DT::dataTableOutput('op1'), style = "font-size: 
    #                  88%; width: 50%"),
    #           column(6, DT::dataTableOutput('op2'), style = "font-size: 
    #                  88%; width: 50%")
    #        )))
    #draft###################################################
    #https://shiny.rstudio.com/gallery/datatables-demo.html
    #op1 <-> op3
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("GDS# table; CAD# table",
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op3'), style = "font-size: 
                  77%; width: 50%"),
                            column(6, DT::dataTableOutput('op3c'), style = "font-size: 
                  77%; width: 50%")
                          )))		
        ),
        #
        tabPanel("DMC pre-check",
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op1b'), style = "font-size: 
                  77%; width: 50%")
                          )))		
        ),
        #
        tabPanel("LMT draft; pre-check", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op2'), style = "font-size: 
                  77%; width: 50%"),
                            column(6, DT::dataTableOutput('op2b'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        ),
        #
        tabPanel("ALL; rev history", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op1'), style = "font-size: 
                  77%; width: 50%"),
                            column(6, DT::dataTableOutput('op3b'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        ),
        #
        tabPanel("missing bracket", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op4'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        ),
        #
        tabPanel("missing full stop", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op4b'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        ),
        #
        tabPanel("spell typo", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op4c'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        ),
        #
        tabPanel("TT value convert to touch or GR", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op5'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        ),
        #
        tabPanel("TT unpivot", 
                 fluidRow(
                   column(12 
                          , fluidRow(
                            column(6, DT::dataTableOutput('op5b'), style = "font-size: 
                  77%; width: 50%")
                          )))			
        )
        #
        ####################################################
        #)
      ))
    #
  ))
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
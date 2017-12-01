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
in11a <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in11a) #"character"
in11 <- in11a
ptn0 <- "[(]|[)]|[[]|[]]|[{]|[}]|[>]|[<]|[=]|[+]|[-]|[/]|[%]|[:]|[;]|[,]|[.]$"
in11 <- gsub(ptn0, " ", in11)
in11 <- unlist( strsplit( as.character( in11 ), '\\s' ) )
in11 <- grep("[0-9]|[[:punct:]]$|[A-Z]$|\\s|[_]", in11, value = TRUE, invert = TRUE) # patterns max 2K ea
#in11 <- grep("[0-9]|[[:punct:]]$|\\s", in11, value = TRUE, invert = TRUE) # patterns max 2K ea
#toks <- tokens(in11, remove_numbers = TRUE, remove_punct = TRUE)
toks <- in11
tok_ng <- tokens_ngrams(toks, n = 6, concatenator = " ")
tb0 <- table(tok_ng)
class(tb0) #table
length(tb0)
tb1 <- as.data.frame(tb0)
class(tb1) #table
tb2 <- tb1[ order(tb1$Freq, decreasing = TRUE), ] #order from big
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
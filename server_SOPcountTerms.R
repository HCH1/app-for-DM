options(shiny.maxRequestSize=30*1024^2) 
library(quanteda)
server <- function(input, output) {
####################################################
output$table1 <- renderTable({
req(input$file1)
in0 <- read.csv(input$file1$datapath, header = TRUE)
in1 <- in0
in11 <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in11) #"character"
ptn0 <- "[(]|[)]|[[]|[]]|[{]|[}]|[>]|[<]|[=]|[+]|[-]|[/]|[%]|[:]|[;]|[,]|[.]$"
in11 <- gsub(ptn0, " ", in11)
in11 <- unlist( strsplit( as.character( in11 ), '\\s' ) )
in11 <- grep("[0-9]|[[:punct:]]$|[A-Z]$|\\s", in11, value = TRUE, invert = TRUE) # patterns max 2K ea
o1 <- dfm(in11, ngrams = 1, tolower = FALSE, concatenator = " ")
class(o1) #"quanteda"
o2 <- as.data.frame(o1)
dim(o2)
o22 <- colSums(o2)
class(o22) #"numeric"
length(o22)
o222 <- sort(o22, decreasing = TRUE) #sort "numeric"
o2222 <- cbind(colnames(o222), o222)
dim(o2222)
o2222 <- cbind(rownames(o2222), o222)
dim(o2222)
colnames(o2222) <- c("word","freq")
class(o2222) #"matrix"
dim(o2222)
write.csv(x = o2222, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_WC_1grams.csv", sep = "") )
head(o2222,22)
})
}
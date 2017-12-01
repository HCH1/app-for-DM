##use table to draw sentence count
##https://stackoverflow.com/questions/26937960/creating-word-cloud-of-phrases-not-individual-words-in-r
library(wordcloud)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
class(in1) #dataframe
tb <- table(in1$Description)
class(in1$Description) #factor
length(in1$Description)
class(tb) #table
length(in1$Description)
#WC for 1 column
wordcloud(names(tb),as.numeric(tb), scale=c(8,.3),min.freq=1,max.words=100,
random.order=T, rot.per=.15, colors="black", vfont=c("sans serif","plain"))
####################################################end
####################################################end
##(2) use Corpus & VectorSource, but has lowercase issue.
##https://stackoverflow.com/questions/18101047/list-of-word-frequencies-using-r
library(wordcloud)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
cor1 <- Corpus( VectorSource( in1[,4] ) ) #in1$Description
class(cor1) #Corpus
cor11 = tm_map(cor1, removeNumbers) #removeNumbers
cor111 = tm_map(cor11, removePunctuation(cor11, preserve_intra_word_dashes = TRUE)) #

myTdm <- as.matrix( TermDocumentMatrix(cor111) )
df0 <- data.frame(tar = rownames(myTdm), 
                      freq = rowSums(myTdm), 
                      row.names = NULL)
df1 <- df0[ order(df0$freq, decreasing = TRUE), ] #order from big
class(df1) #dataframe
write.csv(x = df1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_GR_WC.csv", sep = "") )
wordcloud(words = df1$tar, freq = df1$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
####################################################end
####################################################end
##(3) 
##https://stackoverflow.com/questions/32113634/how-to-exactly-remove-the-punctuation-when-using-r-with-tm-package
library(tm)
library(SnowballC)
library(wordcloud)
##(3.1)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
cor1 <- Corpus( VectorSource( in1[,4] ) ) #in1$Description
#optoin 2
#in1 = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
#cor1 <- Corpus( VectorSource(in1) ) #in1$Description
##(3.2)
class(cor1) #Corpus
code <- cor1
#cleanse text
#code = tm_map(code, stripWhitespace)
#code = tm_map(code, removeWords,stopwords("en"))
#code = tm_map(code, removePunctuation)
#code = tm_map(code, removeNumbers)
class(code) #Corpus
#make DocumentTermMatrix
dtm = DocumentTermMatrix(code) #DocumentTermMatrix
freq = sort(colSums(as.matrix(dtm)),decreasing = T)
class(freq) #numeric
#wordcloud(code,scale = c(5,1),max.words = 50,random.order = F,colors = brewer.pal(8, "Dark2"),rot.per = 0.35,use.r.layout = F)
#wordcloud(names(freq),freq,scale = c(5,1),max.words = 50,random.order = F,
#colors = brewer.pal(8, "Dark2"),rot.per = 0.35,use.r.layout = F)
o1 <- as.data.frame(freq)
write.csv(x = o1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_GR_WC.csv", sep = "") )

wordcloud(names(freq), freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

barplot(freq[1:33], las = 2, names.arg = names(freq)[1:33],
        col ="lightblue", main ="Most freq words",
        ylab = "Word freq")
####################################################end
####################################################end
##(4)
##https://www.rdocumentation.org/packages/tm/versions/0.7-2/topics/termFreq
library(tm)
library(SnowballC)
library(wordcloud)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
#in1 = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
in2 <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in2) #"character"
##(4.1) use termFreq
o2 <- termFreq(in2)
class(o2) #"term_frequency" "table" 
##best (4.2) use table -> more close to intention
library(tm)
library(SnowballC)
library(wordcloud)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
#in1 = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
in2 <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in2) #"character"
tb <- table(in2)
class(tb) #table
tb1 <- as.data.frame(tb)
class(tb1) #table
tb2 <- tb1[ order(tb1$Freq, decreasing = TRUE), ] #order from big
write.csv(x = tb2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_WCbySplit.csv", sep = "") )

wordcloud(names(tb), as.numeric(tb), min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
##(4.3) use Corpus VectorSource
cor1 <- Corpus( VectorSource( tb1[,1] ) ) #in1$Description
class(cor1) #Corpus, but will become lowercase...cons
code <- cor1
#cleanse text
#code = tm_map(code, stripWhitespace)
#code = tm_map(code, removeWords,stopwords("en"))
code = tm_map(code, removePunctuation)
#code = tm_map(code, removeNumbers) 
class(code) #Corpus
# make DocumentTermMatrix
dtm = DocumentTermMatrix(code) #DocumentTermMatrix
freq = sort(colSums(as.matrix(dtm)),decreasing = T)
class(freq) #numeric
#wordcloud(code,scale = c(5,1),max.words = 50,random.order = F,colors = brewer.pal(8, "Dark2"),rot.per = 0.35,use.r.layout = F)
#wordcloud(names(freq),freq,scale = c(5,1),max.words = 50,random.order = F,
#colors = brewer.pal(8, "Dark2"),rot.per = 0.35,use.r.layout = F)
o1 <- as.data.frame(freq)
write.csv(x = o1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_GR_WC.csv", sep = "") )

wordcloud(names(freq), freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
####################################################end
####################################################end
##best (5) use quanteda
##https://stackoverflow.com/questions/17556085/compute-ngrams-for-each-row-of-text-data-in-r
##http://docs.quanteda.io/articles/examples/plotting.html
#install.packages("quanteda")
library(quanteda)
library(tm)
library(SnowballC)
library(wordcloud)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
#in1 = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
in11 <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in11) #"character"
#pelace certain punctuation
ptn0 <- "[(]|[)]|[[]|[]]|[{]|[}]|[>]|[<]|[=]|[+]|[-]|[%]|[:]|[;]|[,]|[.]$"
in111 <- gsub(ptn0, " ", in11)
length(in111)
in111 <- unlist( strsplit( as.character( in111 ), '\\s' ) )
length(in111)
#un-grep certain pattern
#ptn1 <- "[A-Z]$|[0-9]|[A-z0-9][.][A-z0-9]|[A-z0-9][_][A-z0-9]"
#in1111 <- grep(ptn1, in111, value = TRUE, invert = TRUE) # patterns max 2K ea
ptn1 <- "[a-z]$"
in1111 <- grep(ptn1, in111, value = TRUE, invert = FALSE) # patterns max 2K ea
in1111 <- grep("[0-9]", in1111, value = TRUE, invert = TRUE) # patterns max 2K ea
#in111 <- gsub("[[:upper:]]+", "", in111)
length(in1111)
head(in1111,33)
class(in1111) #"character"
o1 <- dfm(in1111, ngrams = 2, tolower = FALSE, concatenator = " ", remove = stopwords("english"), remove_punct = TRUE)
#o1 <- dfm(in2, ngrams = 3, tolower = FALSE, concatenator = " ", remove = stopwords("english"), remove_punct = TRUE)
#o1 <- dfm(in2, ngrams = 3, tolower = FALSE, concatenator = " ", verbose = FALSE)
class(o1) #"quanteda"
o2 <- as.data.frame(o1)
dim(o2)
o22 <- colSums(o2)
class(o22) #"numeric"
length(o22)
write.csv(x = o22, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_WC_quanteda.csv", sep = "") )

textplot_wordcloud(o1, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
####################################################end
####################################################end
##(5.1)
library(quanteda)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal - Copy.csv", header = TRUE)
in11 <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in11) #"character"
ptn0 <- "[(]|[)]|[[]|[]]|[{]|[}]|[>]|[<]|[=]|[+]|[-]|[/]|[%]|[:]|[;]|[,]|[.]$"
in11 <- gsub(ptn0, " ", in11)
in11 <- unlist( strsplit( as.character( in11 ), '\\s' ) )
in11 <- grep("[0-9]|[[:punct:]]$|[A-Z]$|\\s|[_]", in11, value = TRUE, invert = TRUE) # patterns max 2K ea
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
textplot_wordcloud(o1, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
####################################################end
####################################################end
##(5.2)
library(quanteda)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal - Copy.csv", header = TRUE)
in11 <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) )
class(in11) #"character"

#testText <- "The quick brown fox named Seamus jumps over the lazy dog also named Seamus, with
#             the newspaper from a boy named Seamus, in his mouth."
#testCorpus <- corpus(testText)
tokensAll <- tokens(char_tolower(in11), remove_punct = TRUE)
class(tokensAll)

#tokensNoStopwords <- tokens_remove(tokensAll, stopwords("english"))
#tokensNgramsNoStopwords <- tokens_ngrams(tokensNoStopwords, 2, concatenator = " ")

tokensNgramsNoStopwords <- tokens_ngrams(tokensAll, 2, concatenator = " ")
class(tokensNgramsNoStopwords)
featnames(dfm(tokensNgramsNoStopwords, verbose = FALSE))
####################################################end
####################################################end
##(5.3) best! use tokens_ngrams()
##http://docs.quanteda.io/reference/tokens_ngrams.html#details
library(quanteda)
library(tm)
library(SnowballC)
library(wordcloud)
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
in11a <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) ) #data.frame -> character
#in1 = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
#in11a <- unlist( strsplit( as.character( in1 ), '\\s' ) ) #data.frame -> character
class(in11a) #"character"
in11 <- in11a
ptn0 <- "[(]|[)]|[[]|[]]|[{]|[}]|[>]|[<]|[=]|[+]|[-]|[/]|[%]|[:]|[;]|[,]|[.]$" #replace punctuation
in11 <- gsub(ptn0, " ", in11)
in11 <- unlist( strsplit( as.character( in11 ), '\\s' ) )
in11 <- grep("[0-9]|[[:punct:]]$|[A-Z]$|\\s|[_]", in11, value = TRUE, invert = TRUE) # patterns max 2K ea
#in11 <- grep("[0-9]|[[:punct:]]$|\\s", in11, value = TRUE, invert = TRUE) # patterns max 2K ea
#toks <- tokens(in11, remove_numbers = TRUE, remove_punct = TRUE)
toks <- in11
tok_ng <- tokens_ngrams(toks, n = 6, concatenator = " ") #use tokens_ngrams
tb0 <- table(tok_ng) #can do freq sum
class(tb0) #table
length(tb0)
tb1 <- as.data.frame(tb0)
class(tb1) #table
tb2 <- tb1[ order(tb1$Freq, decreasing = TRUE), ] #order from big
write.csv(x = tb2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_WC_byTokens.csv", sep = "") )
head(tb2,22)
wordcloud(names(tb1), as.numeric(tb1), min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
####################################################end
####################################################end

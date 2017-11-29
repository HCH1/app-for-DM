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
##(2) use Corpus to draw WC
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
#optoin 1
in1 = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
cor1 <- Corpus( VectorSource( in1[,4] ) ) #in1$Description
#or optoin 2
#in1 = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
#cor1 <- Corpus( VectorSource(in1) ) #in1$Description
#
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
##(4.2) use table -> more close to intention
tb <- table(in2)
class(tb) #table
tb1 <- as.data.frame(tb)
class(tb1) #table
tb2 <- tb1[ order(tb1$Freq, decreasing = TRUE), ] #order from big
write.csv(x = tb2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_termFreq.csv", sep = "") )

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
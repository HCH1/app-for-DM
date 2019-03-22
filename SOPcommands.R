##auto-update R
# installing/loading the package:
if(!require(installr)) { install.packages("installr"); require(installr)} #load / install+load installr
# step by step functions:
check.for.updates.R() # tells you if there is a new version of R or not.
install.R() # download and run the latest R installer
copy.packages.between.libraries() # copy your packages to the newest R installation from the one version before it (if ask=T, it will ask you between which two versions to perform the copying)

#http://dbarneche.github.io/2014-12-11-ufsc/lessons/01-intro_r/data-structures.html
#R also has many data structures. These include: vector list matrix data_frame factors tables
dir()
getwd()
setwd('c://file/path')
version
class()
#show 'data.frame': x obs. of y variables:
str()
dim() 
length()
head()
as.data.frame()
as.character()
#Deploying applications
#http://docs.rstudio.com/shinyapps.io/getting-started.html#deploying-applications
rsconnect::setAccountInfo(name="<ACCOUNT>", token="<TOKEN>", secret="<SECRET>")
shiny::runApp()
library(rsconnect)
deployApp()
#read
#stringsAsFactors=FALSE can let is.na easy to do
lpo = read.csv("LPO-000172.csv", header = TRUE, stringsAsFactors=FALSE)
mx1[is.na(mx1)] <- ""
drc = readLines("merge22fdx1004.txt", warn = FALSE)
#read csv -> rows
lpo = readLines("LPO-000202.csv", warn = FALSE)
#keep original read
lpo1 <- lpo
#save without col_id by date
write.csv(x = lpo1_dm1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo1_dm1.csv", sep = "") )
#save as txt
write.table(x = drc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc1.txt", sep = "") )

#create new col
lpo1$x <- paste( lpo1$Data.Layer.Name, lpo1$GDS.Number, lpo1$GDS.Datatype, sep = "|", collapse = NULL )
#do filter
lpo2 <- lpo1[ which( lpo1[6]=="Active" ), ]
#do OR_filter
lpo22 <- lpo2[ which( lpo2[7]=="Common Design FEOL" | lpo2[7]=="Common Design BEOL" 
                     | lpo2[7]=="Marker Devices" | lpo2[7]=="Marker Voltage"
                     | lpo2[7]=="Marker ESD" | lpo2[7]=="Marker Floorplan"
                     | lpo2[7]=="Marker Metrology"
                     | lpo2[7]=="Design SRAM" | lpo2[7]=="Fill"), ]
#%in% operator returns TRUE or FALSE
#so can use as multi-lookup, then filter TRUE
usedcars$x <- usedcars$color %in% c("Black", "Gray", "Silver", "White")
table(usedcars$x)
FALSE	TRUE
51		99
#do OR_filter
lpo1_dm1 <- merge( lpo1, unique( dm1[6] ) )
#AND_rows
lpo3_dm_and_filter <- rbind(lpo1_dm1, lpo22)
#deduplicate
lpo3_dm_and_filter_uni <- unique(lpo3_dm_and_filter)
#vlookup
library(dplyr)
lpo3_dm_and_filter_uni2 <- left_join(lpo3_dm_and_filter_uni, dm1, by = "x")
#order
lpo3_dm_and_filter_uni2 <- lpo3_dm_and_filter_uni2[order(lpo3_dm_and_filter_uni2[43]), ]
#create counts_report
lpo2_feol <- lpo2[ which( lpo2[7]=="Common Design FEOL"), ]
lpo2_beol <- lpo2[ which( lpo2[7]=="Common Design BEOL"), ]
lpo2_device <- lpo2[ which( lpo2[7]=="Marker Devices" | lpo2[7]=="Marker Voltage" ), ]
lpo2_esd <- lpo2[ which( lpo2[7]=="Marker ESD"), ]
lpo2_general <- lpo2[ which( lpo2[7]=="Marker Floorplan"), ]
lpo2_pci <- lpo2[ which( lpo2[7]=="Marker Metrology"), ]
lpo2_sram <- lpo2[ which( lpo2[7]=="Design SRAM"), ]
lpo2_fill <- lpo2[ which( lpo2[7]=="Fill"), ]
#lpo2_sum <- lpo2[ which( lpo2[7]=="22FDX"), ]
lpo_count <- rbind( dim(lpo2_feol),dim(lpo2_beol),dim(lpo2_device),dim(lpo2_esd),
                    dim(lpo2_general),dim(lpo2_pci),dim(lpo2_sram),dim(lpo2_fill),
                    dim(lpo2),dim(unique(lpo2[1])) )
#
dm0_feol <- dm1[ which( dm1[5]=="FEOL"), ]
dm0_beol <- dm1[ which( dm1[5]=="BEOL"), ]
dm0_device <- dm1[ which( dm1[5]=="Device" ), ]
dm0_esd <- dm1[ which( dm1[5]=="ESD"), ]
dm0_general <- dm1[ which( dm1[5]=="General"), ]
dm0_pci <- dm1[ which( dm1[5]=="PCI"), ]
dm0_sram <- dm1[ which( dm1[5]=="SRAM"), ]
dm0_fill <- dm1[ which( dm1[5]=="Fill"), ]
dm_count <- rbind( dim(dm0_feol),dim(dm0_beol),dim(dm0_device),dim(dm0_esd),
                   dim(dm0_general),dim(dm0_pci),dim(dm0_sram),dim(dm0_fill),
                   dim(dm1), dim(unique(dm1[1])) )
#AND_cols
sum_count <- cbind( lpo_count[,1], dm_count[,1] )
#renamed
rownames(sum_count) <- c("FEOL","BEOL","Device","ESD","General","PCI","SRAM","Fill",
                         "database_dim","name_unique")
colnames(sum_count) <- c("LPO_external","DM_ch2.2")
colnames(f1) <- colnames(f2)
#reduce dim
length(sum2)
length(sum1)
sum2 <- sum2[ -(1:length(sum2)*0.95) ]
sum1 <- sum1[ -(1:length(sum1)*0.95) ]
length(sum2)
length(sum1)

#search then replace
sum2 <- gsub("<entry", "\n<entry", sum2)
sum2 <- gsub("<title", "\n<title", sum2)
##replace df text, use gsub, only can add new col.
diffdm1$v1 <- gsub("Same", "Updated", diffdm1$Type)
#mulit-search then replace
gsub('^.*This\\s*|\\s*first.*$', '', x)
#replace lower a-z, lead \\s, end \\s 
ddrc3 <- gsub("\\s[a-z]+|^[ ]+|[@]\\s|[ ]+$|[.]$", "", ddrc1v1)
#grep keywords
llpo2 <- grep("[!]|[#]|[$]|[%]|[&]|[+]|[=]", llpo, value = TRUE)
sum2v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum2, value = TRUE) #grep /entry & /title & _-fn#
sum1v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum1, value = TRUE) #grep /entry & /title & _-fn#
#grep dataframe contain keywords
lpo5 <- lpo4[grep("28LPSE", lpo4$TV),]
#grep invert = TRUE
ddrc1 <- grep("space", drc1, value = TRUE, invert = TRUE)
#grep 2K patterns
gr_col2_vcr1 <- gr_col2_vcr[1:2000]
ptn11 <- paste(gr_col2_vcr1, collapse="|") #"A|B|C"
dm11 <- grep(ptn11, dm1, value = TRUE, invert = TRUE) # patterns max 2K ea
#intersect vectors
dm6 <- intersect( intersect(dm11,dm22), dm33 )
#do diff
install.packages("diffobj")
library(diffobj)
vignette("diffobj", package="diffobj")
will_ = readLines("lpo_will.txt", warn = FALSE)
was_ = readLines("lpo_was.txt", warn = FALSE)
length(will_)
length(was_)
diffChr(was_, will_, color.mode="rgb")
diffPrint(target=sum2v1, current=sum1v1, color.mode="rgb")
#https://stackoverflow.com/questions/24858823/extract-data-from-pivot-table-to-data-frame-i-e-reverse-the-pivot
install.packages("reshape2")
library(reshape2)
i1 = read.csv("0705DTT.csv", header = TRUE)
#2d->1d
o1 <- melt(i1, id.vars = "Structure")
write.csv(x = o1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT.csv", sep = "") )
#Plot
pie(sum_count[,1])
#creat Matix
iter <- 10
out <- matrix(NA, nrow=iter, ncol=3)
###Template to solve rev_hist or tree_structure
col_a <- matrix( NA, nrow=dim(o2_col1_uni)[1], ncol=1 ) #create dummy n*1
col_b <- matrix( NA, nrow=dim(o2_col1_uni)[1], ncol=1 ) #create dummy n*1
col_d1 <- matrix( "{ ", nrow=dim(o2_col1_uni)[1], ncol=1 )
col_d2 <- matrix( " }", nrow=dim(o2_col1_uni)[1], ncol=1 )
col_d3 <- matrix( " touching ", nrow=dim(o2_col1_uni)[1], ncol=1 )
col_d4 <- matrix( " } is prohibited.", nrow=dim(o2_col1_uni)[1], ncol=1 )
#
for ( i in 1:dim(o2_col1_uni)[1] ){
#val = 1
o222_1 <- o22_1[o22_1[1]==paste( o2_col1_uni[i,],collapse=" " ), ]
o222_1_col1 <- o222_1
o222_1_col1 <- o222_1_col1[-1]
#col -> row, then convert to chara
o222t_vec_1_col1 <- as.vector(t(o222_1_col1))
o222t_vec_uni_1_col1 <- o222t_vec_1_col1[!duplicated(o222t_vec_1_col1)]
#merge chara into 1 chara
o222t_vec_uni_1_col1 <- paste( t(o222t_vec_uni_1_col1), collapse=" " )
#val = 0
o222 <- o22[o22[1]==paste( o2_col1_uni[i,],collapse=" " ), ]
o222 <- o222[-1]
o222t_vec <- as.vector(t(o222))
o222t_vec_uni <- o222t_vec[!duplicated(o222t_vec)]
o222t_vec_uni <- paste( t(o222t_vec_uni), collapse=" " )
#
col_a[i] <- o222t_vec_uni_1_col1
col_b[i] <- o222t_vec_uni
}
#{A1}{A2} touching {B} is prohibited.
ans3lite <- cbind(o2_col1_uni, col_a, col_b)
ans3 <- cbind(col_d1, o2_col1_uni, col_d2, col_d1, col_a, col_d2, col_d3, col_d1, col_b, col_d2, col_d4)
colnames(ans3lite) <- c("Structure","val=1","val=0")
#use as.character in for loop
for ( i in 1:dim(o2_1_uni2)[1] ){
o2_1_uni4 <- o2_1_uni[ which( o2_1_uni[2]==as.character( o2_1_uni2[i,1] ) ), ]
col_aa[i] <- dim(o2_1_uni4[1])
}
####################################################end
#insdie dataframe is factor -> character -> list -> character
split12 <- unlist( strsplit( as.character(ans3lite_order[1,2]), '\\s' ) )
#intersect( split12,split22 )
#intersect multi character
Reduce(intersect, list(split12,split22,split32,split42))
####################################################end
#col -> row, then convert to chara
ans3lite_order_col2vec <- as.vector( t(ans3lite_order[2]) )
#merge chara into 1 chara
ans3lite_order_col2vec_uni_t <- paste( t(ans3lite_order_col2vec), collapse=" " )
#split 1 chara into multi chara, then convert to dataframe
ans3lite_order_col2vec_uni_t_sp <- strsplit(ans3lite_order_col2vec_uni_t, '\\s')
ans3lite_order_col2vec_uni_t_sp_df <- as.data.frame(ans3lite_order_col2vec_uni_t_sp)
####################################################end
##(5.3) best! use tokens_ngrams()
##http://docs.quanteda.io/reference/tokens_ngrams.html#details
library(quanteda)
library(tm)
library(SnowballC)
library(wordcloud)
in11a <- unlist( strsplit( as.character( in1[,4] ), '\\s' ) ) #data.frame -> character
ptn0 <- "[(]|[)]|[[]|[]]|[{]|[}]|[>]|[<]|[=]|[+]|[-]|[/]|[%]|[:]|[;]|[,]|[.]$" #replace punctuation
in11 <- gsub(ptn0, " ", in11) #use tokens_ngrams
tok_ng <- tokens_ngrams(toks, n = 6, concatenator = " ")
tb0 <- table(tok_ng) #can do freq sum
wordcloud(names(tb1), as.numeric(tb1), min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
####################################################end
##ui template
library(shiny)
basicPage(
fileInput("file1", "Pls input _internal.csv -> word counts",
                multiple = TRUE,
                accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".csv")),
#plotOutput('plot1', width = "300px", height = "300px"),
#plotOutput("plot1")
##https://shiny.rstudio.com/reference/shiny/0.14/downloadHandler.html
downloadButton("downloadData", "Download"),
tableOutput("table1")
#  radioButtons('style', 'Progress bar style', c('notification', 'old')),
#  actionButton('goPlot', 'Go plot'),
#  actionButton('goTable', 'Go table')
)
#runApp()
####################################################end
##server template
options(shiny.maxRequestSize=30*1024^2) 
library(quanteda)
library(tm)
library(SnowballC)
library(wordcloud)
server <- function(input, output) {
##
output$table1 <- renderTable({
req(input$file1)
in0 <- read.csv(input$file1$datapath, header = TRUE)
in1 <- in0
##
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
####################################################end
##HTML template
#install.packages("XML")
library(XML)
#install.packages("rvest")
library(rvest)
#install.packages("magrittr")
library(magrittr)
#install.packages('rvest')
library(rvest)
##https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/
##https://stackoverflow.com/questions/33295686/rvest-error-in-open-connectionx-rb-timeout-was-reached
url1 = "http://www.imdb.com/title/tt1490017/" #
download.file(url1, destfile = "eg_imdb.html", quiet=TRUE)
#read html for download file
lego_movie <- read_html("eg_imdb.html")
####################################################end
library(gmodels)
usedcars = read.csv("usedcars.csv", header = TRUE)
usedcars$conservative <- usedcars$color %in% c("Black", "Gray", "Silver", "White")
#summarize 4 colors occur in $model 
CrossTable(x = usedcars$model, y = usedcars$conservative)
####################################################end
#replace matrix cell content
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"), labels = c("Benign", "Malignant"))
table(wbcd$diagnosis)
#prop.table() show freq then prob %
#round() show simple digits
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)
#sum certain clos
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])
#applies normalize() to cola 3-31, then converts resulting list to a data frame.
#and assigns it the name wbcd_n.
wbcd_n <- as.data.frame(lapply(wbcd[3:31], normalize))
####################################################end
fw1 <- gregexpr( pattern ="[|]", i1v1[60] ) #find position
char1 <- as.character(fw1) #c(17, 34, 42, 50, 63, 71, 92, 103, 112, 131)
df1 <- as.data.frame(fw1) #10r
df2 <- rbind(c(0), df1) #11r
df2v2 <- df2[ -dim(df2)[1], ] #10r
fw1_gap <- df1 - df2v2 #shift row
fw1_gap2 <- as.character(fw1_gap) #c(17, 17, 8, 8, 13, 8, 21, 11, 9, 19)
t1 = read.fwf( "cmos28g_tech - Copy lm.txt", skip=60, width = fw1_gap2 ) #split by fixed width
####################################################end
#ifelse as excel
lpse4$in.slphv <- ifelse(lpse4$GDS.Number.x.x.y > 0,"1","0")
#multi if
lpse4$Tech.Variant.v1 <- ifelse(lpse4$in.slphv == 1 & lpse4$in.lpse == 1,"28SLP-HV;28LPSe"
,ifelse(lpse4$in.slphv == 1 & lpse4$in.lpse == 0,"28SLP-HV"
,ifelse(lpse4$in.slphv == 0 & lpse4$in.lpse == 1,"28LPSE","NA")))
table(lpse4[length(lpse4)-1])
table(lpse4[length(lpse4)])
mydata$y = with(mydata, ifelse(x3 %in% c("A","B") , x1*2,
                  ifelse(x3 %in% c("C","D"), x1*3, x1*4)))
ifelse(mydata$x1<10 & mydata$x2>150,1,0)
ifelse(mydata$x1<10 | mydata$x2>150,1,0)
####################################################end
mx_rows <- dim(t(i1))[2]-1 #4999
mx_ratio <- 1 + mx_rows %/% 250 #1+59=60
for ( i in 1:mx_ratio ) {
from1 <- 250*(i - 1) + 2
end1 <- 250*i + 1
#want file name rule: 28SL_Migration__Bulk_Upload_0xx_start_0xxxx_end_0xxxx
num1 <- paste( "00", i, sep="" )
num1_r3 <- substr(num1, nchar(num1)-2, nchar(num1)) #0xx
mx_split <- rbind(mx_name, i1[from1:end1, ])
filename1 <- paste( "28SL_Migration__Bulk_Upload_", i, "_start_", from1-1, "_end_", end1-1, ".xls", sep="" )
#will save as xlsx or xls
write.xlsx(mx_split, file = filename1, sheetName="Sheet1",  col.names=FALSE, row.names=FALSE, append=FALSE, showNA=TRUE)
}
####################################################end
#after do left_join, new col is factor, 
#must convert to chr then do is.na again, then easy do ifelse
i1v4 <- left_join(i1v3, lpqrfqca22, by = "gds1")
i1v4$lpse.check <- as.character(i1v4$lpse.check)
#replace NA
i1v4[is.na(i1v4)] <- 0
#vlookup
###if want to connect col texts, use paste and save as new col.
i1v4$ans0 <- paste( i1v4$lpse.check, i1v4$hpp.check, i1v4$lpqrf.check, i1v4$lpqrfqca.check, sep = ";", collapse = NULL )
str(i1v4)
#vlookup
i1v4$ans1 <- ifelse(i1v4$ans0 == "1;1;1;1","28LPSE;28HPP;28LPQRF;28LPQRFQCA","")
####################################################end
filename1 <- paste( "28SL_Migration__Bulk_Upload_", num1_r3, "_start_", num2_r5, "_end_", num3_r5, ".csv", sep="" )
#better to use table to save as csv
write.table( x = mx_split, file = filename1, sep=",",  col.names=FALSE, row.names=FALSE )
####################################################end
#read htm
in1 = readLines("Pages from 22FDX_Rev1.3_3.0_PRE01-4.htm", warn = FALSE)
was1 <- "ELVTP"
will1 <- " will"
ptn1 <- paste( '<del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b>", sep="" )
#search then replace, both lower/uppercase
in2 <- gsub(was1, ptn1, in2, ignore.case = TRUE)
#save to htm
fileConn <- file("o1.htm")
writeLines(in2, fileConn)
close(fileConn)
####################################################end
####################################################end
###https://stackoverflow.com/questions/33018282/list-file-information-in-a-text-file-for-all-the-files-in-a-directory
###http://astrostatistics.psu.edu/su07/R/html/base/html/file.info.html
locpath <- getwd()
locpath_bf <- file.path( locpath, "130RFSOI_130RFSOI_V1000DRC02_Base", "Base" )
locpath_af <- file.path( locpath, "130RFSOI_130RFSOI_V1000FINAL_Base", "Base" )
###https://stat.ethz.ch/pipermail/r-help/2010-October/255439.html
###extract files info with correct path
#f1 <- file.info( list.files( path = "." ) ) #this is getwd()
f1bf <- file.info( list.files( path = locpath_bf, full.names=TRUE ) )
f1af <- file.info( list.files( path = locpath_af, full.names=TRUE  ) )
#write.csv(x = f1, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info v1.csv", sep = "") )
write.csv(x = f1bf, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info bf.csv", sep = "") )
write.csv(x = f1af, row.names = TRUE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_file info af.csv", sep = "") )
###full path -> only need base name
i1bf_v1$file.type <- basename( i1bf_v1[,1] )
i1af_v1$file.type <- basename( i1af_v1[,1] )
###vlookup full matrix
#i1bfaf_v1_diff <- left_join(i1bf_v1[1:2], i1bf_v1[1:2], by = "X")
i1bfaf_v1_diff <- full_join(i1af_v1, i1bf_v1, by = "file.type")
###verify size if diff
i1bfaf_v1_diff$size.diff <- ifelse(i1bfaf_v1_diff$size.x != i1bfaf_v1_diff$size.y
,"2","1")
###re-order
i1bfaf_v1_diff <- i1bfaf_v1_diff[ order( i1bfaf_v1_diff[ dim(i1bfaf_v1_diff)[2] ]
, na.last = FALSE, decreasing = TRUE ), ] #order reverse
####################################################end
####################################################end

####################################################end
####################################################end

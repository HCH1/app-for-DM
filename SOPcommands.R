--SQL --https://www.w3schools.com/sql/sql_syntax.asp
------------------------------------------------------------------------------
--demo
------------------------------------------------------------------------------
--Apr-16 get LCN release date
WITH lcnDate AS
(
SELECT TECH_NODE_PLMREV, TECH_NODE, CHANGE_NUMBER, RELEASE_DATE
FROM AGILEPLM.V_LMS_TECH_NODE_DETAILS
WHERE tech_node = '130G-LP' 
    OR tech_node = '180BSL'
    OR tech_node = 'CSOI8SW'
    OR tech_node = '160STM'
    ORDER BY TECH_NODE,
        cast(TECH_NODE_PLMREV as int) DESC --filter and order from big to small
)
--Apr-16 count monthly loading
FROM lcnDate
WHERE RELEASE_DATE LIKE '%-21%'
    AND RELEASE_DATE LIKE '%FEB%'
--Apr-15 find Fab7 with cols = rev LTN LCN FAB
WITH maxRevNum2 AS
(    
    SELECT TECH_NODE_PLMREV, TECH_NODE, CHANGE_NUMBER, FAB
    FROM AGILEPLM.V_LMS_TECH_NODE_DETAILS
    WHERE FAB IS NOT NULL
        AND REGEXP_LIKE(TECH_NODE_PLMREV, '[[:digit:]]')
        AND FAB LIKE '%7%'
            ORDER BY TECH_NODE, cast(TECH_NODE_PLMREV as int) DESC
)
--SELECT * FROM maxRevNum2
------------------------------------------------------------------------------
--Mar: code by Mini
--3 DB: AGILEPLM.V_LMS_TECH_NODE_DETAILS AGILEPLM.V_LMS_LAYER_VECTOR_DETAILS AGILEPLM.V_LMS_REL_LAYER_TABLE
------------------------------------------------------------------------------
WITH maxRevNum AS
(    
    SELECT MAX(to_number(TECH_NODE_PLMREV)) AS TECH_NODE_PLMREV, TECH_NODE
    FROM AGILEPLM.V_LMS_TECH_NODE_DETAILS
    WHERE tech_node <> 'Test_1234' and REGEXP_LIKE(TECH_NODE_PLMREV, '[[:digit:]]') group by tech_node
)
--SELECT * FROM maxrevnum
--WHERE tech_node <> 'Test_1234' ORDER BY cast(TECH_NODE_PLMREV as int) DESC
, LatestLCN AS
(
    SELECT LTN.TECH_NODE, LTN.TECH_NODE_PLMREV, LTN.CHANGE_NUMBER
    FROM AGILEPLM.V_LMS_TECH_NODE_DETAILS LTN, MaxRevNum MRT
    WHERE
        LTN.TECH_NODE = MRT.TECH_NODE
        AND LTN.TECH_NODE_PLMREV = TO_CHAR(MRT.TECH_NODE_PLMREV)
        AND MRT.TECH_NODE_PLMREV IS NOT NULL
)
--SELECT * FROM LatestLCN
, PrimaryData AS
(
    SELECT
        VEC.*
    FROM
        AGILEPLM.V_LMS_LAYER_VECTOR_DETAILS VEC,
        AGILEPLM.V_LMS_REL_LAYER_TABLE REL,
        LatestLCN LLCN
    WHERE
        REL.LV_PLMNUM = VEC.LV_PLMNUM
        AND REL.LV_PLMREV = VEC.LV_PLMREV
        AND NVL(VEC.RELEASE_TYPE,'xyz') <> 'Obsolete'
        AND REL.CHANGE_NUMBER = LLCN.CHANGE_NUMBER
)
------------------------------------------------------------------------------
--Apr-26 get details Fab7 DB
------------------------------------------------------------------------------
, PrimaryDataFab7 AS
(
    SELECT *
    FROM PrimaryData
	WHERE TECH_NODE='22FD' OR
		TECH_NODE='28SL' OR
		TECH_NODE='40LP' OR
		TECH_NODE='55LP' OR
		TECH_NODE='130G-LP' OR
		TECH_NODE='CSOI8SW' OR
		TECH_NODE='180BSL' OR
		TECH_NODE='110MCU' OR
		TECH_NODE='130RFSOI' OR
		TECH_NODE='CSOI9SW' OR
		TECH_NODE='65LP' OR
		TECH_NODE='45CD' OR
		TECH_NODE='45TTA' OR
		TECH_NODE='65CB' OR
		TECH_NODE='86SOIFSL' OR
		TECH_NODE='45SOI' OR
		TECH_NODE='65CM' OR
		TECH_NODE='65PMIC' OR
		TECH_NODE='65TTA' OR
		TECH_NODE='90LP' OR
		TECH_NODE='153CE' OR
		TECH_NODE='150LP' OR
		TECH_NODE='40BRCM' OR
		TECH_NODE='130ANA' OR
		TECH_NODE='45SOIFSL' OR
		TECH_NODE='65CD' OR
		TECH_NODE='65RFSOI' OR
		TECH_NODE='90CSOI' OR
		TECH_NODE='180SiGe' OR
		TECH_NODE='45CQ' OR
		TECH_NODE='55LPTTB' OR
		TECH_NODE='180RF' OR
		TECH_NODE='250LP' OR
		TECH_NODE='40CM' OR
		TECH_NODE='40TTD' OR
		TECH_NODE='65INTERPOSER' OR
		TECH_NODE='65K8' OR
		TECH_NODE='90K8' OR
		TECH_NODE='90SOI'
		ORDER BY TECH_NODE DESC
)
SELECT * FROM PrimaryDataFab7
------------------------------------------------------------------------------
--Apr-27 CC_87	[warning] For any LCN, New "Mask Number" = ij, where i avoid using "0-9" (PDK team concern). 
------------------------------------------------------------------------------
, PrimaryDataFab7 AS
(
    SELECT *
    FROM PrimaryData
	WHERE MASK_NUMBER IS NOT NULL
        AND MASK_NUMBER LIKE '2%'
            ORDER BY MASK_NUMBER DESC
)
SELECT * FROM PrimaryDataFab7
------------------------------------------------------------------------------
--Apr-26 get details Fab7 unique mask #DB
------------------------------------------------------------------------------
SELECT DISTINCT MASK_NUMBER 
FROM PrimaryDataFab7
ORDER BY MASK_NUMBER DESC
--SELECT * FROM PrimaryData order by tech_node
------------------------------------------------------------------------------
--Apr-15 get all Fab unique mask # DB
------------------------------------------------------------------------------
--SELECT DISTINCT MASK_NUMBER FROM PrimaryData --get all Fab unique mask # DB by (1) use Mini's DB
SELECT DISTINCT MASK_NUMBER FROM AGILEPLM.V_LMS_LAYER_VECTOR_DETAILS --(2) or use LV DB.
ORDER BY MASK_NUMBER
------------------------------------------------------------------------------
--Apr-16 get Fab7's LCN format DB
------------------------------------------------------------------------------
WITH fab7ltn AS
(    
    SELECT TECH_NODE_PLMREV, TECH_NODE, CHANGE_NUMBER, FAB --get cols belong to Fab7
    FROM AGILEPLM.V_LMS_TECH_NODE_DETAILS
    WHERE FAB IS NOT NULL 
        AND REGEXP_LIKE(TECH_NODE_PLMREV, '[[:digit:]]')
        AND FAB LIKE '%7%'
            ORDER BY TECH_NODE, cast(TECH_NODE_PLMREV as int) DESC
)
, fab7ltn2 AS
(    
    SELECT DISTINCT TECH_NODE --get unique LTN of Fab7
    FROM fab7ltn    
)
--SELECT * FROM fab7ltn2
--Apr-15 get Fab7 unique mask # DB 
, fab7ltn3 AS
(
--SELECT * FROM PrimaryData --(1) use Mini's DB
SELECT * FROM AGILEPLM.V_LMS_LAYER_VECTOR_DETAILS --(2) or use LV DB; get LCN DB of Fab7
WHERE TECH_NODE IN (SELECT TECH_NODE FROM fab7ltn2) --same as multi OR
)
, fab7ltn4 AS
(
SELECT DISTINCT MASK_NUMBER FROM fab7ltn3 --get unique mask # DB of Fab7
ORDER BY MASK_NUMBER
)
--SELECT * FROM fab7ltn4
, fab7ltn4b AS
(
SELECT * FROM AGILEPLM.V_LMS_LAYER_VECTOR_DETAILS --get LCN DB of Fab7 with unique mask # DB
WHERE MASK_NUMBER IN (SELECT MASK_NUMBER FROM fab7ltn4) --same as multi OR
ORDER BY MASK_NUMBER DESC, TECH_NODE DESC, LV_PLMREV DESC
)
SELECT * FROM fab7ltn4b

------------------------------------------------------------------------------
## win10 command
type *.cal > xx.csv

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
#check.names=FALSE
#https://stackoverflow.com/questions/27197617/filter-data-frame-by-character-column-name-in-dplyr
in4 = read.csv(file = paste(in1a, ".csv", sep = ""), 
               header=TRUE, stringsAsFactors=FALSE, check.names=FALSE)
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
##TOTO 4D
x <- 1:49
#https://www.singaporepools.com.sg/en/product/pages/toto_results.aspx
#
r0 <- "
10	15	16	24	45	47
Additional Number
19
10	26	27	36	37	43
Additional Number
42
"
#mulit-search then replace
r0a <- gsub("[a-zA-Z]", '', r0)
r0a <- gsub('\\n\\s\\n', ',', r0a)
r0a <- gsub('\\n|\\t',',', r0a)
r0a <- gsub('^.|.$', '', r0a)
r1 <- strsplit(r0a,',') %>% unlist
r1 <- as.numeric(r1)
#r1
r1 <- sort( unique(r1) )
#r1
table(sample(x[-r1], 6, replace=F))
table(sample(x[-r1], 6, replace=F))
table(sample(x[-r1], 6, replace=F))
###make a sub-ALL
TV_uwant <- "DM-000450"
ly_st <- "Active"
ly_cat <- "Marker Enablement"
#cal col freq
library(dplyr)
i1 = read.csv("8SWAPACPRE01 DM000432 (V1.3_1.0).csv", 
              header = TRUE, stringsAsFactors=FALSE)
ans <- table(i1)
ans <- as.data.frame(ans)
ans <- ans[ order(ans[2],
                  decreasing = TRUE), ]
ans[ is.na( ans ) ] <- ""
write.csv(x = ans, row.names = TRUE, 
          file = paste(format(Sys.time(), "%Y%m%d_%H"), 
                       "_8SWAPACPRE01 DM000432.csv", sep = "") )
###re-order
in1 <- in1[ order(in1[1], 
decreasing = TRUE), ]
###clean NA
in1[ is.na( in1 ) ] <- ""
###save as certain words
write.csv(x = in1, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"),"_",TV_uwant, 
"_ans v1.csv", sep = "") )
#save as txt
write.table(x = drc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc1.txt", sep = "") )
#create new col
lpo1$x <- paste( lpo1$Data.Layer.Name, lpo1$GDS.Number, lpo1$GDS.Datatype, sep = "|", collapse = NULL )
#do filter
lpo2 <- lpo1[ which( lpo1[6]=="Active" ), ]
# filter year in df
# https://blog.exploratory.io/filter-with-date-function-ce8e84be680
fig2019 <- filter(fig2b, Date.Originated >= "2019-01-01"
                  & Date.Originated <= "2019-12-31")
# split text in df
i1d <- separate(i1c,Date.Originated,sep=" "
                ,into=c("Date.Originated","v2","v3"))
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
##replace df text, use gsub, can add new col.
diffdm1$v1 <- gsub("Same", "Updated", diffdm1$Type)
###or replace same col
diffdm1$Type <- gsub("Same", "Updated", diffdm1$Type)
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
#grep dataframe contain keywords
lpo2 <- lpo2[grep("Cadence Auxiliary", lpo2$Layer.Category, invert = TRUE),]
lpo2 <- lpo2[grep("Generated Mask", lpo2$Layer.Category, invert = TRUE),]
lpo2 <- lpo2[grep("arker Enablement", lpo2$Layer.Category, invert = TRUE),]
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
###export sub LPO by wanted Category
#do OR_filter; use inner_join will keep only correct rows
sublpo_Category <- inner_join(i2, i1_v33_cate, by = "Layer.Category")
#do filter for correct TV
sublpo_Category_tv_will_vs_dm <- sublpo_Category[ which( sublpo_Category[11]=="130RFSOI" ), ]
#replace NA to blank
sublpo_Category_tv_will_vs_dm[ is.na( sublpo_Category_tv_will_vs_dm ) ] <- ""
####################################################end
###SOP to check two files diff: add new key col > xxx_join() > logic check > replace NA > save as
i2_v1a <- i2
i2_v1a$gds.pair <- paste( i2_v1a$GDS.Number, i2_v1a$GDS.Datatype, sep = ";", collapse = NULL )
#str(i2_v1a)
missing_TV_for_LCN <- inner_join(i2_v1a, cbind( i1_tv_v2[5], i1_tv_v2[1] ), by = "gds.pair")
#check DM name =? LPO name
missing_TV_for_LCN$ans.vs.dm.lpo.name <- ifelse(missing_TV_for_LCN$DM.Layer.Name == missing_TV_for_LCN$Data.Layer.Name ,"1","2")
#replace NA to blank
missing_TV_for_LCN[ is.na( missing_TV_for_LCN ) ] <- ""
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
###split col to cols by sep
library(tidyr)
in1_v11 <- separate(in1_v11,oa2,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
in2_v11 <- separate(in2_v11,oa2,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
in3_v11 <- separate(in3_v11,oa2,sep=";",into=c("Cadence.Layer.Purpose","Cadence.Purpose.OA.Number"))
###create a summary table
in4 <- full_join(in1_v11, in2_v11, by = "Cadence.Layer.Purpose")
in4 <- full_join(in4, in3_v11, by = "Cadence.Layer.Purpose")
in4[ is.na( in4 ) ] <- ""
####################################################end
####################################################end
####################################################end
library(qdapDictionaries)
library(NLP)
library(tm)
library(SnowballC)
###https://www.rdocumentation.org/packages/tm/versions/0.7-6/topics/Corpus
###load the dataset
i1 = read.csv("130BCDLITE_Rev1.0_4.0_DRC03_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
dataset_original <- i1
str(dataset_original)
corpus = VCorpus(VectorSource(dataset_original$Description))
#corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords())
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)
corpus
###Creating the Bag of Words model
dtm = TermDocumentMatrix(corpus)
dtm = removeSparseTerms(dtm, 0.999)
dataset = as.data.frame(as.matrix(dtm))
####################################################end
####################################################end
####################################################end
###case: dm.desc.split="" in.dict="" LV=has
###logic check by partial contain; use ifelse grepl
df$loc01 <- ifelse(grepl("non",df$loc_01),'outside','inside')
desc_map_lpo2$ans.missing.ly = ifelse(
desc_map_lpo2$dm.desc.split == ""
& desc_map_lpo2$in.dict == ""
& grepl("LV",desc_map_lpo2$ï..Number),"missing ly",0)
####################################################end
####################################################end
####################################################end
library(qdapDictionaries)
#create custom function
is.word <- function(x) x %in% GradyAugmented # or use any dataset from package
#use this function to filter words, df = dataframe from corpus
df0 <- desc_split_freq
df <- desc_split_freq
###dict only has lower case.
#df0$Data.Layer.Name <- tolower(df0$Data.Layer.Name)
df <- df[which(is.word(df$Data.Layer.Name)),]
###dm vs af-dict
desc_vs_dict <- full_join(df0, df, by = "Data.Layer.Name")
colnames(desc_vs_dict)[2] <- "dm.desc.split"
colnames(desc_vs_dict)[3] <- "in.dict"
write.csv(x = desc_vs_dict, row.names = TRUE, 
file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DMC_desc vs dict v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
###https://www.rdocumentation.org/packages/tm/versions/0.7-6/topics/Corpus
install.packages('tm')
install.packages('SnowballC')
library(tm)
library(SnowballC)
#load the dataset
dataset_original = read.csv(file.choose(), stringsAsFactors = FALSE)
corpus = VCorpus(VectorSource(dataset_original$Review))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords())
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)
###Creating the Bag of Words model
dtm = DocumentTermMatrix(corpus)
dtm = removeSparseTerms(dtm, 0.999)
dataset = as.data.frame(as.matrix(dtm))
dataset$Liked = dataset_original$Liked
####################################################end
####################################################end
####################################################end
###v2 2018
###v3 2019 June; re-write 
###v4 use DT
library(shiny)
library(DT)
ui <- fluidPage(
  titlePanel("app - LMS-to-ALL & LMS-to-DMC"),
  sidebarLayout(
    sidebarPanel(
	  textInput("text1", "what's your Tech Variant?", value = "000282"),
	  fileInput("file1", "File 1 = DM_psv.csv",
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
#tags$a(href="https://drive.google.com/open?id=1MKb-9hGF7S4KKJ16Cv54CuJrdXpNd_6G", "ALL uUpload to google drive"),
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
fluidRow(
  column(12 
         , fluidRow(
           column(6, DT::dataTableOutput('op1'), style = "font-size: 
                  75%; width: 50%"),
           column(6, DT::dataTableOutput('op2'), style = "font-size: 
                  75%; width: 50%")
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
####################################################end
#library(reshape2)
###v2 2018
###v3 2019 June; re-write 
###v4 use DT
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
####################################################
#renderDT renderTable
output$op1 <- renderDT({
req(input$file2)
diffdm0 <- read.csv(input$file2$datapath, header = TRUE)
lpo <- diffdm0
###
allowlayer1 <- rbind(lpo2_22fdx_act_cate_dedup, last_row)
###
###DT e.g.
#https://datatables.net/examples/basic_init/
DT::datatable(allowlayer1, 
              ###col search
              #https://rstudio.github.io/DT/009-searchable.html
              #https://shiny.rstudio.com/articles/datatables.html
              #filter = list(position = 'top', clear = FALSE),
              ###download
              #https://github.com/rstudio/DT/issues/267
              extensions = 'Buttons'
              , options = list( 
                ###highlight color
                #https://rstudio.github.io/DT/006-highlight.html
                lengthMenu = c(99999, -1), pageLength = 99999, searchHighlight = TRUE
                , dom = "Blfrtip"
                , buttons = 
                  list("copy", list(
                    extend = "collection"
                    #, buttons = c("csv", "excel", "pdf")
                    , buttons = c("csv")
                    , text = "Download"
                  ) ) )# end of buttons customization
              )
###
})
###
#renderDT renderTable 2
output$op2 <- renderDT({
  req(input$file1)
  i1 <- read.csv(input$file1$datapath, header = TRUE)
  i1_v1 <- i1
  ##
  req(input$file2)
  i2 <- read.csv(input$file2$datapath, header = TRUE)
  i2_v1 <- i2
  ##
  TV_uwant <- input$text1
  ly_st <- "Active"
  ly_cat <- "Marker Enablement"
  ly_cat2 <- "Generated Mask"
  ly_cat3 <- "Cadence Auxiliary"
  ###
###DT e.g.
  #https://datatables.net/examples/basic_init/
  DT::datatable(desc_map_lpo2, 
                ###col search
                #https://rstudio.github.io/DT/009-searchable.html
                #https://shiny.rstudio.com/articles/datatables.html
                #filter = list(position = 'top', clear = FALSE),
                ###download
                #https://github.com/rstudio/DT/issues/267
                extensions = 'Buttons'
                , options = list( 
                  ###highlight color
                  #https://rstudio.github.io/DT/006-highlight.html
                  lengthMenu = c(99999, -1), pageLength = 99999, searchHighlight = TRUE
                  , dom = "Blfrtip"
                  , buttons = 
                    list("copy", list(
                      extend = "collection"
                      #, buttons = c("csv", "excel", "pdf")
                      , buttons = c("csv")
                      , text = "Download"
                    ) ) )# end of buttons customization
  )
  ###
})
###
###
}
####################################################end
####################################################end
####################################################end
##input:
#i1 = read.csv("11 130BCD_Rev0.9_5.0_DRC01_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
##https://cran.r-project.org/web/packages/hunspell/vignettes/intro.html
##hunspell
text <- readLines("11 130BCD_Rev0.9_5.0_DRC01_internal.psv.csv", warn = FALSE)
bad_words <- hunspell(text, format = "latex")
bad2 <- sort(unique(unlist(bad_words)))
#bad3 is df
bad3 <- as.data.frame(bad2)
####################################################end
####################################################end
####################################################end
# Grouped Box Plots
# https://plot.ly/r/box-plots/
fig <- plot_ly(df
               , x = ~LTN, y = ~date_diff
               , color = ~only.year, type = "box")
fig <- fig %>% layout(boxmode = "group")
fig
####################################################end
#add col 2 to memo col 1 pattern
df_gds_xy$ans1 <- ifelse(grepl("LAYER",df_gds_xy$V1),1,
                        ifelse(grepl("DATATYPE",df_gds_xy$V1),2,
                        0 ))
#
m0 <- t( as.data.frame(c(0)) )
for (i in 1:dim(df_gds_xy)[1]) {
  #make a new df2, 1st row fix, equal sweep from i=2, check df1 logic, then do on df2.
  m1 <- ifelse(i==1,1,
               ifelse(df_gds_xy$ans1[i]==1,
               m0[(i-1)]+1,
               m0[i]
               ))
    #after merge, then return to m0, so can loop
    m0 <- rbind(m0,m1)
}
#
m0 <- t( as.data.frame(c(0)) )
for (i in 1:dim(df_gds_xy)[1]) {
  #i=1
  m1 <- ifelse(i==1,paste(df3col[1,1],df3col[2,1], sep = "", 
                          collapse = NULL),
	       #check df1 logic, then do on df2.
               ifelse(df3col$shape[i]==df3col$shape[(i-1)],
                      m0[i],
                      paste(df3col[i,1],df3col[(i+1),1], sep = "", 
                            collapse = NULL)
               ))
  m0 <- rbind(m0,m1)
}
#split df col by text
df5col_v1 <- separate(df4col_v1, V1, 
                      sep=";" ,into=c("x","y"))
############################################################
#Pcell convert to layer/device TT
#find the position 1, then we know what is the start point fo each group.
string <- as.character( t(pcell2TTv4b[2]) )
pattern <- c("1")
pos1 <- grep(pattern, string)
pos1 <- as.character(pos1)
#e.g. 3 groups should have 4 vertex
pos1b <- c( pos1, ( dim(pcell2TTv4b)[1]+1 ) )
#
m0 <- t( as.data.frame(c(0,0,0)) )
for (i in 1:length(pos1)) {
  #i=1
  a <- as.numeric( pos1b[i] )
  b <- as.numeric( pos1b[(i+1)] ) - 1
  #same as filter each group
  m1 <- pcell2TTv4b[a:b,]
  #gds de-duplicate
  m1_uni <- unique( m1[1] )
  m2 <- cbind(i,m1[1,1],m1_uni)
  #remove lv1 NAME data
  m2 <- m2[-1,]
  colnames(m2) <- c("group","device","gds")
  colnames(m0) <- colnames(m2)
  m3 <- rbind(m0,m2)
  #end -> new start
  m0 <- m3
}
#https://www.rforexcelusers.com/make-pivottable-in-r/
pcell_TTv2 = dcast(pcell_TT, device ~ gds, value.var = "TT")
pcell_TTv2[ is.na( pcell_TTv2 ) ] <- 0
#
############################################################
#library(tidyr)
#due to col=Layer.Sub.Category might be DM1;DM2;DM3, need to split DM# to rows
lcn_demo2 <- separate_rows(lcn_demo2, Layer.Sub.Category, sep = ";")
#split multi devices into rows, then do a df 
m0 <- as.data.frame( t( as.data.frame(c(0,0)) ) )
for (i in 1:dim(lcn_demo4[1])[1] ) {
  #i=1
  a1 <- lcn_demo4[i,2]
  a2 <- as.data.frame( strsplit( as.character(a1), "," ) )
  a3 <- cbind(lcn_demo4[i,1], a2)
    colnames(a3) <- c("V1","V2")
  m1 <- rbind(m0,a3)
  m0 <- m1
}
lcn_demo5 <- m0[-1,]
#
m0 <- as.data.frame( t( as.data.frame(c(0,0)) ) )
for (i in 1:dim(lcn_demo_glo2_col1)[1] ) {
  #i=1
  a0 <- lcn_demo_glo2_col1[i,1]
  a1 <- lcn_demo_glo2[ which( lcn_demo_glo2[1]==a0 ), ]
  a2 <- as.data.frame( paste( a1[2], sep = ",", collapse = NULL ) )
  a3 <- cbind(a0, a2)
  colnames(a3) <- c("V1","V2")
  m1 <- rbind(m0,a3)
  m0 <- m1
}
lcn_demo_glo3 <- m0[-1,]
#clean text
lcn_demo_glo3$V2 <- gsub('["]', "", lcn_demo_glo3$V2) #if want to replace ", then use '["]'
#multi cols -> 1 col
lcn_demo_glo5 <- unite(lcn_demo_glo4, V3, V4, V5
                       ,col = "Description", sep = "")
  colnames(lcn_demo_glo5) <- c("Abbreviation","Notes","Definition")
############################################################
#If you have multiple CSV files instead of Excel files, here is one for you.
library(readr)
temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read.csv)
len1 <- length(myfiles)
col1 <- matrix(NA, nrow=1, ncol=1) #create dummy 1*1
for (i in 1:len1) {
  photo1 <- myfiles[[i]]$Mask.Number %>% unique %>% as.data.frame
  colnames(photo1) <- "V1"
  ans <- rbind(col1,photo1) %>% unique
  ans <- as.data.frame(ans)
  col1 <- ans
}
############################################################
#May-6
#Fab7 left mask# DB
in1 = read.csv("fab7 mini db May6.csv", header=TRUE, stringsAsFactors=FALSE)
colnames(in1) <- c("V1","V2")
abcd <- LETTERS[1:26] %>% as.data.frame
colnames(abcd) <- c("V1")
#grep dataframe contain keywords
abcd1 <- abcd[grep("[I]|[O]|[X]", abcd$V1, invert = TRUE),] %>% as.data.frame
colnames(abcd1) <- c("V1")
num1 <- matrix(0:9, nrow=10, ncol=1) %>% as.data.frame
col2 <- rbind(num1, abcd1)

col0 <- matrix(NA, nrow=1, ncol=1) #create dummy 1*1
for (i in 1:dim(abcd)[1]) {
  ans <- cbind(abcd[i,], col2)
  ans_1col <- paste(ans[,1], ans[,2], sep="") %>% as.data.frame
  colnames(ans_1col) <- c("V1")
  ans_1colv1 <- rbind(col0, ans_1col)
  col0 <- ans_1colv1
}
ans <- col0 %>% drop_na()

ans1 <- anti_join(ans, in1[1], by = "V1")
write.csv(x = ans1, row.names = TRUE, 
          file = "fab7 left can use mask (by R).csv")

ans2 <- ans
colnames(ans2) <- c("V2")
ans2 <- anti_join(ans2, in1[2], by = "V2")
write.csv(x = ans2, row.names = TRUE, 
          file = "fab_all left can use mask (by R).csv")
############################################################
#Jul-13 waiver list and common layers
in1 <- "600HV v4"
in2 <- "common layer 2019Dec"
in130 = read.csv(file = paste(in1, ".csv", sep = ""), 
                 header=TRUE, stringsAsFactors=FALSE)
in130b = read.csv(file = paste(in2, ".csv", sep = ""), 
                  header=TRUE, stringsAsFactors=FALSE)
inx <- in130
iny <- in130b
colnames(iny)[1] <- "Data.Layer.Name"

inx$gds2 <- paste( inx$GDS.Number, inx$GDS.Datatype,
                   sep = ";", collapse = NULL )
iny$gds2 <- paste( iny$GDS.Number, iny$GDS.Datatype,
                   sep = ";", collapse = NULL )
iny <- iny[ order(iny$gds2, decreasing = FALSE), ]

vs1 <- full_join(iny, inx, by = "gds2")
vs1[ is.na( vs1 ) ] <- ""
vs1 <- vs1[ order(vs1$gds2, decreasing = FALSE), ]

vs1$naming.vs <- ifelse(vs1$Data.Layer.Name.x != "" &
                          vs1$Data.Layer.Name.y != "" &
                          vs1$Data.Layer.Name.x != vs1$Data.Layer.Name.y
                     ,"naming diff","safe")

vs2 <- vs1[ which( vs1$naming.vs=="naming diff" ), ]

test1 <- table(vs1[5]) %>% as.data.frame
test1 <- test1[ order(test1$Freq, decreasing = TRUE), ]
#freq > 1
test2 <- test1[ which( test1[2]>1), ]
#do OR_filter; use inner_join will keep only correct rows
colnames(test2)[1] <- "gds2"
vs1b <- inner_join(vs1, test2, by = "gds2")

#from freq >1 to generate waiver list 4 col for Krishna
m0 <- t( as.data.frame(c(0,0,0,0)) )
for (i in 1:dim(test2)[1]) {
  #i=2
  a0 <- test2[i,1] %>% as.character
  vs1b1 <- vs1b[ which( vs1b[5]==a0 ), ] #only chr can do which == filter
  col1 <- cbind(vs1b1[1],vs1b1[7])
  col1a <- unique(unlist(col1)) #split cells into chr
  col1b <- paste(col1a, collapse = ";") #merge chr become 1 term
  col1b <- gsub('[;]$', '', col1b) #clean end is ;
  
  col2 <- cbind(vs1b1[3],vs1b1[4]) %>% unique
  
  ans <- cbind(in1,col1b,col2) # make 4 col: tech name gds
  colnames(ans) <- c("V1","V2","V3","V4")
  m1 <- rbind(m0,ans)
  m0 <- m1
}
m2 <- m0[-1,] 

#from vs1$naming.vs=="naming diff", to generate waiver list 4 col for Krishna
m0 <- t( as.data.frame(c(0,0,0,0)) )
for (i in 1:dim(vs2)[1]) {
  #i=2
  a0 <- vs2[i,5] %>% as.character
  vs1b1 <- vs2[ which( vs2[5]==a0 ), ] #only chr can do which == filter
  col1 <- cbind(vs1b1[1],vs1b1[7])
  col1a <- unique(unlist(col1)) #split cells into chr
  col1b <- paste(col1a, collapse = ";") #merge chr become 1 term
  col1b <- gsub('[;]$', '', col1b) #clean end is ;
  
  col2 <- cbind(vs1b1[3],vs1b1[4]) %>% unique
  
  ans <- cbind(in1,col1b,col2) # make 4 col: tech name gds
  colnames(ans) <- c("V1","V2","V3","V4")
  m1 <- rbind(m0,ans)
  m0 <- m1
}
m3 <- m0[-1,] 

m2 <- rbind(m2,m3) %>% unique

write.csv(x = m2, row.names = TRUE, 
          file = paste(in1, " waivers (by R) v1.csv", sep = "") )
write.csv(x = test1, row.names = TRUE, 
          file = paste(in1, " GDS freq (by R) v1.csv", sep = "") )
write.csv(x = vs1b, row.names = TRUE, 
          file = paste(in1, " freq bigger 1 (by R) v1.csv", sep = "") )
write.csv(x = vs1, row.names = TRUE, 
          file = paste(in1, " vs ", in2, " (by R) v1.csv", sep = "") )
############################################################
#https://stackoverflow.com/questions/27197617/filter-data-frame-by-character-column-name-in-dplyr
bf_melt1aa <- bf_melt1a %>% filter_at(vars( as.character( (tt1freq[i,1]) ) ), any_vars(. != 0)) #better for sub-TT colname=EFUSE v!=0
#bf_melt1b <- bf_melt1a %>% filter_(paste(as.character( (ans[1,1]) ), "!=", 0)) #colname=EFUSE, v!=0

############################################################

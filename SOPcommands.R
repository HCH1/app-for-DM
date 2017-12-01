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
lpo = read.csv("LPO-000172.csv", header = TRUE)
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
#mulit-search then replace
gsub('^.*This\\s*|\\s*first.*$', '', x)
#replace lower a-z, lead \\s, end \\s 
ddrc3 <- gsub("\\s[a-z]+|^[ ]+|[@]\\s|[ ]+$|[.]$", "", ddrc1v1)
#grep keywords
llpo2 <- grep("[!]|[#]|[$]|[%]|[&]|[+]|[=]", llpo, value = TRUE)
sum2v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum2, value = TRUE) #grep /entry & /title & _-fn#
sum1v1 <- grep("[/]entry|[/]title|[_][-]fn[0-9]", sum1, value = TRUE) #grep /entry & /title & _-fn#
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
diffChr(sum1, sum2, color.mode="rgb")
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

####################################################end

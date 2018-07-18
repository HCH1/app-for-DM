#install.packages("zoo")
#library(zoo)
in1 = readLines("Pages from 22FDX_Rev1.3_3.0_PRE01-4.htm", warn = FALSE)
str(in1)
head(in1)
in2 <- in1
#grep except
in2 <- grep("<IMG", in2, value = TRUE, invert = TRUE)
#grep certain
#in2 <- grep("ELVTP", in2, value = TRUE, invert = FALSE)
was1 <- "ELVTP"
will1 <- "will"
ptn1 <- paste( '<del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b>", sep="" )
#search then replace
in2 <- gsub(was1, ptn1, in2, ignore.case = TRUE)
##
##was1 <- "elvtp"
##will1 <- "will"
##ptn1 <- paste( '<del><b><font color="red">', was1, "</font></b></del>",
##'<b><font color="blue">', will1, "</font></b>", sep="" )
##in2 <- gsub(was1, ptn1, in2)
#save to htm
fileConn <- file("o1.htm")
writeLines(in2, fileConn)
close(fileConn)
####################################################end
####################################################end


lpo = read.csv("LPO-000321 22FD.csv", header = TRUE)
#merge column 2 6 7 17 18
lpo2 <- cbind(lpo[2],lpo[17],lpo[18],lpo[6],lpo[7],lpo[11])
write.csv(x = lpo2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2.csv", sep = "") )
#filter Tech Variant != blank
lpo2_22fdx <- lpo2[lpo2[6]!="", ]
#filter Layer Status == Active
lpo2_22fdx_act <- lpo2_22fdx[lpo2_22fdx[4]=="Active", ]
#filter Layer Category != 
lpo2_22fdx_act_cate <- lpo2_22fdx_act[lpo2_22fdx_act[5]!="Cadence Auxiliary", ]
lpo2_22fdx_act_cate <- lpo2_22fdx_act_cate[lpo2_22fdx_act_cate[5]!="Generated Mask", ]
lpo2_22fdx_act_cate <- lpo2_22fdx_act_cate[lpo2_22fdx_act_cate[5]!="Unknown", ]
write.csv(x = lpo2_22fdx_act_cate, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo2_22fdx_act_cate.csv", sep = "") )
#re-bind 3 columns
lpo2_22fdx_act_cate_3cols <- cbind(lpo2_22fdx_act_cate[1],lpo2_22fdx_act_cate[2],lpo2_22fdx_act_cate[3])
#remove duplicates
lpo2_22fdx_act_cate_dedup <- unique(lpo2_22fdx_act_cate_3cols) 
#re-order col 2 & 3
lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[ order(lpo2_22fdx_act_cate_dedup[,2], lpo2_22fdx_act_cate_dedup[,3]), ]
#remove last row -> why?
#lpo2_22fdx_act_cate_dedup <- lpo2_22fdx_act_cate_dedup[-dim(lpo2_22fdx_act_cate_dedup)[1],]
#will rbind c("Customer_Reserved_layers", "2000-2300", "0-9999")
last_row <- matrix(c("Customer_Reserved_layers", "2000-2300", "0-9999"), nrow = 1)
colnames(last_row) <- colnames(lpo2_22fdx_act_cate_dedup)
allowlayer1 <- rbind(lpo2_22fdx_act_cate_dedup, last_row)
write.csv(x = allowlayer1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_allow_layer_ans.csv", sep = "") )
#do summary table
sum_count <- rbind( dim(lpo2_22fdx),dim(lpo2_22fdx_act),dim(lpo2_22fdx_act_cate),dim(lpo2_22fdx_act_cate_dedup) )
rownames(sum_count) <- c("LPO_22FDX","LPO_filter1","LPO_filter2","LPO_ans")
colnames(sum_count) <- c("ea rows","ea columns")
write.csv(x = sum_count, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum_count.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
#install.packages("diffobj")
#vignette("diffobj", package="diffobj")
#sum1 = read.csv("20170215_sum_count.csv", header = TRUE)
#sum2 = read.csv("20170215_sum_count2.csv", header = TRUE)
#diffPrint(target=sum2, current=sum1, color.mode="rgb")
#
#tt1 = read.csv("tt1.csv", header = TRUE)
#tt2 = read.csv("tt2.csv", header = TRUE)
#diffPrint(target=tt2, current=tt1, color.mode="rgb" )
####### end
#diffPrint(target=tt2, current=tt1, color.mode="rgb", disp.width = 200 )
#diffStr(target=tt2, current=tt1, color.mode="rgb")
#
#sum11 <- c(sum1)
#as.vector(sum1)
#rapply(sum1, c)
#sum1 <- data.frame(sum1)
#sum22 <- c(sum2)
#diff12 <- sum22[!(sum22 %in% sum11)]
#sum11
#sum22
#diff12
### 
#https://cran.r-project.org/web/packages/diffobj/vignettes/diffobj.html
#install.packages("diffobj")
#vignette("diffobj", package="diffobj")
#library(diffobj)
#a <- b <- matrix(1:100, ncol=2)
#a <- a[-20,]
#b <- b[-45,]
#b[c(18, 44)] <- 999
#diffPrint(target=a, current=b)
#identical(sum11,sum22)
#all.equal(readLines(20170215_sum_count.csv), readLines(20170215_sum_count2.csv)) 
#sum2 <- data.frame(sum2)
#diff_log <- compare(sum11,sum22,allowAll=TRUE)
#diff_log
#diff12 <- all.equal(sum1, sum2)
#diff2 <- sum22[setdiff(intersect(sum22, sum11)),]
###
#install.packages("zoo")
#library(zoo)
sfbug = read.csv("20170203SFbugs.csv", header = TRUE)
sfbug_col2 <- unique(sfbug[2]) #Product/Technology
sfbug_col4 <- unique(sfbug[4]) #Status
sfbug_col5 <- unique(sfbug[5]) #Component
sfbug_col11 <- unique(sfbug[11]) #DM Team Classification
#col11 <- as.Date(as.yearmon(sfbug[13]))
#sfbug_col13 <- unique(sfbug[13]) #Bug/Work Request: Last Modified By
#dmy <- sfbug[order(as.Date(sfbug[13],format="%d/%m/%Y")),,drop=FALSE]

sfbug[13] <- as.Date(sfbug[,13], format= "%d/%m/%Y")
write.csv(x = sfbug, file = paste(format(Sys.time(), "%Y%m%d"), "_sfbug.csv", sep = "") )
#write.csv(x = sfbug, file = "sfbug.csv")
#Design Manual	
#22FDX 22FDSOI 22SOI
sfbug_orig <- sfbug[ which( sfbug[2]=="22FDX" | sfbug[2]=="22FDSOI" | sfbug[2]=="22SOI"), ]
bug_all <- sfbug[ which( sfbug[2]=="22FDX" | sfbug[2]=="22FDSOI" | sfbug[2]=="22SOI"), ]
bug_all <- bug_all[bug_all[5]=="Design Manual", ]
#to filter date region 11/10-1/31
bug_all <- bug_all[ bug_all[13] >= "2016-11-10", ]
bug_all <- bug_all[ bug_all[13] <= "2017-01-31", ]
write.csv(x = sfbug_orig, file = paste(format(Sys.time(), "%Y%m%d"), "_sfbug_orig.csv", sep = "") )
write.csv(x = bug_all, file = paste(format(Sys.time(), "%Y%m%d"), "_bug_all.csv", sep = "") )

#Resolved
#Verified
#Closed
close_all <- bug_all[ which( bug_all[4]=="Resolved" | bug_all[4]=="Verified" | bug_all[4]=="Closed") , ]
open_all <- bug_all[ which( bug_all[4]!="Resolved" & bug_all[4]!="Verified" & bug_all[4]!="Closed") , ]
write.csv(x = close_all, file = paste(format(Sys.time(), "%Y%m%d"), "_close_all.csv", sep = "") )
write.csv(x = open_all, file = paste(format(Sys.time(), "%Y%m%d"), "_open_all.csv", sep = "") )
open_DM <- open_all[ which( open_all[11]=="Error (Others)" | open_all[11]=="Typo Implementation" | open_all[11]=="Typo Proposal" | open_all[11]=="Inadequate Proposal" | open_all[11]=="Need IAD"  | open_all[11]=="Neglected Related Content" | open_all[11]=="Scope changed"), ]
write.csv(x = open_DM, file = paste(format(Sys.time(), "%Y%m%d"), "_open_DM.csv", sep = "") )

#(blank)
#Work Request
#Enhancement Request
#Question (No Update Required)
#Question
#Invalid Bug
open_Enhance <- open_all[open_all[11]=="Enhancement Request", ]
open_Work <- open_all[open_all[11]=="Work Request", ]
open_Ques <- open_all[which( open_all[11]=="Question (No Update Required)" | open_all[11]=="Question"), ]
open_Invalid <- open_all[open_all[11]=="Invalid Bug", ]
open_Blank <- open_all[open_all[11]=="", ]
write.csv(x = open_Enhance, file = paste(format(Sys.time(), "%Y%m%d"), "_open_Enhance.csv", sep = "") )
write.csv(x = open_Work, file = paste(format(Sys.time(), "%Y%m%d"), "_open_Work.csv", sep = "") )
write.csv(x = open_Ques, file = paste(format(Sys.time(), "%Y%m%d"), "_open_Ques.csv", sep = "") )
write.csv(x = open_Invalid, file = paste(format(Sys.time(), "%Y%m%d"), "_open_Invalid.csv", sep = "") )
write.csv(x = open_Blank, file = paste(format(Sys.time(), "%Y%m%d"), "_open_Blank.csv", sep = "") )

sum_count <- rbind( dim(open_DM),dim(open_Enhance),dim(open_Work),dim(open_Ques),dim(open_Invalid),dim(open_Blank),dim(close_all) )
rownames(sum_count) <- c("open_DM","open_Enhance","open_Work","open_Ques","open_Invalid","open_Blank","close_all")
colnames(sum_count) <- c("bug (ea)","")
write.csv(x = sum_count, file = paste(format(Sys.time(), "%Y%m%d"), "_sum_count.csv", sep = "") )

#Plot the chart.
pie(sum_count[,1])
#-------------------
#(blank)
#Work Request
#Enhancement Request
#Question (No Update Required)
#Question
#Invalid Bug
#nonDMbug <- sfbug1[ which( sfbug1[11]=="Enhancement request" | sfbug1[11]=="Work request" | sfbug1[11]=="Invalid Bug" | sfbug1[11]=="Question (No Update Required)") , ]
#nonDMbug_withBlank <- sfbug1[ which( sfbug1[11]=="" | sfbug1[11]=="Enhancement request" | sfbug1[11]=="Work request" | sfbug1[11]=="Invalid Bug" | sfbug1[11]=="Question (No Update Required)") , ]
#Typo Proposal
#Error (Others)
#Inadequate Proposal
#Typo Implementation
#Scope changed
#Neglected Related Content
#DMbug <- sfbug1[ which( sfbug1[11]=="Error (Others)" | sfbug1[11]=="Typo Implementation" | sfbug1[11]=="Typo Proposal" | sfbug1[11]=="Inadequate Proposal" | sfbug1[11]=="Need IAD"  | sfbug1[11]=="Neglected Related Content" | sfbug1[11]=="Scope changed") , ]
#write.csv(x = nonDMbug, file = "nonDMbug.csv")
#write.csv(x = DMbug, file = "DMbug.csv")
#blank <- sfbug1[ sfbug1[11]=="" , ]

#Resolved
#Verified
#Closed
#nonDMbug_close <- nonDMbug[ which( nonDMbug[4]=="Resolved" | nonDMbug[4]=="Verified" | nonDMbug[4]=="Closed") , ]
#DMbug_close <- DMbug[ which( DMbug[4]=="Resolved" | DMbug[4]=="Verified" | DMbug[4]=="Closed") , ]
#write.csv(x = nonDMbug_close, file = "nonDMbug_close.csv")
#write.csv(x = DMbug_close, file = "DMbug_close.csv")

#New
#Assigned
#Accepted
#Committed
#Info Required
#New Request
#nonDMbug_open <- nonDMbug[ which( nonDMbug[4]=="New" | nonDMbug[4]=="Assigned" | nonDMbug[4]=="Accepted" | nonDMbug[4]=="Committed" | nonDMbug[4]=="Info Required" | nonDMbug[4]=="New Request") , ]
#DMbug_open <- DMbug[ which( DMbug[4]=="New" | DMbug[4]=="Assigned" | DMbug[4]=="Accepted" | DMbug[4]=="Committed" | DMbug[4]=="Info Required" | DMbug[4]=="New Request") , ]
#write.csv(x = nonDMbug_open, file = "nonDMbug_open.csv")
#write.csv(x = DMbug_open, file = "DMbug_open.csv")

#count <- rbind( dim(DMbug),dim(nonDMbug),dim(nonDMbug_withBlank),dim(DMbug_open),dim(nonDMbug_open),dim(DMbug_close),dim(nonDMbug_close) )
#rownames(count) <- c("DMbug","nonDMbug","nonDMbug_withBlank","DMbug_open","nonDMbug_open","DMbug_close","nonDMbug_close")
#colnames(count) <- c("bug (ea)","col (ea)")
#write.csv(x = count, file = "count.csv")

#DMbug_open <- sfbug1_DMbug[1] - DMbug_close[1]
#DMbug_open <- sfbug1_DMbug[sfbug1_DMbug[1] != DMbug_close[1],]
#dim(sfbug1_DMbug) - dim(DMbug_close)
#dim(sfbug1_nonDMbug) - dim(nonDMbug_close)

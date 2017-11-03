# Define server logic to read selected file ----
server <- function(input, output) {

  output$bug_count <- renderTable({

    req(input$file1)

    sfbug <- read.csv(input$file1$datapath, header = TRUE)
	
sfbug_col2 <- unique(sfbug[2]) #Product/Technology
sfbug_col4 <- unique(sfbug[4]) #Status
sfbug_col5 <- unique(sfbug[5]) #Component
sfbug_col11 <- unique(sfbug[11]) #DM Team Classification

sfbug[13] <- as.Date(sfbug[,13], format= "%d/%m/%Y")
#write.csv(x = sfbug, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sfbug.csv", sep = "") )

sfbug_orig <- sfbug[ which( sfbug[2]=="22FDX" | sfbug[2]=="22FDSOI" | sfbug[2]=="22SOI"), ]
bug_all <- sfbug[ which( sfbug[2]=="22FDX" | sfbug[2]=="22FDSOI" | sfbug[2]=="22SOI"), ]
bug_all <- bug_all[bug_all[5]=="Design Manual", ]
#to filter date region 11/10-1/31
bug_all <- bug_all[ bug_all[13] >= "2017-07-14", ]
bug_all <- bug_all[ bug_all[13] <= "2017-11-02", ]
#write.csv(x = sfbug_orig, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sfbug_orig.csv", sep = "") )
#write.csv(x = bug_all, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_bug_all.csv", sep = "") )

#Resolved
#Verified
#Closed
close_all <- bug_all[ which( bug_all[4]=="Resolved" | bug_all[4]=="Verified" | bug_all[4]=="Closed") , ]
open_all <- bug_all[ which( bug_all[4]!="Resolved" & bug_all[4]!="Verified" & bug_all[4]!="Closed") , ]
#write.csv(x = close_all, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_close_all.csv", sep = "") )
#write.csv(x = open_all, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_all.csv", sep = "") )
open_DM <- open_all[ which( open_all[11]=="Error (Others)" | open_all[11]=="Typo Implementation" | open_all[11]=="Typo Proposal" | open_all[11]=="Inadequate Proposal" | open_all[11]=="Need IAD"  | open_all[11]=="Neglected Related Content" | open_all[11]=="Scope changed"), ]
#write.csv(x = open_DM, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_DM.csv", sep = "") )

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
#write.csv(x = open_Enhance, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_Enhance.csv", sep = "") )
#write.csv(x = open_Work, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_Work.csv", sep = "") )
#write.csv(x = open_Ques, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_Ques.csv", sep = "") )
#write.csv(x = open_Invalid, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_Invalid.csv", sep = "") )
#write.csv(x = open_Blank, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_open_Blank.csv", sep = "") )

sum_count <- rbind( dim(open_DM),dim(open_Enhance),dim(open_Work),dim(open_Ques),dim(open_Invalid),dim(open_Blank),dim(close_all) )
rownames(sum_count) <- c("open_DM","open_Enhance","open_Work","open_Ques","open_Invalid","open_Blank","close_all")
colnames(sum_count) <- c("bug (ea)","na")

last_row <- matrix(c("open_DM","open_Enhance","open_Work","open_Ques","open_Invalid","open_Blank","close_all"), nrow = 1)
last_col <- t(last_row)

sum_count2 <- cbind(last_col, sum_count)
#write.csv(x = sum_count, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_sum_count.csv", sep = "") )
sum_count2 <- sum_count2[,-3]
sum_count2
  }
    )
}
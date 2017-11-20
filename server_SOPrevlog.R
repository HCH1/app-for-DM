# Define server logic to read selected file ----
library(reshape2)
library(zoo)
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
####################################################
output$DRC_grep <- renderTable({
req(input$file1)
diffdm <- read.csv(input$file1$datapath, header = TRUE)
#
diffdm1 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
diffdm2 <- diffdm1[ which( diffdm1[2]=="Added"|diffdm1[2]=="Removed"|diffdm1[2]=="Modified"), ]
diffdm2 <- diffdm2[order(diffdm2[1]), ]
write.csv(x = diffdm2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_diffdm2.csv", sep = "") )
#install.packages("gtools")
#library(gtools)
diffdm4_uni <- unique(diffdm2[1]) #length(t(diffdm4_uni)) 113
#big_data = data.frame()
#ans_o2 <- cbind( diffdm4_uni[1], ans_o1[1] )
#head(ans_o2)
ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 ) #create dummy 113 1
for ( i in length(diffdm4_uni):length(t(diffdm4_uni)) ){ #length(t(diffdm4_uni)) 113
#== right hand side, must be an element, so use paste 
a3 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[i,],collapse=" " ), ]
#aaa <- diffdm2[diffdm2[1]=="APMOM Design Rules", ] #40 3
#a4 <- paste(a3$Type, a3$Rule)
a4 <- cbind( a3[2], a3[3] )
a4t <- as.matrix( t(a4) )
a4t <- as.vector(a4t)
a4t <- a4t[!duplicated(a4t)]
#a4 <- unique(t(a4))
a5 <- paste( t(a4t),collapse=" " )
ans_o1[i] <- a5
}
#head(ans_o1)
ans_o2 <- cbind( diffdm4_uni, ans_o1 )
write.csv(x = ans_o2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist.csv", sep = "") )
ans_o2
})
}

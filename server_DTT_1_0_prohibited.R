# Define server logic to read selected file ----
library(reshape2)

server <- function(input, output) {
####################################################
output$DTT_1_0_prohibit <- renderTable({
req(input$file1)
i1 <- read.csv(input$file1$datapath, header = TRUE)
i2 <- i1
o1 <- melt(i2, id.vars = "Structure", warn = FALSE)
#
o1 <- o1[order(o1[3]), ]
o1 <- o1[order(o1[2]), ]
o1 <- o1[order(o1[1]), ]
write.csv(x = o1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT.csv", sep = "") )
#
o2 <- o1
o2_0 <- o2[ which( o2[3]=="0" ), ]
#write.csv(x = o2_0, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_0.csv", sep = "") )
#
o2_1 <- o2[ which( o2[3]=="1" ), ]
#write.csv(x = o2_1, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_1.csv", sep = "") )
#o2_x <- o2[ which( o2[3]=="x" ), ]
#write.csv(x = o2_x, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_melt_DTT_x.csv", sep = "") )
#
o2_col1_uni <- unique(o2_0[1])
#
o22 <- o2_0[-3]
#o22$x <- paste( "touching {", collapse = NULL )
#o22$y <- paste( "}", collapse = NULL )
#o22 <- cbind(o22[1], o22[4], o22[3], o22[2])
#
o22_1 <- o2_1[-3]
#
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
o222t_vec_1_col1 <- as.vector(t(o222_1_col1))
o222t_vec_uni_1_col1 <- o222t_vec_1_col1[!duplicated(o222t_vec_1_col1)]
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
write.csv(x = ans3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_0_prohibited.csv", sep = "") )
write.csv(x = ans3lite, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_0_prohibited_lite.csv", sep = "") )
#
ans3lite_order <- ans3lite[order(ans3lite[,2]), ]
write.csv(x = ans3lite_order, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_DTT_1_0_prohibited_lite_order.csv", sep = "") )
ans3lite_order
#head(o1, n = 20L)
})
####################################################
# Downloadable csv of selected dataset ----
#  output$downloadData <- downloadHandler(
#    filename = function() {
#      paste(input$file1, "to1D.csv", sep = "")
#    },
#    content = function(file) {
#      write.csv(o1, file, row.names = FALSE)
#    }
#  )


}
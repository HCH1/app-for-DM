##https://daattali.com/shiny/timevis-demo/
library(timevis)
i1 = read.csv("0102Rv1.csv", header = FALSE)
i2 <- i1
colnames(i2) <- c("id", "content", "start", "end")
timevis(i2)
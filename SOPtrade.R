#http://blog.fens.me/r-quant-start/
# 加载程序库
install.packages("quantmod")
install.packages("TTR")
install.packages("PerformanceAnalytics")
install.packages("ggplot2")
install.packages("scales")

library(quantmod)
library(TTR)
library(PerformanceAnalytics)
library(ggplot2)
library(scales)

# 从Yahoo财经下载各全球指数数据
options(stringsAsFactors = FALSE) 
symbols<-c("^GSPC","^N225","^HSI","^STI","000001.SS")
suppressWarnings(getSymbols(symbols,src = "yahoo",from="2012-01-01"))
[1] "GSPC"      "N225"      "HSI"       "STI"       "000001.SS"

# 取指数价格调整后的数据，合并数据集
df<-merge(GSPC$GSPC.Adjusted,HSI$HSI.Adjusted,N225$N225.Adjusted,STI$STI.Adjusted,`000001.SS`$`000001.SS.Adjusted`)

# 对列重命名
names(df)<-c("GSPC","HSI","N225","STI","SSE")

# 查看数据前6行
head(df)

# 查看数据最后6行
tail(df)

# 查看数据类型，为xts
class(df)


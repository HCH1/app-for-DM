#input csv
ip = read.csv("0530 demo1.csv", header = TRUE)
ip3 <- ip
ip4 <- table(ip3)
ip5 <- as.data.frame(ip4)
ip6 <- ip5[order(ip5[2], decreasing = TRUE), ]
str(ip6)
head(ip6)
write.csv(x = ip6, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_check dup v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end

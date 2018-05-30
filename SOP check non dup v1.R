#input csv
ip = read.csv("0530 demo1.csv", header = TRUE)
ip2 <- ip
#ip2 <- ip2[order(ip2[1]), ]
str(ip2)
ip4 <- table(ip2)
head(ip4)
str(ip4)
ip5 <- as.data.frame(ip4)
str(ip5)
ip6 <- ip5[order(ip5[2], decreasing = TRUE), ]
str(ip6)
head(ip6)
write.csv(x = ip6, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_check non dup v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
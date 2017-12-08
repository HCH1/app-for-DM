##will
lpo0 = read.csv("LPO-000242.csv", header = TRUE)
class(lpo0)
dim(lpo0)
lpo <- lpo0
lpo$gds1 <- paste( lpo[,17],lpo[,18], sep = ":", collapse = NULL )
lpo$oasis1 <- paste( lpo[,19],lpo[,20], sep = ":", collapse = NULL )
class(lpo)
dim(lpo)
#use column 2 17-20 7 9 4 6 11
lpo2 <- cbind(lpo[2],lpo$gds1,lpo$oasis1,lpo[7],lpo[9],lpo[4],lpo[6],lpo[11])
class(lpo2)
dim(lpo2)
#write.table(x = lpo2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_will.txt", sep = "") )
lpo2 <- lpo2[order(lpo2[1]), ]
write.table(x = lpo2, row.names = FALSE, file = "lpo_will.txt")
##was
llpo0 = read.csv("LPO-000235.csv", header = TRUE)
llpo <- llpo0
llpo$gds1 <- paste( llpo[,17],llpo[,18], sep = ":", collapse = NULL )
llpo$oasis1 <- paste( llpo[,19],llpo[,20], sep = ":", collapse = NULL )
llpo2 <- cbind(llpo[2],llpo$gds1,llpo$oasis1,llpo[7],llpo[9],llpo[4],llpo[6],llpo[11])
llpo2 <- llpo2[order(llpo2[1]), ]
write.table(x = llpo2, row.names = FALSE, file = "lpo_was.txt")
##
library(diffobj)
will_ = readLines("lpo_will.txt", warn = FALSE)
was_ = readLines("lpo_was.txt", warn = FALSE)
length(will_)
length(was_)
diffChr(was_, will_, color.mode="rgb")
####################################################end
####################################################end

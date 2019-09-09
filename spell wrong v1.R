library(hunspell)
##input:
i1 = read.csv("11 130BCD_Rev0.9_5.0_DRC01_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
##
i1_v1 <- i1
bad <- hunspell(i1_v1$Description)
#bad is group of list
#bad2 is chr
bad2 <- sort(unique(unlist(bad)))
bad22 <- as.character(bad2)
bad3 <- as.data.frame(bad22)
write.csv(x = bad3, row.names = TRUE, 
          file = paste(format(Sys.time(), "%Y%m%d_%H"),"_"
                       ,"_spell wrong v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
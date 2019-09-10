library(hunspell)
library(qdap)
##https://cran.r-project.org/web/packages/textclean/readme/README.html#stashing-character-pre-sub
library(textclean)
##input:
i1 = read.csv("11 130BCD_Rev0.9_5.0_DRC01_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
##
i1_v1 <- i1
#str(i1_v1)
#invert grep dataframe contain keywords
i1_v1b <- i1_v1[grep("â|Å|Γ|Ç|ª|ê|å|╧", i1_v1$Description, invert = TRUE),]
#str(i1_v1b)
#bad is group of list
bad <- hunspell(i1_v1b$Description)
#bad2 is chr
bad2 <- sort(unique(unlist(bad)))
bad22 <- as.character(bad2)
#bad3 is df
bad3 <- as.data.frame(bad22)
write.csv(x = bad3, row.names = TRUE, 
          file = paste(format(Sys.time(), "%Y%m%d_%H")
                       ,"_spell wrong v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end

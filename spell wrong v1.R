library(hunspell)
library(qdap)
##https://cran.r-project.org/web/packages/textclean/readme/README.html#stashing-character-pre-sub
library(textclean)
##input:
#i1 = read.csv("11 130BCD_Rev0.9_5.0_DRC01_internal.psv.csv", header = TRUE, stringsAsFactors=FALSE)
##https://cran.r-project.org/web/packages/hunspell/vignettes/intro.html
##hunspell
text <- readLines("11 130BCD_Rev0.9_5.0_DRC01_internal.psv.csv", warn = FALSE)
bad_words <- hunspell(text, format = "latex")
bad2 <- sort(unique(unlist(bad_words)))
#bad3 is df
bad3 <- as.data.frame(bad2)
write.csv(x = bad3, row.names = TRUE, 
          file = paste(format(Sys.time(), "%Y%m%d_%H")
                       ,"_spell wrong v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end

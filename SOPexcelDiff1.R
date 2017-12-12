##http://readxl.tidyverse.org/
##\\fab2crp-nas1\home19\HHUNG\Profile\Documents\R\win-library\3.4\readxl\extdata
library(cellranger)
library(readxl)
readxl_example() #to see if can work
#xlsx_example <- readxl_example("datasets.xlsx")
#put the xlsx into folder readxl\extdata
will_1 <- readxl_example("22nm BEOL PAs Fab1 v1.4_release.xlsx")
was_1 <- readxl_example("22nm BEOL PAs Fab1 v1.3_release.xlsx")
#excel_sheets(will_1)
##via metal res
##metal capa
will_t4 <- read_excel(will_1, sheet = "via metal res")
will_t5 <- read_excel(will_1, sheet = "metal capa")
was_t4 <- read_excel(was_1, sheet = "via metal res")
was_t5 <- read_excel(was_1, sheet = "metal capa")
#ex_t4 <- read_excel(will_1, sheet = 4)
#df4 <- as.data.frame(ex_t4)
##https://www.rdocumentation.org/packages/plyr/versions/1.8.4/topics/rbind.fill
library(plyr)
will_2 <- rbind.fill( as.data.frame(will_t4), as.data.frame(will_t5) )
was_2 <- rbind.fill( as.data.frame(was_t4), as.data.frame(was_t5) )
dim(will_t4)
dim(will_t5)
dim(will_2)
write.csv(x = will_2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_EDR_will.csv", sep = "") )
write.csv(x = was_2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_EDR_was.csv", sep = "") )
write.table(x = will_2, row.names = FALSE, quote = FALSE, sep = "\t", file = "EDR_will.txt")
write.table(x = was_2, row.names = FALSE, quote = FALSE, sep = "\t", file = "EDR_was.txt")
##
library(diffobj)
will_ = readLines("EDR_will.txt", warn = FALSE)
was_ = readLines("EDR_was.txt", warn = FALSE)
length(will_)
length(was_)
diffChr(was_, will_, color.mode="rgb")
####################################################end
####################################################end
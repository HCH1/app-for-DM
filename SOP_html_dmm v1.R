in1 = readLines("Pages from 22FDX_Rev1.3_3.0_PRE01-4.htm", warn = FALSE)
str(in1)
head(in1)
in2 <- in1
#remove fig due to waste loading time
in2 <- grep("<IMG", in2, value = TRUE, invert = TRUE)
#grep certain
#in2 <- grep("ELVTP", in2, value = TRUE, invert = FALSE)
was1 <- "ELVTP"
will1 <- " will"
ptn1 <- paste( '<del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b>", sep="" )
#search then replace, both lower/uppercase
in2 <- gsub(was1, ptn1, in2, ignore.case = TRUE)
##
##was1 <- "elvtp"
##will1 <- "will"
##ptn1 <- paste( '<del><b><font color="red">', was1, "</font></b></del>",
##'<b><font color="blue">', will1, "</font></b>", sep="" )
##in2 <- gsub(was1, ptn1, in2)
#save to htm
fileConn <- file("o1.htm")
writeLines(in2, fileConn)
close(fileConn)
####################################################end
####################################################end

#read htm
in1 = readLines("Pages from 22FDX_Rev1.3_3.0_PRE01-4.htm", warn = FALSE)
str(in1)
head(in1)
in2 <- in1
#remove fig due to waste loading time
in2 <- grep("<IMG", in2, value = TRUE, invert = TRUE)
##for special case
was1 <- "Union(EG, ZG)"
will1 <- "EG"
ptn1 <- paste( '<mark><del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b></mark>", sep="" )
in2 <- gsub("Union[(]EG[,][ ]ZG[)]", ptn1, in2, ignore.case = FALSE)
##for special case
was1 <- "ZG33V"
will1 <- ""
ptn1 <- paste( '<mark><del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b></mark>", sep="" )
in2 <- gsub("ZG[3][3]V", ptn1, in2, ignore.case = FALSE)
##for special case
was1 <- "ZG18V"
will1 <- ""
ptn1 <- paste( '<mark><del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b></mark>", sep="" )
in2 <- gsub("ZG[1][8]V", ptn1, in2, ignore.case = FALSE)
#if u have many was pattern, use loop
#input 1 column pattern txt
was0 = readLines("DMM want replace type.txt", warn = FALSE)
#was0_len <- nchar(was0)
#str(was0_len)
#was0_mx2 <- cbind(was0,was0_len)
#str(was0_mx2)
for ( i in 1:length(was0) ){
#grep certain
#in2 <- grep("ELVTP", in2, value = TRUE, invert = FALSE)
was1 <- was0[i]
#will1 <- " (removed)"
will1 <- ""
ptn1 <- paste( '<mark><del><b><font color="red">', was1, "</font></b></del>",
'<b><font color="blue">', will1, "</font></b></mark>", sep="" )
#search then replace, both lower/uppercase
#in2 <- gsub(was1, ptn1, in2, ignore.case = TRUE)
in2 <- gsub(was1, ptn1, in2, ignore.case = FALSE)
}
##
#save to htm
fileConn <- file("DMM-011631 22FDX remove ZG related v1.htm")
writeLines(in2, fileConn)
close(fileConn)
####################################################end
####################################################end
####################################################end
in3 <- in2
div1 <- grep("<DIV", in3)
head(div1)
del1 <- grep("<del", in3)
head(del1)

#read htm
in1 = readLines("Pages from 22FDX_Rev1.3_3.0_PRE01-4.htm", warn = FALSE)
str(in1)
head(in1)
in2 <- in1
#remove fig due to waste loading time
in2 <- grep("<IMG", in2, value = TRUE, invert = TRUE)
#if u have many was pattern, use loop
was0 <- c("ZGXSLVT",	"zgxslvt",
"ZGVSLVT",	"zgvslvt",
"ZGTDPDNW",	"zgtdpdnw",
"ZGTDNDSX",	"zgtdndsx",
"ZGSLVTP",	"zgslvtp",
"ZGSLVTN",	"zgslvtn",
"ZGSLVT",	"zgslvt",
"ZGRVTP",	"zgrvtp",
"ZGRVTN",	"zgrvtn",
"ZGPBICNT",	"zgpbicnt",
"ZGPBCNT",	"zgpbcnt",
"ZGNCAP",	"zgncap",
"ZGNBCNT",	"zgnbcnt",
"ZGDIODEPNW",	"zgdiodepnw",
"ZGDIODENX",	"zgdiodenx",
"ESDZGX",	"esdzgx",
"ESDZGVNPN",	"esdzgvnpn",
"ESDZGV",	"esdzgv",
"ESDZGPDNW",	"esdzgpdnw",
"ESDZGNDSX",	"esdzgndsx",
"ESDZG",	"esdzg",
"ZGV",	"zgv",
"ZGX",	"zgx",
"ZG"	"zg"
)
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

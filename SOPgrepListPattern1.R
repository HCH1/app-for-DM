#drc = readLines("merge22fdx1004.txt", warn = FALSE)
#drc1 <- drc
dm = readLines("22FDX_Rev1.4_0.0_PRE01 - Copy.txt", warn = FALSE)
dm1 <- dm
length(dm)
dm1 <- grep("Figure", dm1, value = TRUE)
length(dm1)
#
gr = read.csv("22FDX_Rev1.4_0.0_PRE01_internal.csv", header = TRUE)
gr_col1 <- gr[1]
class(gr_col1)
dim(gr_col1)
#
gr_colv1 <- gr_col1[grep("[.]|[_]|ERC", gr_col1$Name), ]
class(gr_colv1)
length(gr_colv1)
#
gr_col2_vcr <- as.vector( t( gr_colv1 ) ) #"A" "B" "C"
class(gr_col2_vcr)
length(gr_col2_vcr)
#
gr_col2_vcr1 <- gr_col2_vcr[1:2000]
gr_col2_vcr2 <- gr_col2_vcr[2001:4000]
gr_col2_vcr3 <- gr_col2_vcr[4001:length(gr_col2_vcr)]
#
ptn11 <- paste(gr_col2_vcr1, collapse="|") #"A|B|C"
ptn22 <- paste(gr_col2_vcr2, collapse="|") #"A|B|C"
ptn33 <- paste(gr_col2_vcr3, collapse="|") #"A|B|C"
class(ptn11)
#
dm11 <- grep(ptn11, dm1, value = TRUE, invert = TRUE) # patterns max 2K ea
dm22 <- grep(ptn22, dm1, value = TRUE, invert = TRUE) # patterns max 2K ea
dm33 <- grep(ptn33, dm1, value = TRUE, invert = TRUE) # patterns max 2K ea
class(dm11)
#
#dm4 <- c(dm11,dm22,dm33)
#class(dm4)
#length(dm4)
#
#dm5 <- unique(dm4)
#class(dm5)
#length(dm5)
#
dm6 <- intersect( intersect(dm11,dm22), dm33 )
class(dm6)
length(dm6)
write.table(x = dm6, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_dm6.txt", sep = "") )
#
dm66 <- grep("[.]", dm6, value = TRUE) # patterns max 2K ea
class(dm66)
length(dm66)
write.table(x = dm66, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_dm66.txt", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
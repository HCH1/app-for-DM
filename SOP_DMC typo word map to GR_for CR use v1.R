library(dplyr)
##input:
i1 = read.csv("1 DM-000282 typo v1.csv", header = TRUE, stringsAsFactors=FALSE)
i2 = read.csv("130BCD_Rev0.9_5.0_PRE01_internal.psv - Copy.csv", header = TRUE, stringsAsFactors=FALSE)
###
###SOP to check two files diff: add new key col > xxx_join() > logic check > replace NA > save as
i1_v1 <- i1
i2_v1 <- i2
i1_v1 <- data.frame( table(i1_v1) ) #can do freq sum
colnames(i1_v1)[1] <- "Description"
#str(i1_v1)
#str(i2_v1)
i1_v2 <- i1_v1
#str(i1_v2)
i1_v2_col1 <- as.vector(t(i1_v2[,1]))
#str(i1_v2_col1)
#i1_v2 <- i1_v1[1:dim(i1_v1)[1]]
ptn11 <- paste(i1_v2_col1, collapse=" |") #"A|B|C"
ptn11 <- paste(ptn11," ", collapse="") #"A|B|C"
ptn11 <- gsub("  ", " ", ptn11)
ptn11
ptn22 <- paste(i1_v2_col1, collapse=",|") #"A|B|C"
ptn22 <- paste(ptn22,",", collapse="") #"A|B|C"
ptn22 <- gsub(" ,", ",", ptn22)
ptn22
ptn33 <- paste(i1_v2_col1, collapse=".|") #"A|B|C"
ptn33 <- paste(ptn33,".", collapse="") #"A|B|C"
ptn33 <- gsub(" .", ".", ptn33)
ptn33
ptn44 <- paste(ptn11,ptn22,ptn33, collapse="|") #"A|B|C"
#str(ptn11)
#grep dataframe contain keywords
ans1 <- i2_v1[grep(ptn44, i2_v1$Description),]
ans1[ is.na( ans1 ) ] <- ""
str(ans1)
dim(ans1)
dim(i2_v1)
write.csv(x = ans1, row.names = TRUE
, file = paste(format(Sys.time(), "%Y%m%d_%H"), 
"_SOP_DMC typo word map to GR_for CR use v1.csv", sep = "") )
####################################################end
####################################################end
####################################################end
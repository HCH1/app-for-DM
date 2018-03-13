import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#https://stackoverflow.com/questions/10393176/is-there-a-way-to-read-a-txt-file-and-store-each-line-to-memory
filename = '//fab2crp-nas1/home19/HHUNG/Profile/Documents/2018py/merge22fdx1004.txt'
##Using the newer with construct to close the file automatically.
##with open(filename) as f:
##    drc1 = f.readlines()
# Or using the older approach and closing the filea explicitly.
# Here the data is re-read again, do not use both ;)
f = open(filename)
drc1 = f.readlines() #to list
f.close()
#https://stackoverflow.com/questions/12845288/grep-on-elements-of-a-list
#drc2 = re.findall(r"\w+rohibit", text) #grep str
drc2 = list( filter(lambda x: re.search(r'\w+rohibit', x), drc1) ) #grep list
##save list to txt
import time
TodaysDate = time.strftime("%Y%m%d_%H")
filename2 = TodaysDate + "_grepDRC2_py.csv"
##list to df
##drc3 = pd.DataFrame(drc2)
##drc3.to_csv( filename2, sep=',', encoding='utf-8', index=False )
#http://cmdlinetips.com/2012/09/three-ways-to-write-text-to-a-file-in-python/
outF = open("myOutFile.txt", "w")
outF.writelines(drc2)
outF.close()
##or in loop
##for line in drc2:
##  # write line to output file
##  outF.write(line)
  ###outF.write("\n")
##outF.close()
####################################################end
####################################################end
####################################################end






text = "He rohibit carefully disguised but captured prohibit by police."
drc2 = re.findall(r"\w+rohibit", text)





text = open('//fab2crp-nas1/home19/HHUNG/Profile/Documents/2018py/merge22fdx1004.txt')
f = text.splitlines()
for i in f:
drc2 = re.findall( r'proh', i.strip() )





import re
with open(filename).readlines() as origin_file:
    for line in origin_file:
        line = re.findall(r'prohibit', line)
        if line:
           line = line[0].split('"')[1]
        drc2 = line
		
		
		

for line in drc1:
 if "prohibit" in line:
   drc2 = line



#drc = readLines("merge22fdx1004.txt", warn = FALSE)
#drc1 <- drc
drc1 <- grep("prohibit", drc1, value = TRUE)
write.table(x = drc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_drc1.txt", sep = "") )
#touching|over|straddling|incurring|created|space
#replace to "\t" for future split
ddrc1v1 <- gsub("touching|over|straddling|incurring|created|space", "\t", drc1)
write.table(x = ddrc1v1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc1v1.txt", sep = "") )
#replace lower a-z, lead \\s, end \\s 
ddrc3 <- gsub("\\s[a-z]+|^[ ]+|[@]\\s|[ ]+$|[.]$", "", ddrc1v1)
ddrc3 <- gsub("\\s\t\\s", "\t", ddrc3)
write.table(x = ddrc3, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc3.txt", sep = "") )
#ddrc3 is character -> but we want dataframe
ddrc4 <- as.data.frame(ddrc3)
ddrc5 <- ddrc4[order(ddrc4[,1]), ]
#ddrc5_uni will be factor if do unique
ddrc5_uni <- unique(ddrc5)
write.table(x = ddrc5_uni, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni.txt", sep = "") )
#
ddrc5_uni1 <- as.character(ddrc5_uni)
ddrc5_uni2 <- grep("[(]|[)]|[>]", ddrc5_uni1, value = TRUE, invert = TRUE)
#split by \tab
ddrc5_uni3 <- strsplit(ddrc5_uni2, '\t')
ddrc5_uni4 <- as.data.frame(ddrc5_uni3)
ddrc5_uni4t <- t(ddrc5_uni4)
#ddrc5_uni4t <- ddrc5_uni4t[-(3:4)]
write.csv(x = ddrc5_uni4t, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_ddrc5_uni4t.csv", sep = "") )
###grep the 1st string
#dddrc1 <- grep("^LAYER", drc, value = TRUE)
#write.table(x = dddrc1, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_dddrc1.txt", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
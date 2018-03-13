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

#http://cmdlinetips.com/2012/09/three-ways-to-write-text-to-a-file-in-python/
#save list to txt
outF = open("myOutFile.txt", "w") #creat txt
outF.writelines(drc2) #save txt
outF.close()
##or in loop
##for line in drc2:
##  # write line to output file
##  outF.write(line)
  ###outF.write("\n")
##outF.close()

##import time
##TodaysDate = time.strftime("%Y%m%d_%H")
##filename2 = TodaysDate + "_grepDRC2_py.csv"
##list to df
##drc3 = pd.DataFrame(drc2)
##drc3.to_csv( filename2, sep=',', encoding='utf-8', index=False )
####################################################end
####################################################end
####################################################end

import pandas as pd
import numpy as np
import re
import matplotlib.pyplot as plt
#https://stackoverflow.com/questions/10393176/is-there-a-way-to-read-a-txt-file-and-store-each-line-to-memory
i1 = '//fab2crp-nas1/home19/HHUNG/Profile/Documents/2018py/merge22fdx1004.txt'
##Using the newer with construct to close the file automatically.
##with open(i1) as f:
##    drc1 = f.readlines()
# Or using the older approach and closing the filea explicitly.
# Here the data is re-read again, do not use both ;)
f = open(i1)
drc1 = f.readlines() #to list
f.close()
#https://stackoverflow.com/questions/12845288/grep-on-elements-of-a-list
#drc2 = re.findall(r"\w+rohibit", text) #grep str
drc2 = list( filter(lambda x: re.search(r'\w+rohibit', x), drc1) ) #grep list

#http://cmdlinetips.com/2012/09/three-ways-to-write-text-to-a-file-in-python/
#save list to txt
o1 = open("myOutFile.txt", "w") #creat txt
o1.writelines(drc2) #save txt
o1.close()
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
###loop replace list
drc3 = drc2
for i in range(0, 7):
	kw1 = ['touching','over','straddling','incurring','created','space','prohibited'] #replace list
	drc3 = [ w.replace(kw1[i], '\t') for w in drc3 ] #loop
	print(kw1[i]) #check
o2 = open("drc3.txt", "w") #creat txt
o2.writelines( list(drc3) ) #save list txt
o2.close()
###sub for regexp; replace for words
drc4 = drc3
for i in range(0, 3):
	kw2 = [r'^\s+',r'\s+$',r'\s[a-z]+',r'[ ]'] #replace list; lead \s; end \s
	drc4 = [ re.sub(kw2[i], "", w) for w in drc4 ] #replace
	drc4 = [ re.sub(r'[@]', "\n", w) for w in drc4 ] #insert line
	print(kw2[i]) #check
o3 = open("drc4.txt", "w") #creat txt
o3.writelines( list(drc4) ) #save list txt
o3.close()
####################################################end
####################################################end
####################################################end

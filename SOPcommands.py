#https://pandas.pydata.org/pandas-docs/stable/10min.html#csv
import pandas as pd
import numpy as np
import re
import matplotlib.pyplot as plt
####################################################end
df1 = pd.read_csv('//fab2crp-nas1/home19/hhung/Profile/Documents/2018py/28LPQRF-QCA_Rev1.1_0.0_DRC03D2vs28LPQRF-QCA_Rev1.1_0.0_DRC02DRCTrack2.csv')
#cbind 3 cols
df2 = pd.concat( [ df1.iloc[:,2],df1.iloc[:,6],df1.iloc[:,0] ] , axis=1 ) #axis=1 along col
#filter Type 
df3 = df2[ df2.iloc[:,1].isin( ['Added','Removed','Modified'] ) ]
#order Section
df4 = df3.sort_index( by=['Section'] )
df4.dtypes
#unique col 1
df5 = pd.unique( df4.iloc[:,0] )
#create dummy mx 113*1
dmx1 = pd.DataFrame( np.random.randint(1, size=(len(df4), 1)), columns=['a'] )
#groupby, pivot
df4v1 = df4
df4v2 = df4v1.groupby( ['Section','Type'],as_index=False ).agg( lambda x : x.sum() if x.dtype=='float64' else ' '.join(x))
#file name has date
import time
TodaysDate = time.strftime("%Y%m%d_%H")
filename = TodaysDate + "_rev_hist_py.csv"
df4v2.to_csv( filename, sep=',', encoding='utf-8', index=False )
####################################################end
#loop draft
for i in range( 0,len(df4) ):
#a3 = df4[ df4.iloc[:,0].isin( [ df5[0] ] ) ]
a3 = df4[ df4.iloc[:,0].isin( [ df5[i] ] ) ]

   print()
####################################################end
df.info()
len(df)
df.shape()
df.dtypes
df.head()
df.index
df.describe()
df_t = df.T
df.sort_values(by='B')
df['A']
df[0:3] #row1-3
df.loc[dates[0]]
df.loc[:,['A','B']]
df.iloc[3:5,0:2] #row 4-5, col 1-2
df.iloc[[1,2,4],[0,2]]
df.iloc[1:3,:] #row 2-3, col all
df.iloc[:,1] #row all, col 2
df.iloc[1,1] #cell 2,2
df[df.A > 0]
df[df > 0]
df.iat[0,1] = 0
df.loc[:,'D'] = np.array([5] * len(df))
pd.concat([ df.loc[:,['C']], df.loc[:,['B']] ], axis=1)
df2[df2['E'].isin(['two','four'])] #filter
sorted("This is a test string from Andrew".split(), key=str.lower
####################################################end
import re
re.match("c", "abcdef")    # No match
re.search("^c", "abcdef")  # No match
re.search("^a", "abcdef")  # Match <_sre.SRE_Match object; span=(0, 1), match='a'>

mystring = "This Is A String"
print( mystring.replace( "String", "Text" ) ) #This Is A Text

s = "The dog is large small"
ss = s.replace( s.split()[3], s.split()[3]+'ly' ) #.replace() .split()
ss #The dog is largely small

#https://www.tutorialspoint.com/python3/string_split.htm
str = "this is string example....wow!!!"
print (str.split( ))
print (str.split('i',1))
print (str.split('w'))
#['this', 'is', 'string', 'example....wow!!!']
#['th', 's is string example....wow!!!']
#['this is string example....', 'o', '!!!']

str = "this is string example....wow!!! this is really string"
print (str.replace("is", "was"))
print (str.replace("is", "was", 3))
#thwas was string example....wow!!! thwas was really string
#thwas was string example....wow!!! thwas is really string
####################################################end
i1 = '//fab2crp-nas1/home19/HHUNG/Profile/Documents/2018py/merge22fdx1004.txt'
f = open(i1)
drc1 = f.readlines() #to list
f.close()
drc2 = list( filter(lambda x: re.search(r'\w+rohibit', x), drc1) ) #grep list
o1 = open("myOutFile.txt", "w") #creat txt
o1.writelines(drc2) #save txt
o1.close()
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

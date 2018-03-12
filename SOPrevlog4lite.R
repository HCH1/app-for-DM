#https://pandas.pydata.org/pandas-docs/stable/10min.html#csv
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
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
#paste text
dmx2 = df4v2.loc[:,'Section']
dmx3 = df4v2.Type + " " + df4v2.Rule #paste text
df_dmx3 = pd.Series.to_frame(dmx3) # text to df
ans1 = pd.concat( [ df4v2.iloc[:,0], df_dmx3.iloc[:,0] ] , axis=1 ) #axis=1 along col
#file name has date
import time
TodaysDate = time.strftime("%Y%m%d_%H")
filename = TodaysDate + "_rev_hist_py.csv"
ans1.to_csv( filename, sep=',', encoding='utf-8', index=False )
####################################################end
####################################################end
####################################################end
#loop draft
for i in range( 0,len(df4) ):
#a3 = df4[ df4.iloc[:,0].isin( [ df5[0] ] ) ]
a3 = df4[ df4.iloc[:,0].isin( [ df5[i] ] ) ]

   print()
####################################################end
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
####################################################end

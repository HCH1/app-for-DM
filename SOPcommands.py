#https://pandas.pydata.org/pandas-docs/stable/10min.html#csv
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
df1 = pd.read_csv('//fab2crp-nas1/home19/hhung/Profile/Documents/2018py/28LPQRF-QCA_Rev1.1_0.0_DRC03D2vs28LPQRF-QCA_Rev1.1_0.0_DRC02DRCTrack2.csv')
#extract 3 columns
#diffdm1 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
df2 = pd.concat( [ df1.iloc[:,2],df1.iloc[:,6],df1.iloc[:,0] ] , axis=1 )
#filter Type 
#diffdm2 <- diffdm1[ which( diffdm1[2]=="Added"|diffdm1[2]=="Removed"|diffdm1[2]=="Modified"), ]
df3 = df2[ df2.iloc[:,1].isin( ['Added','Removed','Modified'] ) ]
#order Section
#diffdm2 <- diffdm2[order(diffdm2[1]), ]
df4 = df3.sort_index( by=['Section'] )
#length(t(diffdm4_uni)) == 113
#diffdm4_uni <- unique(diffdm2[1])
df5 = pd.unique( df4.iloc[:,0] )


#create dummy 113*1
ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 )








#pd.DataFrame()
#e.g.
dates = pd.date_range('20130101', periods=6)
dates
DatetimeIndex(['2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04',
               '2013-01-05', '2013-01-06'],
              dtype='datetime64[ns]', freq='D')
df = pd.DataFrame(np.random.randn(6,4), index=dates, columns=list('ABCD'))
df
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
sorted("This is a test string from Andrew".split(), key=str.lower)





df = pd.DataFrame(np.random.randn(8, 4), columns=['A','B','C','D'])
df
s = df.iloc[3]
df.append(s, ignore_index=True)

df = pd.DataFrame({'A' : ['foo', 'bar', 'foo', 'bar',
                           'foo', 'bar', 'foo', 'foo'],
                    'B' : ['one', 'one', 'two', 'three',
                           'two', 'two', 'one', 'three'],
                    'C' : np.random.randn(8),
                    'D' : np.random.randn(8)})
df.groupby('A').sum()
df.groupby(['A','B']).sum()

















raw_data = open('28LPQRF-QCA_Rev1.1_0.0_DRC03D2vs28LPQRF-QCA_Rev1.1_0.0_DRC02DRCTrack2.csv', newline='')
df = pd.DataFrame(raw_data)
df




diffdm = read.csv("28LPQRF-QCA_Rev1.1_0.0_DRC03D2vs28LPQRF-QCA_Rev1.1_0.0_DRC02DRCTrack2.csv", header = TRUE)
#extract 3 columns
diffdm1 <- cbind( diffdm[3], diffdm[7], diffdm[1] )
#filter Type 
diffdm2 <- diffdm1[ which( diffdm1[2]=="Added"|diffdm1[2]=="Removed"|diffdm1[2]=="Modified"), ]
#order Section
diffdm2 <- diffdm2[order(diffdm2[1]), ]
#length(t(diffdm4_uni)) == 113
diffdm4_uni <- unique(diffdm2[1]) 
#create dummy 113*1
ans_o1 <- matrix( NA, nrow=length(t(diffdm4_uni)), ncol=1 ) 

#write a loop, run 113ea
for ( i in 1:length(t(diffdm4_uni)) ){
#filter the i-th Scetion, e.g. i=1 to 113 
a3 <- diffdm2[diffdm2[1]==paste( diffdm4_uni[i,],collapse=" " ), ]
#e.g. 1st Section, then extract columns of "Type & Rule"
#due to we want to merge them
a4 <- cbind( a3[2], a3[3] ) #n*2 matrix
a4t <- as.matrix( t(a4) ) #2*n matrix
a4tv <- as.vector(a4t) #convert to line
#due to repeat "Added or Removed or Modified", so need to do de-duplicated this vector
a4t_v_d <- a4tv[!duplicated(a4tv)]
#lines -> character (~ 1*1)
a5 <- paste( t(a4t_v_d),collapse=" " )
#save to i-th row
ans_o1[i] <- a5
}
#create opuput format
ans_o2 <- cbind( diffdm4_uni, ans_o1 )
write.csv(x = ans_o2, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_rev_hist.csv", sep = "") )
####################################################end
####################################################end

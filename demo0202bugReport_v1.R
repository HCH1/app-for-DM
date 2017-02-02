sfbug = read.csv("20170202SFbugsv2.csv", header = TRUE)
sfbug_col2 <- unique(sfbug[2]) 
sfbug_col4 <- unique(sfbug[4]) 
sfbug_col5 <- unique(sfbug[5]) 
sfbug_col11 <- unique(sfbug[11])
sfbug1 <- sfbug[ which( sfbug[2]=="22FDX" | sfbug[2]=="22FDSOI") , ]
sfbug1_noDMbug <- sfbug1[ which( sfbug1[11]=="Enhancement request" | sfbug1[11]=="Work request" | sfbug1[11]=="Invalid Bug" | sfbug1[11]=="Question (No Update Required)") , ]
sfbug1_DMbug <- sfbug1[ which( sfbug1[11]=="Error (Others)" | sfbug1[11]=="Typo Implementation" | sfbug1[11]=="Typo Proposal" | sfbug1[11]=="Inadequate Proposal" | sfbug1[11]=="Need IAD"  | sfbug1[11]=="Neglected Related Content" | sfbug1[11]=="Scope changed") , ]
sfbug1_blank <- sfbug1[ sfbug1[11]=="" , ]

DMbug_close <- sfbug1_DMbug[ which( sfbug1_DMbug[4]=="Resolved" | sfbug1_DMbug[4]=="Verified" | sfbug1_DMbug[4]=="Closed") , ]
noDMbug_close <- sfbug1_noDMbug[ which( sfbug1_noDMbug[4]=="Resolved" | sfbug1_noDMbug[4]=="Verified" | sfbug1_noDMbug[4]=="Closed") , ]

#DMbug_open <- sfbug1_DMbug[1] - DMbug_close[1]
#DMbug_open <- sfbug1_DMbug[sfbug1_DMbug[1] != DMbug_close[1],]

dim(sfbug1_DMbug) - dim(DMbug_close)
dim(sfbug1_noDMbug) - dim(noDMbug_close)

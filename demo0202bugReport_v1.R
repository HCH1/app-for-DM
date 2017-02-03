sfbug = read.csv("20170203SFbugs.csv", header = TRUE)
sfbug_col2 <- unique(sfbug[2]) #Product/Technology
sfbug_col4 <- unique(sfbug[4]) #Status
sfbug_col5 <- unique(sfbug[5]) #Component
sfbug_col11 <- unique(sfbug[11]) #DM Team Classification

#Design Manual	
#22FDX 22FDSOI
sfbug1 <- sfbug[ which( sfbug[2]=="22FDX" | sfbug[2]=="22FDSOI" & sfbug[5]=="Design Manual") , ]
#write.csv(x = sfbug1, file = "sfbug1.csv")

nonDMbug <- sfbug1[ which( sfbug1[11]=="Enhancement request" | sfbug1[11]=="Work request" | sfbug1[11]=="Invalid Bug" | sfbug1[11]=="Question (No Update Required)") , ]
DMbug <- sfbug1[ which( sfbug1[11]=="Error (Others)" | sfbug1[11]=="Typo Implementation" | sfbug1[11]=="Typo Proposal" | sfbug1[11]=="Inadequate Proposal" | sfbug1[11]=="Need IAD"  | sfbug1[11]=="Neglected Related Content" | sfbug1[11]=="Scope changed") , ]
write.csv(x = nonDMbug, file = "nonDMbug.csv")
write.csv(x = DMbug, file = "DMbug.csv")
#blank <- sfbug1[ sfbug1[11]=="" , ]

#Resolved Verified Closed
nonDMbug_close <- nonDMbug[ which( nonDMbug[4]=="Resolved" | nonDMbug[4]=="Verified" | nonDMbug[4]=="Closed") , ]
DMbug_close <- DMbug[ which( DMbug[4]=="Resolved" | DMbug[4]=="Verified" | DMbug[4]=="Closed") , ]
write.csv(x = nonDMbug_close, file = "nonDMbug_close.csv")
write.csv(x = DMbug_close, file = "DMbug_close.csv")

#New Assigned Accepted Committed Info Required New Request
nonDMbug_open <- nonDMbug[ which( nonDMbug[4]=="New" | nonDMbug[4]=="Assigned" | nonDMbug[4]=="Accepted" | nonDMbug[4]=="Committed" | nonDMbug[4]=="Info Required" | nonDMbug[4]=="New Request") , ]
DMbug_open <- DMbug[ which( DMbug[4]=="New" | DMbug[4]=="Assigned" | DMbug[4]=="Accepted" | DMbug[4]=="Committed" | DMbug[4]=="Info Required" | DMbug[4]=="New Request") , ]
write.csv(x = nonDMbug_open, file = "nonDMbug_open.csv")
write.csv(x = DMbug_open, file = "DMbug_open.csv")

count <- rbind( dim(DMbug_open) , dim(nonDMbug_open) , dim(nonDMbug_close), dim(nonDMbug_close) )
write.csv(x = count, file = "count.csv")

#DMbug_open <- sfbug1_DMbug[1] - DMbug_close[1]
#DMbug_open <- sfbug1_DMbug[sfbug1_DMbug[1] != DMbug_close[1],]
#dim(sfbug1_DMbug) - dim(DMbug_close)
#dim(sfbug1_nonDMbug) - dim(nonDMbug_close)

###cont. SOPmeltPivot3.R
#insdie dataframe is factor -> character -> list -> character
split12 <- unlist( strsplit( as.character(ans3lite_order[1,2]), '\\s' ) )
split22 <- unlist( strsplit( as.character(ans3lite_order[2,2]), '\\s' ) )
split32 <- unlist( strsplit( as.character(ans3lite_order[3,2]), '\\s' ) )
split42 <- unlist( strsplit( as.character(ans3lite_order[4,2]), '\\s' ) )

split13 <- unlist( strsplit( as.character(ans3lite_order[1,3]), '\\s' ) )
split23 <- unlist( strsplit( as.character(ans3lite_order[2,3]), '\\s' ) )

#intersect( split12,split22 )
#intersect multi character
Reduce(intersect, list(split12,split22,split32,split42))

dim(ans3lite_order)
dim(ans3lite_order[3])

dim(ans3lite_order)[1]



x=c()
x[1] = 3
for (i in 1:dim(ans3lite_order)[1]) { 
    x[i]=2*x[i-1]
}





v1 <- c("PRI2CO","HEISCO","PRI2CO","DIALGU","DIALGU","ALSEBL")
v2 <- c("PRI2CO", "TET2PA","ALSEBL","PRI2CO","ALSEBL","TET2PA","HEISCO","TET2PA")
v3 <- c("PRI2CO","HEISCO","PRI2CO","DIALGU","DIALGU","ALSEBL")
v4 <- c("PRI2CO", "TET2PA","ALSEBL","PRI2CO","ALSEBL","TET2PA","HEISCO","TET2PA")

veclist <- list(v1,v2,v3,v4)
combos <- Reduce(c,lapply(2:length(veclist), 
            function(x) combn(1:length(veclist),x,simplify=FALSE) ))

lapply(combos, function(x) Reduce(intersect,veclist[x]) )

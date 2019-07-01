###dmc report then grep only lowercase
dmc = read.csv("DMC_Result_130BCDLite_DM000064 Failing Term v1.csv", header = TRUE)
dmc1 <- dmc
str(dmc1)
#https://stackoverflow.com/questions/39775133/r-grep-remove-upper-case-rows
dmc1 <- grep("^[a-z 0-9]+$|^[A-Z]{1}[a-z 0-9]+$", dmc1$Failing.Term, value = TRUE, invert = FALSE) # patterns max 2K ea
str(dmc1)
write.csv(x = dmc1, row.names = FALSE, 
file = paste(format(Sys.time(), "%Y%m%d_%H")
,"_dmc Failing Term_only lowercase.csv", sep = "") )
####################################################end
####################################################end
####################################################end

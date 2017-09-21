#install.packages("zoo")
#library(zoo)
#lpo = read.table("LPO-000202.csv")
lpo = readLines("LPO-000202.csv", warn = FALSE)
#lpo2 <- grep("[!]|[#]|[$]|[%]|[&]|[+]|[=]|[?]|[@]|[^]|[`]|[|]|[~]", lpo, value = TRUE)
lpo2 <- grep("[!]|[#]|[$]|[%]|[&]|[+]|[=]", lpo, value = TRUE)
write.csv(x = lpo2, row.names = FALSE, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_lpo_have_ascii.csv", sep = "") )
####################################################end
####################################################end
####################################################end
####################################################end
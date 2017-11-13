#https://www.r-bloggers.com/introducing-pdftools-a-fast-and-portable-pdf-extractor/
#install.packages("pdftools")
library(pdftools)
# renders pdf to bitmap array
fig1 <- pdf_render_page("1113f1.pdf", page = 1)
fig2 <- pdf_render_page("1113f2.pdf", page = 1)
# save bitmap image
png::writePNG(fig1, "1113f1.png")
png::writePNG(fig2, "1113f2.png")
#https://dahtah.github.io/imager/imager.html
library(png)
f1 <- readPNG("1113f1.png")
f2 <- readPNG("1113f2.png")
#f1 <- readPNG(system.file("img", "1113f1.png", package="png"))
#f2 <- readPNG(system.file("img", "1113f2.png", package="png"))
class(f1) #array
dim(f1)
f11 <- f1[,,1]
f22 <- f2[,,1]
dim(f11)
f1df <- as.data.frame(t(f11))
f2df <- as.data.frame(t(f22))
class(f1df) #data.frame"
dim(f1df)
dim(f2df)
#write.csv(x = f1df, file = paste(format(Sys.time(), "%Y%m%d_%H"), "_f1df.csv", sep = "") )
del_df1_2 <- f1df-f2df
dim(del_df1_2)
#http://rpubs.com/daattali/heatmapsGgplotVsLattice
hDat <- as.matrix(del_df1_2)
grays = rgb(red = 0:255/255, blue = 0:255/255, green = 0:255/255)
heatmap(hDat, Rowv = NA, Colv = NA, col=grays, scale = "none")

png::writePNG(hDat, "imgDiff2.png")
####################################################end
####################################################end
####################################################end
####################################################end
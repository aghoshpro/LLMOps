library(raster)
library(rgdal)
library(rgeos)
library(maptools)
library(gdalUtils)
library(rasterVis)
library(gplots)
library(maptools)
library(rgdal)
library(RColorBrewer)
library(Cairo)
library(colorRamps)

setwd("C://Users//ARKA GHOSH//Desktop//PHD//Stockholm University//Interview//MODIS_crop//") # same folder as the ZIP-File

Filenames = list.files(pattern = ".tif$")
year <- array(0,dim =length(Filenames))

for (j in 1:length(year)) {
# ---- UK ----- #  
# s = strsplit(Filenames[j],"_")[[1]]
# ss = strsplit(s[2],".", fixed=TRUE)[[1]]
# date = as.Date(as.numeric(substr(ss[2], 6, 8)), origin = "2016-01-01")

# ---- Portugal ---- #
s = strsplit(Filenames[j],"_")[[1]]
ss = strsplit(s[2],".", fixed=TRUE)[[1]]
date = as.Date(as.numeric(substr(ss[2], 6, 8)), origin = "2017-01-01")

I = shapefile('H:/TOTAL_INDIA_SCALED_DATA/India.shp')
ex = extent(I)
S1 = shapefile('C:/Users/ARKA GHOSH/Desktop/PHD/Stockholm University/Interview/Portugal.shp')
ex1 = extent(S1)

MAP = raster(Filenames[j])

# r2 <- crop(MAP, ex)#,band
# r3 <- mask(r2, I)

crs(I)
plot(MAP,col=blue2green2red(14),main=paste(date,""),asp = 1,cex.lab = 20,cex.main = 2,interpolate = TRUE,useRaster = TRUE,legend = FALSE)
plot(MAP,legend.only=TRUE, legend.width=2, legend.shrink=1.0,horiz = FALSE,xjust = 1,col=blue2green2red(14),
     axis.args=list(cex.axis=1))
plot(S1,add = TRUE)

#dev.off()

 # if(ex1@xmin <= MAP@extent@xmin && ex1@xmax >= MAP@extent@xmax && ex1@ymin <= MAP@extent@ymin && ex1@ymax >= MAP@extent@ymax){
 #    print(paste(Filenames[j],"T"))
 # }else{
 #   print("F")
 # }

}


print("------ Operation Completed ------")
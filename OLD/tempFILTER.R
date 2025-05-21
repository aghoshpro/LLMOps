library(raster)
library(rasterVis)
library(maptools)
library(rgdal)

setwd("Z://Raster//Test//")
files = list.files(pattern = ".tif$")

inputTemp = 20


for(k in 1:length(files)){
  maxTemp = setMinMax(raster(files[k]))@data@max
  
  par(mfrow=c(2,2))
    test = setMinMax(raster(files[k]))
    plot(test, main = "Original Data")
    hist(test, main = "Original Histogram", col = "red")
    
    test[test[] < inputTemp] = NA
    plot(test, main = paste0(inputTemp," < Filtered Data <", maxTemp))
    hist(test, main = "Filtered Histogram", col = "green")
  
  rf <- writeRaster(test,filename=paste(files[k],"FILTERED_BY_",inputTemp,sep=""), format="GTiff", overwrite=TRUE)
  rm(test,rf)
    
  print(paste(k,'!',length(files)))

}
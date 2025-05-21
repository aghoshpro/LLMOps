library(raster)
library(rasterVis)
# library(ggplot2)
# library(gplots)
library(maptools)
library(rgdal)
# library(RColorBrewer)
# library(Cairo)
# library(colorspace)
# library(colorRamps)
library(ncdf4)
# library(data.table)

setwd("C://Users//ARKA GHOSH//Downloads//2018//")
ncfname = list.files(pattern = ".nc$")# full.names = FALSE)

# I = shapefile('H:/TOTAL_INDIA_SCALED_DATA/New folder/India.shp')
# ex = extent(I)
# crs(I)

for(k in 1:length(ncfname)){
  #k=1
  # open a NetCDF file
  v = stack(ncfname[k],varname="sst")@layers[[1]]
  # r <- crop(v, extent(I))
  # r3 <- mask(r, I)
  rf <- writeRaster(v,filename=paste(ncfname[k],"_Aqua_Day",sep=""), format="GTiff", overwrite=TRUE)
  rm(v,rf)
  
  # v1 = stack(ncfname[k],varname="qual_sst")@layers[[1]]
  # # r <- crop(v1, extent(I))
  # # r3 <- mask(r, I)
  # rf1 <- writeRaster(v1, filename=paste(t[k],"_Q",sep=""), format="GTiff", overwrite=TRUE)
  
  print(k)
}
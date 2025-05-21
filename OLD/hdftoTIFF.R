library(sp)
library(raster)
library(rgdal)
library(gdalUtils)


baseDir = "E://stat//"
setwd(baseDir)

filenames <- list.files(,pattern=".hdf$",full.names = FALSE)

for (filename in filenames)
{
  sds <- get_subdatasets(filename)
  gdal_translate(sds[1], dst_dataset=paste0(substr(filename, 1, nchar(filename)-4) ,".tif"))
}
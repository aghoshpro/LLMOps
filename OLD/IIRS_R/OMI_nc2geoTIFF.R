library(raster)
library(rasterVis)
library(ggplot2)
library(gplots)
library(maptools)
library(rgdal)
library(RColorBrewer)
library(Cairo)
library(colorspace)
library(colorRamps)
library(rgdal)
library(ncdf4)
library(data.table)

setwd("C://Users//ARKA GHOSH//Desktop//PHD//Stockholm University//Interview//OMI_UV//")
ncfname = list.files(pattern = ".nc4$")

S1 = shapefile('C:/Users/ARKA GHOSH/Desktop/PHD/Stockholm University/Interview/Leiraat.shp')
ex = extent(S1)

for (k in 1:5) {
  
  # open a NetCDF file length(ncfname)
  nc <- try(nc_open(ncfname[k]), silent = TRUE)
  if (is.list(nc) == FALSE)
  {
    print(paste("Can't Open", k, "file = ", ncfname[k]))
  } else{
    # Reading Long & Lat from nc file ---------------------------------------------------------------------
    # Long <- ncvar_get(nc, varid = "Longitude")
    # Lat <- ncvar_get(nc, varid = "Latitude")
    
    # Read parameter from nc file -------------------------------------------------------------------------
    Ice <- ncvar_get(nc,"Data_Fields/UVAerosolIndex")
    
    v = stack(ncfname[k], varname = "Data_Fields/UVAerosolIndex")@layers[[1]]
    
    proj4string(v) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") # set map projection
    #v@extent = ex Data Fields/UVAerosolIndex
    
    rf <-
      writeRaster(
        v,
        filename = paste(ncfname[k], "_GeoTIFF_WGS", sep = ""),
        format = "GTiff",
        overwrite = TRUE
      )
    
    rm(v, rf)
    
    print(paste("Opened", k, "file out of", length(ncfname)))
  }
}
# +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0
# +proj=laea +lon_0=0 +datum=WGS84 +ellps=WGS84 +lat_0=-90.0
print("NetCDF to GeoTIFF Conversion is Completed")
library(raster)
library(rgdal)
library(maptools)
library(gdalUtils)
library(rasterVis)
library(ncdf4)

setwd("C://Users//ARKA GHOSH//Downloads//WB_Govt//")
ncfname = list.files(pattern = ".nc$")

# for (j in 1:length(ncfname)) {
#   s = strsplit(ncfname[j],"_")[[1]]
#   year[j] = s[5]
# }
# Add Extent if require
# I = shapefile('H:/All Shape Files/World_Coastline/coastlines.shp')
# ex = extent(I)

for (k in 1:length(ncfname)) {
  # open a NetCDF file
  nc <- try(nc_open(ncfname[k]), silent = TRUE)
  if (is.list(nc) == FALSE)
  {
    print(paste("Can't Open", k, "file = ", ncfname[k]))
  } else{
    # Reading Long & Lat from nc file ---------------------------------------------------------------------
    Long <- ncvar_get(nc, varid = "lon")
    Lat <- ncvar_get(nc, varid = "lat")
    
    # Read parameter from nc file -------------------------------------------------------------------------
    Ice <- ncvar_get(nc, "ice_conc")
    
    v = stack(ncfname[k], varname = "ice_conc")@layers[[1]]
    
    proj4string(v) = CRS("+proj=laea +lon_0=0 +datum=WGS84 +ellps=WGS84 +lat_0=90.0 +units=km") # set map projection
    #v@extent = ex
    
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

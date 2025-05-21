library(raster)
#--- Colormap Libraries ----#
library(colorspace)
library(colorRamps)
library(RColorBrewer)
data(volcano)
r <- raster(volcano)
plot(r, col=blue2green2red(100), legend=FALSE, axes=TRUE)

r.range <- c(minValue(r), maxValue(r))

plot(r, legend.only=TRUE, col=topo.colors(100), legend.width=1, legend.shrink=0.75,
     smallplot=c(0,.09, .3,.75)); par(mar = par("mar"))

plot(r, legend.only=TRUE, col=topo.colors(100), legend.width=1, legend.shrink=0.75,
     smallplot=c(0.3,0.5, 0.2,0.7)); par(mar = par("mar"))

plot(r, legend.only=TRUE, col=topo.colors(100), legend.width=1, legend.shrink=0.75,
     smallplot=c(0.85,0.9, 0.7,0.9)); par(mar = par("mar"))

# plot(r, legend.only=TRUE, col=topo.colors(100), legend.width=1, legend.shrink=0.75,
#      smallplot=c(0.7,0.90, 0.05,0.2)); par(mar = par("mar"))

# plot(r, legend.only=TRUE, col=blue2green2red(100),
#      legend.width= 3, legend.shrink=1.00,xjust = 0,
#      axis.args=list(at=seq(r.range[1], r.range[2], 25),
#                     labels=seq(r.range[1], r.range[2], 25),
#                     cex.axis=1.0),
#      legend.args=list(text='Elevation (m)', side=4, font=2, line=2.5, cex=0.8))


#Source: https://stackoverflow.com/questions/9436947/legend-properties-when-legend-only-t-raster-package
#https://gis.stackexchange.com/questions/269837/categorical-legend-raster-plot-r

#smallplot=c(min % from left, max % from left, min % from bottom, max % from bottom).

library(Cairo)
library(graphics)
library(ggplot2)
library(gridExtra)
library(grid)

setwd("C://Users//ARKA GHOSH//Desktop//Project 2//Slope//")
data = read.csv("Data.csv",sep = ",",na.strings = FALSE)

my_graph = ggplot(data, aes(x = data$NDVI, y = data$LST)) +
  geom_point(aes(shape=factor(data$Year),color = factor(data$Year),size = factor(data$Year))) +
  #geom_smooth()+
  scale_shape_manual(values=c(15,17,19,25))+
  scale_color_manual(values=c('#21D700','#FF19C4', '#003EFF','#FF0000')) +
  scale_size_manual(values=c(5,5,5,5)) +
               stat_smooth(method = "lm",
               col = "#C42126",
               se = FALSE,
               size = 1)

Slope = lm(data$LST ~ data$NDVI)

#geom_point(aes(shape=factor(data$Year),color = factor(data$Year), size = factor(data$Year)))
my_graph +
  theme_bw() +
  labs(
    x = "Normalized Difference Vegetation Index (NDVI)",
    y = "Land Surface Temperature (LST)",             
    color = paste("R^2 = ",format(round(summary(Slope)$r.squared, 5))),
    shape = paste("R^2 = ",format(round(summary(Slope)$r.squared, 5))),
    size = paste("R^2 = ",format(round(summary(Slope)$r.squared, 5))),
    title = "                      Correlation - LST Vs NDVI",
    subtitle = "              Relationship break down year-wise (1989 - 2019)",
    caption = "Arka Ghosh",
    tag = "A"
  )+ theme(
    legend.position = c(0.99, 0.02),
    legend.justification = c("right", "bottom"),
    legend.background	= element_rect(fill = "transparent")#, colour = NULL),
    # legend.text	= element_text(paste("R^2 = ",summary(Slope)$r.squared)),
    #plot.margin = unit(c(1,1,3,1), ""lines"")
  )
#paste("R^2 = ",summary(Slope)$r.squared)
#ggplot2.scatterplot(data=c(x,y), xName='wt',yName='mpg')
# Plot with main and axis titles
# Change point shape (pch = 19) and remove frame.
# plot(x, y, main = "LST Vs NDVI 2019",
#      xlab = "NDVI", ylab = "LST",
#      pch = 18, frame = TRUE, col='red',xlim = c(0,1),ylim = c(17,40))
# # Add regression line
# abline(lm(y ~ x), col = "black")
# Slope = lm(y ~ x)
# #legend("bottomright", "(x,y)", pch = 1, title = paste("R^2 = ",summary(D)$r.squared))
# 
# legend(0.54, 20, col=c("red", "blue"), c(paste("R^2 = ",summary(D)$r.squared), paste("(x,y) = o")), bty="o",  box.col="black", cex=0.8)
# 
# #legend(80, 75, pch=c(2,2), col=c("red", "blue"), c("Male", "Female"), bty="o",  box.col="darkgreen", cex=.8)

open_folder <- function(dir) {
  if (.Platform['OS.type'] == "windows") {
    shell.exec(dir)
  } else {
    system(paste(Sys.getenv("R_BROWSER"), dir))
  }
}

directory = "C:/Users/ARKA GHOSH/Desktop/Project 2/Slope/O/" #<-getwd()
ggsave(paste(directory,"my_fantastic_plot222.png"))
open_folder(directory)


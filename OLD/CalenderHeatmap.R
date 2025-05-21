library(ggplot2)
library(plyr)
library(plotly)

setwd("F://RStudio//Anirban Da//")

### Loading the data
amznStock = as.data.frame(read.csv("CalenderData.csv", header = TRUE))
amznStock = amznStock[year(amznStock$date) > 2012,] # Using data only after 2012 using ggplot2

amznStock$weekday = as.POSIXlt(amznStock$date)$wday #finding the day no. of the week

amznStock$weekdayf =
  factor(
    amznStock$weekday,
    levels = rev(1:7),
    labels = rev(c(
      "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
    )),
    ordered = TRUE
  ) #converting the day no. to factor

amznStock$monthf =
  factor(
    month(amznStock$date),
    levels = as.character(1:12),
    labels = c(
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ),
    ordered = TRUE
  ) # finding the month

amznStock$yearmonth =  factor(as.yearmon(amznStock$date)) #finding the year and the month from the date. Eg: Nov 2018

amznStock$week = as.numeric(format(amznStock$date, "%W")) #finding the week of the year for each date

amznStock =  ddply(amznStock, .(yearmonth), transform, monthweek = 1 + week - min(week)) #normalizing the week to start at 1 for every month

p = ggplot(amznStock, aes(monthweek, weekdayf, fill = adjusted)) + 
    geom_tile(colour = "black") + facet_grid(year(amznStock$date) ~  monthf) +
    scale_fill_gradient(low = "red", high = "green") +
    xlab("Week of Month") + ylab("") + 
    ggtitle("Time-Series Calendar Heatmap: AMAZON Stock Prices") + 
    labs(fill = "Price")+
    theme(plot.title = element_text(hjust = 0.5, size=16),
        axis.title.x = element_text(color="black", size=13, face="bold"),
        axis.title.y = element_text(color="black", size=13, face="bold"),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0),
        strip.text.x = element_text(size = 14, colour = "black", angle = 0),
        strip.text.y = element_text(size = 14, colour = "black", angle = 0),
        legend.text = element_text(colour="black", size=12,face="bold")
        )


# Save The Plot in path directory ---------------------#
ggsave(
  "Calender Heatmap Plot (UPDATED).png",
  plot = p,
  path = "F://RStudio//Anirban Da//",
  scale = 1,
  width = 18,
  height = 12,
  units = "in",
  dpi = 300,
  limitsize = TRUE,
)


#Load the function to the local through Paul Bleicher's GitHub page
#source("https://raw.githubusercontent.com/iascchen/VisHealth/master/R/calendarHeat.R")
#https://towardsdatascience.com/time-series-calendar-heatmaps-9f576578fcfe
#https://www.r-bloggers.com/2012/04/ggplot2-time-series-heatmaps/

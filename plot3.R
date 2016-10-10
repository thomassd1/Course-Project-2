########################################################################################
# plot3.R
# created: 10-09-2016 steveT
#
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
########################################################################################
library(ggplot2)
library(plyr)

## read in data
## Will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

BaltCityMD_pm25 <- subset(NEI, fips == "24510")

fn <- function(x) sum(x)

BaltCityMD_Esum <- ddply(BaltCityMD_pm25, .(year, type), transform, Esum=fn(Emissions))

qplot(year, Esum, data = BaltCityMD_Esum, color = type, geom = "line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.copy(png,'plot3.png')
dev.off()
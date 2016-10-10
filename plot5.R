########################################################################################
# plot5.R
# created: 10-09-2016 steveT
#
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
########################################################################################
library(ggplot2)
library(plyr)

## read in data
## Will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltCityMD_pm25 <- subset(NEI, fips == "24510")
motorveh <- subset(SCC, grepl("Vehicle", SCC.Level.Three))
motorvehicles <- merge(BaltCityMD_pm25, motorveh, by="SCC") 

fn <- function(x) sum(x)

motorvehicles_Esum <- ddply(motorvehicles, .(year), transform, Esum=fn(Emissions))

qplot(year, Esum, data = motorvehicles_Esum, geom = "line") +
  ggtitle(expression("Baltimore City Motor Vehicles" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.copy(png,'plot5.png')
dev.off()

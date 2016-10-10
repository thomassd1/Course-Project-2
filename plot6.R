########################################################################################
# plot6.R
# created: 10-10-2016 steveT
#
# Which city, LA or Baltimore, has seen greater changes over time in motor vehicle emissions?
# 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
########################################################################################
library(ggplot2)
library(plyr)

## read in data
## Will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltCity_pm25 <- subset(NEI, fips == "24510")
laCounty_pm25 <- subset(NEI, fips == "06037")

baltCity_pm25$city <- "Baltimore City"
laCounty_pm25$city <- "Los Angeles County"

combined <- rbind(baltCity_pm25, laCounty_pm25)

motorveh <- subset(SCC, grepl("Vehicle", SCC.Level.Three))
motorvehicles <- merge(combined, motorveh, by="SCC") 

fn <- function(x) sum(x)

motorvehicles_Esum <- ddply(motorvehicles, .(year), transform, Esum=fn(Emissions))

qplot(year, Esum, data = motorvehicles_Esum, color = city, geom = "line") +
  ggtitle(expression("Baltimore City and Los Angeles County Motor Vehicles" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

ggplot(motorvehicles_Esum, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))


dev.copy(png,'plot6.png')
dev.off()

########################################################################################
# plot4.R
# created: 10-08-2016 steveT
#
# how have emissions from coal combustion-related sources changed from 1999-2008? 
# 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
########################################################################################

library(ggplot2)
library(plyr)

## read in data
## Will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalComb <- subset(SCC, grepl("Coal", Short.Name) & grepl("Comb", Short.Name))
coalCombust <- merge(NEI, coalComb, by="SCC") 

fn <- function(x) sum(x)

coalCombust_Esum <- ddply(coalCombust, .(year, type), transform, Esum=fn(Emissions))

qplot(year, Esum, data = coalCombust_Esum, color = type, geom = "line") +
  ggtitle(expression("U.S. Coal Combustion" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.copy(png,'plot4.png')
dev.off()

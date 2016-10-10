########################################################################################
# plot2.R
# created: 10-08-2016 steveT
#
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
# 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
########################################################################################

## read in data
## Will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

BaltCityMD_pm25 <- subset(NEI, fips == "24510")

# apply sum to emissions
pm25ByYear <- tapply(BaltCityMD_pm25$Emissions, BaltCityMD_pm25$year, sum)

# plot the sum of emission shown by year
     
plot(names(pm25ByYear), pm25ByYear, type = "l", xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
     
dev.copy(png,'plot2.png')
dev.off()
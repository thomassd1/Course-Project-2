########################################################################################
# plot1.R
# created: 10-08-2016 steveT
#
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
########################################################################################

## read in data
## Will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# apply sum to emissions
pm25ByYear <- tapply(NEI$Emissions, NEI$year, sum)

# plot the sum of emission shown by year
plot(names(pm25ByYear), pm25ByYear, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
     
     
dev.copy(png,'plot1.png')
dev.off()

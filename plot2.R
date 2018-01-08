# Plot 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.


# zip file with both RDS files extracted to working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create subset for Baltimore only
Baltimore <- subset(NEI, fips == "24510")

# calculate average emissions for each year
totalBmoreEmissions <- aggregate(Baltimore$Emissions, list(Baltimore$year), sum)

#rename columns
colnames(totalBmoreEmissions) <- c("Year", "Total.Emissions")

#create plot with title for averages
plot(totalBmoreEmissions, main = "Total Emissions Over Time in Baltimore City", col = "red", pch = 13)

#save to png
png(file='plot2.png')
plot(totalBmoreEmissions, main = "Total Emissions Over Time in Baltimore City", col = "red", pch = 13)
dev.off()
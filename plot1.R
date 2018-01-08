# Plot 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# code provided for secondary plot of total emissions, rather than average (more readable and shows same downward trend)



# zip file with both RDS files extracted to working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# calculate average emissions for each year
avgEmissions <- aggregate(NEI$Emissions, list(NEI$year), mean)
# totalEmissions <- aggregate(NEI$Emissions, list(NEI$year), sum)

#rename columns
colnames(avgEmissions) <- c("Year", "Average.Emissions")
# colnames(totalEmissions) <- c("Year", "Sum.of.Emissions")

#create canvas for 2 charts
# par(mfrow=c(1,2))

#create plot with title for averages
plot(avgEmissions, main = "Average Emissions Over Time", col = "blue")

#create plot with title for totals
# plot(totalEmissions, main = "Total Emissions Over Time", col = "red", pch = 20)

#save to png
png(file='plot1.png')
# par(mfrow= c(1, 2))
plot(avgEmissions, main = "Average Emissions Over Time", col = "blue")
# plot(totalEmissions, main = "Total Emissions Over Time", col = "red", pch = 20)
dev.off()

# Plot 5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# zip file with both RDS files extracted to working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2  package
library("ggplot2")

#subset based on grepl function that identifies all motor vehicle sources
motorV <- SCC[grepl(pattern = "^Highway Veh", ignore.case = TRUE, SCC$Short.Name),]

#filter NEI to show only SCC identifiers from new motor vehicle subset
motorV <- merge(x = NEI, y = motorV, by = "SCC", all = TRUE)

# create subset of motor vehicle group for Baltimore only
BmoreMotorV <- subset(motorV, fips == "24510")

#find average emissions by year for new subset
BmoreMVAvgEmissions <- aggregate(BmoreMotorV$Emissions, list(BmoreMotorV$year), mean)

#name columns
names(BmoreMVAvgEmissions) <- c("year", "Avg_Emissions")

# create plot off avg emissions per year for coal
p <- ggplot(data = BmoreMVAvgEmissions, aes(x=year, y=Avg_Emissions)) + geom_point()

# create trend line & title
p + geom_smooth(method ="lm", se = FALSE) + ggtitle(label = "Motor Vehicle Emissions over Time in Baltimore City")

#save to png
ggsave('plot5.png')
dev.off()

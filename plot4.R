# Plot 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# zip file with both RDS files extracted to working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2  package
library("ggplot2")

#subset based on grepl function that identifies all coal-related sources
coal <- SCC[grepl(pattern = "coal", ignore.case = TRUE, SCC$Short.Name),]

#filter NEI to show only SCC identifiers from new coal data frame
coal <- merge(x = NEI, y = coal, by = "SCC", all = TRUE)

#find average coal emissions by year
coalEmissions <- aggregate(coal$Emissions, list(coal$year), mean)

#name columns
names(coalEmissions) <- c("year", "avgEmissions")

# create plot off avg emissions per year for coal
p <- ggplot(data = coalEmissions, aes(x=year, y=avgEmissions)) + geom_point()

# create trend line & title
p + geom_smooth(method ="lm", se = FALSE) + ggtitle(label = "Coal Emissions over Time in USA")

#save to png
ggsave('plot4.png')
dev.off()
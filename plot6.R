# Plot 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# zip file with both RDS files extracted to working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2  package
library("ggplot2")
library("dplyr")
library("plyr")

#subset based on grepl function that identifies all motor vehicle sources
motorV <- SCC[grepl(pattern = "^Highway Veh", ignore.case = TRUE, SCC$Short.Name),]

#filter NEI to show only SCC identifiers from new motor vehicle subset
motorV <- merge(x = NEI, y = motorV, by = "SCC", all = TRUE)

# create subset of motor vehicle group for Baltimore and Los Angeles County (fips == "06037")
CityCompbyMotorV <- subset(motorV, fips == "24510" | fips == "06037")

#find average emissions by year for new subset
CompMVAvgEmissions <- CityCompbyMotorV %>%
  group_by(fips, year) %>%
  summarize(avg_emissions = mean(Emissions))

#create data frame
CompMVAvgEmissions <- as.data.frame(CompMVAvgEmissions)

#add column for city
CompMVAvgEmissions <- CompMVAvgEmissions %>% 
  mutate(city = if_else(fips == "06037", "Los Angeles County", "Baltimore City"))

# #create initial plot with legend to color code by type & title
p <- ggplot(data = CompMVAvgEmissions, 
    aes(x=year, y=avg_emissions, color=city)) + geom_point()

#add chart titles + insert linear regression line w/o confidence interval to show overall trend & update colors 
p + geom_smooth(method = 'lm', se = FALSE) + scale_colour_brewer(palette = "Set1") + labs(title = "Emissions Over Time: LA vs Baltimore", subtitle = "Comparison of Motor Vehicle Emissions Trends") 

#save to png
ggsave('plot6.png')
dev.off()
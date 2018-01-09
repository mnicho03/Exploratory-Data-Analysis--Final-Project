# Plot 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# zip file with both RDS files extracted to working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2 & dplyr & plyr package
library("ggplot2")
library("dplyr")
library("plyr")

# create subset for Baltimore only
Baltimore <- subset(NEI, fips == "24510")

#keep required columns
Baltimore <- select(NEI, Emissions, type, year)

#summarize remaining fields to answer question of emission rates by type over time
EmissionsByType <- Baltimore %>%
  group_by(type, year) %>%
  summarize(avg_emissions = mean(Emissions))

#create data frame
as.data.frame(EmissionsByType)

#create initial plot with legend to color code by type & title
p <- ggplot(data = EmissionsByType, 
       aes(x=year, y=avg_emissions, color=type)) + geom_point()

#add chart title + insert linear regression line w/o confidence interval to show overall trend & update colors 
p + geom_smooth(method = 'lm', se = FALSE) + scale_colour_brewer(palette = "Set1") + ggtitle("Avg Emissions Over Time by Emission Type") 

#clearly display total change over time
Bmore2 <- as.data.frame(subset(EmissionsByType, year == 1999 | year == 2008))
Bmore2 <- ddply(Bmore2,c("type"),summarise,Change=diff(avg_emissions))
Bmore2

#save to png
ggsave('plot3.png')
dev.off()

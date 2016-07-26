## This first line will likely take a few seconds. Be patient!
library(ggplot2)
library(tidyr)
NEI <- readRDS("summarySCC_PM25.rds")
Classify <- readRDS("Source_Classification_Code.rds")
NEI_merge <- merge(NEI, Classify, by.y = "SCC")
NEI_merge <- NEI_merge[,c(1:6, 8)]
NEI_baltimore <- subset(NEI_merge, fips == "24510")
NEI_LA <- subset(NEI_merge, fips == "06037")
MV_baltimore <- NEI_baltimore[grepl(pattern = "Highway Veh", x = NEI_baltimore$Short.Name),]
MV_LA <- NEI_LA[grepl(pattern = "Highway Veh", x = NEI_LA$Short.Name),]
NEI_MV_tot1 <- aggregate(Emissions~year, data = MV_baltimore, sum)
NEI_MV_tot2 <- aggregate(Emissions~year, data = MV_LA, sum)
NEI_MV_comb <- data.frame(year = NEI_MV_tot1$year, 'Baltimore city'= NEI_MV_tot1$Emissions, 'Los Angeles' = NEI_MV_tot2$Emissions)
NEI_MV_gather <- gather(NEI_MV_comb, County, Emission, -year)
ggplot(NEI_MV_gather, aes(x = factor(year), y = Emission, fill = County)) + xlab("Year") + ylab("Total Emission by Motor Vehicles") + geom_bar(stat = "identity")+ ggtitle(expression('Comparison of Total emission of PM'[2.5]*' in Baltimore with Los Angeles'))
dev.copy(png, file = "plot6.png")
dev.off()
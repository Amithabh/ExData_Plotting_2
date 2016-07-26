## This first line will likely take a few seconds. Be patient!
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
Classify <- readRDS("Source_Classification_Code.rds")
NEI_merge <- merge(NEI, Classify, by.y = "SCC")
NEI_merge <- NEI_merge[,c(1:6, 8)]
NEI_baltimore <- subset(NEI_merge, fips == "24510")
MV_baltimore <- NEI_baltimore[grepl(pattern = "Highway Veh", x = NEI_baltimore$Short.Name),]
#NEI_MV <- subset(NEI_baltimore1, NEI_baltimore1$SCC %in% MV_baltimore$SCC)
NEI_MV_tot <- aggregate(Emissions~year, data = MV_baltimore, sum)
#qplot(x=year, y=Emissions, data = NEI_MV_tot, colour = I("orange"), geom = c("path","point"), ylab = "Total Emission from Motor Vehicles (ton)")
ggplot(NEI_MV_tot, aes(x = factor(year), y = Emissions)) + geom_bar(stat = "identity", fill= "darkgreen") + xlab("Year") + ylab("Total Emission from motor vehicles") + ggtitle(expression('Total emission of PM'[2.5]*' from ON-ROAD vehicles in the United States'))
dev.copy(png, file = "plot5.png")
dev.off()
## This first line will likely take a few seconds. Be patient!
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Coal_dat <- SCC[grepl(pattern = "Coal", x = SCC$Short.Name),]
NEI_Coal <- subset(NEI, NEI$SCC %in% Coal_dat$SCC)
NEI_Coal_tot <- aggregate(Emissions~year, data = NEI_Coal, sum)
#qplot(x=year, y=Emissions/10^6, data = NEI_Coal_tot, colour = I("blue"), geom = c("path","point"), ylab = "Total Emission from Coal related sources (megaton)")
ggplot(NEI_Coal_tot, aes(x = factor(year), y = Emissions)) + geom_bar(stat = "identity", fill= "darkgreen") + xlab("Year") + ylab("Total Emission") + ggtitle(expression('Total emission of PM'[2.5]*' from Coal combustion in the United States by year'))
dev.copy(png, file = "plot4.png")
dev.off()
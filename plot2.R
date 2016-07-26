## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_baltimore <- subset(NEI, fips == "24510")
NEI_tot <- aggregate(Emissions~year, data = NEI_baltimore, sum)
ggplot(NEI_tot, aes(x = factor(year), y = Emissions)) + geom_bar(stat = "identity", fill= "darkgreen") + xlab("Year") + ylab("Total Emission from all sources") + ggtitle(expression('Total emission of PM'[2.5]*' in Baltimore city by year'))
dev.copy(png, file = "plot2.png")
dev.off()
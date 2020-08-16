library(data.table)
library(ggplot2)
options(scipen=999)

# Reading Data

NEI <- setDT(readRDS(".\\Data\\summarySCC_PM25.rds"))

# Calculating Sum of Emissions across years for different types

sum_across_years_bytype <- NEI[, .(TotalEmissions = sum(Emissions, na.rm=TRUE)), keyby=list(type,year)]

# Making a Bar Plot

png(filename='.\\Results\\plot3.png', width=1024, height=768, res=200)
ggplot(sum_across_years_bytype, aes(x=as.character(year), y=TotalEmissions, group=type, col=type)) + 
  geom_line() + geom_point() + theme_minimal() + labs(title='Total Emissions by Pollution Source') + 
  xlab('Year') + ylab('Total Emissions (tons - log scale)') + scale_y_continuous(trans = 'log10') + annotation_logticks(sides='l')
dev.off()


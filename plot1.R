library(data.table)
options(scipen=999)

# Reading Data

NEI <- setDT(readRDS(".\\Data\\summarySCC_PM25.rds"))

# Calculating Sum of Emissions across years

sum_across_years <- NEI[, .(TotalEmissions = sum(Emissions, na.rm=TRUE)), keyby=year]

# Making a Bar Plot

png(filename='.\\Results\\plot1.png', width=960, height=960, res=200)
barplot(height=sum_across_years[,TotalEmissions], names.arg=sum_across_years[,year], 
        xlab='Year', ylab='Total Emissions(tons)', main='Total Emissions across Years',
        ylim=range(pretty(c(0,sum_across_years[,TotalEmissions]))))
dev.off()


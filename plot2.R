library(data.table)
options(scipen=999)

# Reading Data

NEI <- setDT(readRDS(".\\Data\\summarySCC_PM25.rds"))

# Calculating Sum of Emissions across years for Baltimore

sum_across_years_baltimore <- NEI[fips=='24510', .(TotalEmissions = sum(Emissions, na.rm=TRUE)), keyby=year]

# Making a Bar Plot

png(filename='.\\Results\\plot2.png', width=960, height=960, res=200)
bp <- barplot(height=sum_across_years_baltimore[,TotalEmissions], names.arg=sum_across_years_baltimore[,year], 
        xlab='Year', ylab='Total Emissions(tons)', main='Total Emissions across Years for Baltimore',
        ylim=range(pretty(c(0,sum_across_years_baltimore[,TotalEmissions]))))
dev.off()

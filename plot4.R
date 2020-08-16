library(data.table)
options(scipen=999)

# Reading Data
# Empty [], converts the list obtained from lapply to a dataframe
# See more explanation at https://stackoverflow.com/questions/2851015/convert-data-frame-columns-from-factors-to-characters/2851213

NEI <- setDT(readRDS(".\\Data\\summarySCC_PM25.rds"))
SCC <- setDT(lapply(readRDS(".\\Data\\Source_Classification_Code.rds"), as.character)[]) 

# Figuring out codes which correspond to coal

coal_codes <- SCC[grep(pattern='\\sComb.+Coal',x=EI.Sector, ignore.case=TRUE),SCC]

# Calculating Sum of Emissions across years for Coal

sum_across_years_coal <- NEI[SCC %in% coal_codes, .(TotalEmissions = sum(Emissions, na.rm=TRUE)), keyby=year]

# Making a Bar Plot

png(filename='.\\Results\\plot4.png', width=960, height=960, res=200)
barplot(height=sum_across_years_coal[,TotalEmissions], names.arg=sum_across_years_coal[,year], 
        xlab='Year', ylab='Total Emissions(tons)', main='Total Emissions for Coal Combustion',
        ylim=range(pretty(c(0,sum_across_years_coal[,TotalEmissions]))))
dev.off()


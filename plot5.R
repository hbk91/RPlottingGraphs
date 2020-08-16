library(data.table)
options(scipen=999)

# Reading Data
# Empty [], converts the list obtained from lapply to a dataframe
# See more explanation at https://stackoverflow.com/questions/2851015/convert-data-frame-columns-from-factors-to-characters/2851213

NEI <- setDT(readRDS(".\\Data\\summarySCC_PM25.rds"))
SCC <- setDT(lapply(readRDS(".\\Data\\Source_Classification_Code.rds"), as.character)[]) 

# Figuring out codes which correspond to motor vehicle

motor_vehicle_codes <- SCC[SCC.Level.One=='Mobile Sources',SCC]

# Calculating Sum of Emissions across years for Motor Vehicles for Baltimore

sum_across_years_motor_baltimore <- NEI[SCC %in% motor_vehicle_codes &  fips=='24510', .(TotalEmissions = sum(Emissions, na.rm=TRUE)), keyby=year]

# Making a Bar Plot

png(filename='.\\Results\\plot5.png', width=960, height=960, res=200)
barplot(height=sum_across_years_motor_baltimore[,TotalEmissions], names.arg=sum_across_years_motor_baltimore[,year], 
        xlab='Year', ylab='Total Emissions(tons)', main='Emissions for Motor Vehicles in Baltimore', 
        ylim=range(pretty(c(0,sum_across_years_motor_baltimore[,TotalEmissions])))) 
dev.off()


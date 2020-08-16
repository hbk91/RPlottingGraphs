library(data.table)
library(ggplot2)
options(scipen=999)

# Reading Data

NEI <- setDT(readRDS(".\\Data\\summarySCC_PM25.rds"))
SCC <- setDT(lapply(readRDS(".\\Data\\Source_Classification_Code.rds"), as.character)[]) 

# Figuring out codes which correspond to motor vehicle

motor_vehicle_codes <- SCC[SCC.Level.One=='Mobile Sources',SCC]

# Calculating Sum of Emissions across years for Motor Vehciles for Baltimore and Los Angeles

df_summary <- NEI[fips %in% c('24510','06037'),][, .(TotalEmissions = sum(Emissions, na.rm=TRUE)), keyby=list(fips, year)]
df_summary[,RelativeEmissions:=c(as.numeric(df_summary[1:4,TotalEmissions]/df_summary[1,TotalEmissions]), 
                                 as.numeric(df_summary[5:8,TotalEmissions]/df_summary[5,TotalEmissions]))]

# Making a Line Plot

png(filename='.\\Results\\plot6.png', width=1024, height=768, res=200)
ggplot(df_summary, aes(x=as.character(year), y=TotalEmissions, group=fips, col=fips)) + 
  geom_line() + geom_point() + scale_y_continuous(trans = 'log10') + labs(title='Absolute Emissions', col='City') +
  scale_color_manual(labels = c("Los Angles", "Baltimore"), values = c("blue", "red")) + 
  xlab('Year') + ylab('Emissions (tons)') + annotation_logticks(sides='l') + theme_minimal()
dev.off()





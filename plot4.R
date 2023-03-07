rm(list=ls())#clear all data from your current Global Environment

setwd("F:/Github/Cousera-EDA-project2")


Zipfile <- "Coursera_EDA_Project.zip"

# Checking if Zipfile exists already exists.
if (!file.exists(Zipfile)){
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileurl, Zipfile)
}  

# Checking if folder is unzipped exists
if (!file.exists("Source_Classification_Code.rds") && 
    !file.exists("summarySCC_PM25.rds")) { 
  unzip(Zipfile)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,]
totalCoal <- aggregate(Emissions ~ year + type, NEIcoal, sum)

ggplot(totalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emission by Type and Year")) +
  xlab("Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  scale_colour_discrete(name = "Type of sources") +
  theme(legend.title = element_text(face = "bold"))

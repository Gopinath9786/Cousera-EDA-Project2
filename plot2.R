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

baltimore <- subset(NEI, NEI$fips == "24510")

totalBaltimore <- aggregate(Emissions ~ year, baltimore, sum)

barplot(totalBaltimore$Emissions, main="total Baltimore emission",
        names.arg = totalNEI$year)

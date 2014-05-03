if(require(data.table)==FALSE)
  install.packages("data.table")
library(data.table)

if(require(XLConnect)==FALSE)
  install.packages("XLConnect")
library(XLConnect)               # load XLConnect package 

# This package might make it easier to read
if(require(xlsx)==FALSE)
    install.packages("xlsx")
library(xlsx)

#this would be the command to run to read the xls file
 df <- read.xlsx("Cleaned_Wheat.xls", sheetIndex=1)

#this part didn't seem to want to run. It said there were illegal arguments
#wk = loadWorkbook("Cleaned_Wheat.xls") 
#df = readWorksheet(wk, sheet="Wheat")

#grab csv files
a = paste(getwd(), "/*.csv", sep="")
b = Sys.glob(a)
c = lapply(b, fread)

#grab desired variables (cpi)
cpi <- c[[1]]
cpi.sub <- cpi[343:741]

year <- df[[1]]
wheat <- df[[2]]
Change <- df[[3]]
cpi.sub$Wheat <- wheat

Date <- cpi.sub$Date
CPI <- cpi.sub$Close
Inflation <- cpi.sub$Inflation
Wheat <- cpi.sub$Wheat

#conversion from matrix to DT to DF (wheat prices)
cpi_wheat_matrix <- cbind(Date, CPI, Wheat)
cpi_wheat_table <- as.data.table(cpi_wheat_matrix)
setkey(cpi_wheat_table, Date, CPI, Wheat)
DFW <- as.data.frame(cpi_wheat_table)

#conversion from matrix to DT to DF (changes in gold prices)
inflation_wchange_matrix = cbind(Date, Inflation, Change)
inflation_wchange_table = as.data.table(inflation_wchange_matrix)
setkey(inflation_wchange_table, Date, Inflation, Change)
DFWC = as.data.frame(inflation_wchange_table)

#conversion from factor to numeric (wheat prices)
Wheat_factor <- DFW$Wheat
CPI_factor <- DFW$CPI
Wheat_numbers <- as.numeric(levels(Wheat_factor)[as.integer(Wheat_factor)])
CPI_numbers <- as.numeric(levels(CPI_factor)[as.integer(CPI_factor)])
Date <- levels(DFW$Date)[DFW$Date]
Date <- as.Date(Date, "%m/%d/%Y")
Date <- year(Date)
DFW$Date <- Date
DFW$Wheat <- Wheat_numbers
DFW$CPI <- CPI_numbers

#conversion from factor to numeric (changes in gold prices)
Wchange_factor <- DFWC$Change
Inflation_factor <- DFWC$Inflation
Wchange_numbers <- as.numeric(levels(Wchange_factor)[as.integer(Wchange_factor)])
Inflation_numbers <- as.numeric(levels(Inflation_factor)[as.integer(Inflation_factor)])
Date <- levels(DFWC$Date)[DFWC$Date]
Date <- as.Date(Date, "%m/%d/%Y")
Date <- year(Date)
DFWC$Date <- Date
DFWC$Change <- Wchange_numbers
DFWC$Inflation <- Inflation_numbers

#plot Wheat
plot(DFW$Date,DFW$Wheat, type="n", xlab="Year", ylab="Wheat Price")
lines(DFW$Date,DFW$Wheat, col="red")
title("Wheat")

#plot Wheat Changes
plot(DFWC$Date,DFWC$Inflation, type="n", xlab="Year", ylab="Changes")
lines(DFWC$Date,DFWC$Change, col="blue")
lines(DFWC$Date,DFWC$Inflation, col="red")
title("Wheat")
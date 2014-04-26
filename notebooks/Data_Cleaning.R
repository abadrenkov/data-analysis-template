#first change director to where the data is located
#can achieve this using the `setwd()` function
if(require(data.table)==FALSE)
  install.packages("data.table")
library(data.table)

#grab csv files
a = paste(getwd(), "/*.csv", sep="")
b = Sys.glob(a)
c = lapply(b, fread)

#grab desired variables (gold)
cpi <- c[[1]]
gold <- c[[2]]

#matching available time frames (gold)
cpi_gold <- merge(cpi,gold, by="Date")
Date <- cpi_gold$Date
CPI <- cpi_gold$Close.x
Inflation <- cpi_gold$Inflation
Gold <- cpi_gold$Close.y
Change <- cpi_gold$Change

#conversion from matrix to DT to DF (gold prices)
cpi_gold_matrix <- cbind(Date, CPI, Gold)
cpi_gold_table <- as.data.table(cpi_gold_matrix)
setkey(cpi_gold_table, Date, CPI, Gold)
DFG <- as.data.frame(cpi_gold_table)


#conversion from matrix to DT to DF (changes in gold prices)
inflation_gchange_matrix = cbind(Date, Inflation, Change)
inflation_gchange_table = as.data.table(inflation_gchange_matrix)
setkey(inflation_gchange_table, Date, Inflation, Change)
DFGC = as.data.frame(inflation_gchange_table)

#conversion from factor to numeric (gold prices)
Gold_factor <- DFG$Gold
CPI_factor <- DFG$CPI
Gold_numbers <- as.numeric(levels(Gold_factor)[as.integer(Gold_factor)])
CPI_numbers <- as.numeric(levels(CPI_factor)[as.integer(CPI_factor)])
Date <- levels(DFG$Date)[DFG$Date]
Date <- as.Date(Date, "%m/%d/%Y")
DFG$Date <- Date
DFG$Gold <- Gold_numbers
DFG$CPI <- CPI_numbers

#conversion from factor to numeric (changes in gold prices)
Gchange_factor <- DFGC$Change
Inflation_factor <- DFGC$Inflation
Gchange_numbers <- as.numeric(levels(Gchange_factor)[as.integer(Gchange_factor)])
Inflation_numbers <- as.numeric(levels(Inflation_factor)[as.integer(Inflation_factor)])
Date <- levels(DFGC$Date)[DFGC$Date]
Date <- as.Date(Date, "%m/%d/%Y")
DFGC$Date <- Date
DFGC$Change <- Gchange_numbers
DFGC$Inflation <- Inflation_numbers

#grab desired variables (silver)
Silver <- c[[3]]
cpis <- c[[1]]

#match available time frames (silver)
cpi_silver = merge(cpis, Silver, by = "Date")
Date = cpi_silver$Date
CPI <- cpi_silver$Close.x
Inflation <- cpi_silver$Inflation
Silver <- cpi_silver$Close.y
Change <- cpi_silver$Change

#conversion of matrix from DT to DF (silver)
cpi_silver_matrix <- cbind(Date, CPI, Silver)
cpi_silver_table <- as.data.table(cpi_silver_matrix)
setkey(cpi_silver_table, Date, CPI, Silver)
DFS <- as.data.frame(cpi_silver_table)

#conversion of matrix from DT to DF (change in silver prices)
inflation_schange_matrix <- cbind(Date, Inflation, Change)
inflation_schange_table <- as.data.table(inflation_schange_matrix)
setkey(inflation_schange_table, Date, Inflation, Change)
DFS <- as.data.frame(inflation_schange_table)

#conversion from factor to numeric (silver prices)
Silver_factor <- DFS$Silver
CPI_factor = DFS$CPI
Silver_numbers <- as.numeric(levels(Silver_factor)[as.integer(Silver_factor)])
CPI_numbers = as.numeric(levels(CPI_factor)[as.integer(CPI_factor)])
DateS <- levels(DFS$Date)[DFS$Date]
DateS <- as.Date(Date, "%m/%d/%Y")
DFS$Date = Date
DFS$Silver <- Silver_numbers
DFS$CPI = CPI_numbers

#conversion from factor to numeric (change in silver prices)
Schange_factor <- DFS$Change
Inflation_factor = DFS$Inflation
Schange_numbers <- as.numeric(levels(Schange_factor)[as.integer(Schange_factor)])
Inflation_numbers = as.numeric(levels(Inflation_factor)[as.integer(Inflation_factor)])
DateS <- levels(DFS$Date)[DFS$Date]
DateS <- as.Date(Date, "%m/%d/%Y")
DFS$Date = Date
DFS$Change <- Schange_numbers
DFS$Inflation = Inflation_numbers

#can now use numberic values to run tests
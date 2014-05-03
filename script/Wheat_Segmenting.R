file <- read.xlsx("../data/raw/Wheat_Prices_1790_1850.xls", 1)
segment <- file[-(1:5),c("NA.","NA..23")]
names(segment) <- c("Year", "Price")
rownames(segment) <- 1:dim(segment)[1]
write.xlsx(segment, "../data/raw/Wheat_Prices_1790_1850_2.xls", sheetName="Wheat")

file2 <- read.xlsx("../data/raw/Wheat_Prices_1850_1950.xls", 1)
segment <- file2[-(1:7),1:2]
names(segment) <- c("Year", "Price")
rownames(segment) <- 1:dim(segment)[1]
write.xlsx(segment, "../data/raw/Wheat_Prices_1850_1950_2.xls", sheetName="Wheat")
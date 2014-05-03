source("Data_Cleaning.R")
subset <- DFG
a <- rep(1:151, each=10)
subset$Factor <- a
rownames(subset) <- 1:dim(subset)[1]
subset$Factor <- factor(subset$Factor)
mean_CPI <- tapply(subset$CPI, subset$Factor, mean)
mean_CPI <- as.data.frame(mean_CPI)
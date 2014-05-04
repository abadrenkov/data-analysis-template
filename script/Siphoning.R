source("Data_Cleaning.R")
subset <- DFG[6:755,]
a <- rep(1:75, each=10)
subset$Factor <- a
rownames(subset) <- 1:dim(subset)[1]
subset$Factor <- factor(subset$Factor)

mean_CPI <- tapply(subset$CPI, subset$Factor, mean)
#mean_CPI <- as.data.frame(mean_CPI)

mean_gold <- tapply(subset$Gold, subset$Factor, mean)
#mean_gold <- as.data.frame(mean_gold)

Decades = subset$Date[seq(1, length(subset$Date), by=10)]
mean_gold_matrix <- cbind(Decades, mean_CPI, mean_gold)
mean_gold_table <- as.data.table(mean_gold_matrix)
setkey(mean_gold_table, mean_CPI, mean_gold)
mean_DFG <- as.data.frame(mean_gold_matrix)

diff_CPI = diff(mean_DFG$mean_CPI, lag=1)
diff_gold = diff(mean_DFG$mean_gold, lag=1)
diff_matrix = cbind(diff_CPI, diff_gold)
diff_table = as.data.table(diff_matrix)
setkey(diff_table, diff_CPI, diff_gold)

plot(mean_DFG$mean_CPI, mean_DFG$mean_gold, xlab = "mean_CPI", ylab = "mean_gold")
plot(log(mean_DFG$mean_CPI), log(mean_DFG$mean_gold),
     xlab = "log(mean_CPI)", ylab = "log(mean_gold)")
plot(diff_CPI, diff_gold, xlab = "diff(mean_CPI)", ylab = "diff(mean_gold)")

plot(diff_CPI, diff_gold, type="n", xlab="Difference Number", ylab="diff(mean_gold)", xlim = c(0, 80))
lines(1:length(diff_CPI),diff_CPI, col="red")
lines(1:length(diff_gold),diff_gold, col="blue")

#years <- subset$Date
#plot(diff(years, lag=2, difference=1))

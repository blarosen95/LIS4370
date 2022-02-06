df <- data.frame(Freq=c(0.6, 0.3, 0.4, 0.4, 0.2, 0.6, 0.3, 0.4, 0.9, 0.2),
                 bloodp=c(103, 87, 32, 42, 59, 109, 78, 205, 135, 176),
                 first=c(1, 1, 1, 1, 0, 0, 0, 0, NA, 1),
                 second=c(0, 0, 1, 1, 0, 0, 1, 1, 1, 1),
                 finaldecision=c(0, 1, 0, 1, 0, 1, 0, 1, 1, 1))

boxplot(df$bloodp~df$first, main="Blood Pressure vs. First Decision (Internal)",
        xlab="First Decision", ylab="Blood Pressure", names=c("Good", "Bad"))

boxplot(df$bloodp~df$second, main="Blood Pressure vs. Second Decision (External)",
        xlab="Second Decision", ylab="Blood Pressure", names=c("Low", "High"))

boxplot(df$bloodp~df$finaldecision, main="Blood Pressure vs. Final Decision",
        xlab="Final Decision", ylab="Blood Pressure", names=c("Low", "High"))

hist(df$Freq, main="Visit Frequency Distribution", xlab="12-Month Frequency", ylab="Count")

hist(df$bloodp, main="Blood Pressure Distribution", xlab="Blood Pressure")

hist(df$first, main="First Decision Distribution", xlab="First Decision")

hist(df$second, main="Second Decision Distribution", xlab="Second Decision")

hist(df$finaldecision, main="Final Decision Distribution", xlab="Final Decision")

library(ggplot2)
library(lattice) # Module's prompt specified "lettuce", assumed to be a typo of "lattice"
library(arules)

if (!endsWith(getwd(), "mod9")) {
  setwd("mod9")
}

# Download the data from https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Catsup.csv if not already downloaded.
download.file("https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Catsup.csv", 'catsup.csv')

#  Read the data into a data.frame object named "catsup".
catsup <- read.csv("catsup.csv", header=TRUE)
catsup <- within(catsup, rm('X'))

# Determine the best variables to plot based on best apriori rules.
catsup_rules.base <- apriori(catsup, parameter = list(support = 0.01, confidence = 0.5), appearance = list
 (default="lhs", rhs=c("choice=heinz28", "choice=heinz32", "choice=heinz41", "choice=hunts32")))
catsup_rules.lift <- catsup_rules.base[quality(catsup_rules.base)$lift > 2]
catsup_rules <- catsup_rules.lift[quality(catsup_rules.lift)$support > 0.01]
catsup_rules <- sort(catsup_rules, by=c("confidence", "lift", "support"))
inspect(catsup_rules[!duplicated(rhs(catsup_rules))])

# The two most important rules governing choice (which, unfortunately, apply to just the choice of either "heinz28"
# or of "hunts32") are:
# 1. heinz28 choices are corelated with the prices of: heinz32, heinz28, and hunts32 (at least for individuals 1
# through (and including) 103 (per the id column there are 300 individuals total)
# 2. hunts32 choices are corelated with the prices of: heinz41, heinz32, heinz28 and hunts32 for all individuals
# We could backtrack here and distinguish only between a choice of either any heinz or of hunts32 for better insight
# with other variables. However, I'm fully open to the notion that little beyond the price of the product (including
# any marketing attempts) had a meaningful impact upon the brand that an individual decided to purchase.

# Using this data, generate three types of visualization of the catsup data: one using native R graphics, one using
# ggplot2, and one using lattice.
# Native R graphics:
hist(catsup$price.hunts32, col = "red", main = "Catsup data", xlab = "Price", ylab = "Choice")

# ggplot2:
ggplot(catsup, aes(x=choice, y=price.hunts32)) +
  geom_boxplot() +
  labs(x = "Choice", y = "Price of Hunts 32") +
  ylim(0, max(catsup$price.hunts32))

# lattice:
dotplot(~catsup$price.hunts32|catsup$choice, catsup, main = "Catsup data", xlab = "Choice", ylab = "Price of Hunts 32")
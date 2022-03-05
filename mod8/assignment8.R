require(pryr)
require(ISLR)
require(boot)
library(data.table)
library(plyr)

Student <- read.table("mod8/datasetFile.txt", header=T, sep=",")
Student

student_average <- ddply(Student, "Sex", transform, Grade.Average=mean
 (Grade))

mapped_sex <- as.numeric(as.factor(Student$Sex))
sex_mapping <- data.frame(mapped_sex, Student$Sex)
mean_sex_unfactored <- mean(as.numeric(mapped_sex))
head(sex_mapping$Student.Sex[sex_mapping$mapped_sex==round(mean_sex_unfactored)])

names_with_i <- subset(student_average, grepl("i", student_average$Name, ignore.case = T))

write.table(student_average, "mod8/genderedAverage.csv", sep=",", row.names=F, col.names=T)
write.table(names_with_i, "mod8/genderedAverageNameContainsI.csv", sep=",", row.names=F, col.names=T)

library(ggplot2)
library(reshape2)

Name <- c("Jeb", "Donald", "Ted", "Marco", "Carly", "Hillary", "Berine")
ABC <- c(4, 62, 51, 21, 2, 14, 15)
CBS <- c(12, 75, 43, 19, 1, 21, 19)

election <- data.frame(Name, ABC, CBS)
election

molten_election <- melt(election, id.vars= "Name")

ggplot(molten_election, aes(Name, value, fill=variable)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(title="2016 Election Poll Results", x="Candidate", y="Rating") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), plot.title = element_text(hjust = 0.5)) +
  guides(fill=guide_legend(title = "Poll Source"))
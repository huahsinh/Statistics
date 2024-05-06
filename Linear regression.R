getwd()
setwd("/Users/hu47936/Documents/HHGithub/Kaggle_Credit Card Prediction/")

# Reference
# https://www.geeksforgeeks.org/simple-linear-regression-using-r/
# https://www.geeksforgeeks.org/multiple-linear-regression-using-r/


library(tidyverse)
library(dplyr)
d.test<- read.csv("test_data.csv")
d.train<- read.csv("train_data.csv")

# Encoding Categorical Variable


lr.md <- glm(Is.high.risk ~ Gender + Has.a.car + Has.a.property + Income + Employment.status + Marital.status + Dwelling + Age + 
               Employment.length + Family.member.count + Account.age + Has.children,data=d.input, family = binomial(link = 'logit'))

r.md <- lm(Income ~ Gender + Has.a.car + Has.a.property + Age ,data=d.train)

# Model
md <- lm(Income ~Account.age + Gender + Has.a.car  ,data=d.train)
summary(md)

# Summary Intepretation
# [Residule Section]
# It shows each observation residule, which is the difference between the actual income and predicted values.
# [Coefficient Section]
# t value: The coefficient estimate’s standard error distance from zero is measured by the t-value. 
# Pr(>|t|): The p-value indicates the probability of observing the t-statistic under the null hypothes (coefficient is zero)
# Residual standard error: This is a measure of the variability of the residuals.
# Multiple R-squared: R-squared (R²) is a measure of the goodness of fit of the model. 
#          It represents the proportion of the variance in the dependent variable that is explained by the independent variable(s)
# F-statistic: The F-statistic is used to test the overall significance of the model.

# Prediction
d.pred <- predict(md, newdata = d.test) #predicted income for each observation

# Visualization
d.train %>%
  ggplot() +
  geom_point(aes(x= Account.age, y=Income),colour = "navy") +
  geom_line(aes(x = Account.age, y = predict(md, newdata = d.train)), colour = 'purple') +
  labs(title = "Income vs Age in Training Data") + 
  theme_bw()

d.test %>%
  ggplot() +
  geom_point(aes(x= Account.age, y=Income),colour = "navy") +
  geom_line(aes(x = Account.age, y = predict(md, newdata = d.test)), colour = 'purple') +
  labs(title = "Income vs Age in Testing Data") + 
  theme_bw()



# Analysis Workflow
# 1. Encoding categorical variable 
# 2. na.omit
# 3. Correlation btw Xs -> checking multi-colinearity
numeric_columns00 <- d.train[sapply(d.train, is.numeric)]
numeric_columns <- d.train[,c("Employment.length", "Age", "Account.age", "Children.count", "Family.member.count")]
correlation_matrix <- cor(numeric_columns)
heatmap(correlation_matrix, 
        col = colorRampPalette(c("blue", "white", "red"))(20),
        main = "Correlation Heatmap")







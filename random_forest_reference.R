# Random Forest Reference - Oxford statistics file

install.packages("randomForest")
install.packages("MASS")

library(randomForest)
library(MASS)
data(Boston)

# for help
?randomForest

rf <- randomForest(x,y)
print(rf)

# can plot the predicted values (out-of-bag estimation) vs. true values by
plot( predict(rf), y)
abline(c(0,1),col=2)

# same if treating training data as new data
plot( predict(rf,newdata=x), y)

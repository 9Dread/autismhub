library(tidyverse)
library(caret)
library(rpart.plot)
library(reshape2) #cor mat
library(ggthemes)
library(randomForest)
library(janitor)
train <- read_csv("train.csv")
test <- read_csv("test.csv")
numtest <- test |> 
  select(!c(LotFrontage, MasVnrArea, GarageYrBlt, SalePrice))
numtest <- clean_names(numtrain)

numtest2 <- test |> 
  select(c(MSSubClass, OverallQual, OverallCond))
numtrain2 <- train |> 
  select(c(MSSubClass, OverallQual, OverallCond, SalePrice))

nacount <- train |> 
  summarize(across(everything(), ~ sum(is.na(.))))

numtrain <- train |> 
  select(where(is.numeric)) |> 
  select(!c(LotFrontage, MasVnrArea, GarageYrBlt))

nacount <- numtrain |> 
  summarize(across(everything(), ~ sum(is.na(.))))


tc <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = "all", returnResamp = "all")
set.seed(3333)
#parms is parameters for rpart (dec tree)
#split criteria can be "information" for info gain or "gini" for gini index
#https://tungmphung.com/information-gain-gain-ratio-and-gini-index/ for difference between those things
#
#What does tunelength do?
dtree_fit <- train(SalePrice ~ ., data = numtrain2, method = "rpart", 
                   trControl = tc, parms = list(split = "information"), tuneLength = 10)
# dtree_fit$results can see what is saved by savepreds and returnresamp in tc

#visual dtree
prp(dtree_fit$finalModel, box.palette = "Reds", tweak = 1.2)

#https://dataaspirant.com/decision-tree-classifier-implementation-in-r/ to see how to use trained model on new data

submission <- tibble(Id = 1461:2919, SalePrice = predict(dtree_fit, newdata = numtraintest))
write_csv(submission, "submission.csv")

cormat <- round(cor(numtrain), 2)
meltedCormat <- melt(cormat)
ggplot(meltedCormat, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_color_binned() +
  theme_calc()

numtrain <- clean_names(numtrain)
rfMod <- randomForest(formula = sale_price ~., data = numtrain)
which.min(rfMod$mse)
sqrt(rfMod$mse[which.min(rfMod$mse)])
plot(rfMod)
varImpPlot(rfMod)

submission <- tibble(Id = 1461:2919, SalePrice = predict(rfMod, newdata = numtest))
write_csv(submission, "submission.csv")

library(tidyverse)
library(caret)
library(rpart.plot)
train <- read_csv("train.csv")
test <- read_csv("test.csv")
numtraintest <- test |> 
  select(MSSubClass, OverallQual, OverallCond)

nacount <- train |> 
  summarize(across(everything(), ~ sum(is.na(.))))

numtrain <- train |> 
  select(where(is.numeric)) |> 
  select(MSSubClass, OverallQual, OverallCond, SalePrice)

nacount <- numtrain |> 
  summarize(across(everything(), ~ sum(is.na(.))))

tc <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = "all", returnResamp = "all")
set.seed(3333)
#parms is parameters for rpart (dec tree)
#split criteria can be "information" for info gain or "gini" for gini index
#https://tungmphung.com/information-gain-gain-ratio-and-gini-index/ for difference between those things
#
#What does tunelength do?
dtree_fit <- train(SalePrice ~ ., data = numtrain, method = "rpart", 
                   trControl = tc, parms = list(split = "information"), tuneLength = 10)
# dtree_fit$results can see what is saved by savepreds and returnresamp in tc

#visual dtree
prp(dtree_fit$finalModel, box.palette = "Reds", tweak = 1.2)

#https://dataaspirant.com/decision-tree-classifier-implementation-in-r/ to see how to use trained model on new data

submission <- tibble(Id = 1461:2919, SalePrice = predict(dtree_fit, newdata = numtraintest))
write_csv(submission, "submission.csv")
ggplot(train, mapping = aes(x = MSZoning)) +
  geom_bar()

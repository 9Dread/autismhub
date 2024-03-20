library(tidyverse)
train <- read_csv("train.csv")

nacount <- train |> 
  summarize(across(everything(), ~ sum(is.na(.))))

ggplot(train, mapping = aes(x = MSZoning)) +
  geom_bar()

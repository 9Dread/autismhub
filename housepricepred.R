library(tidyverse)
train <- read_csv("train.csv")

nacount <- train |> 
  summarize(across(everything(), ~ sum(is.na(.))))

numtrain <- train |> 
  select(where(is.numeric)) |> 
  select()

ggplot(train, mapping = aes(x = MSZoning)) +
  geom_bar()

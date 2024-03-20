require(tidyverse)
require(gganimate)
require(gifski)

vector <- 1:100
df <- tibble(x = vector, y = vector, time = rev(vector))

#M10x6 possible items
M <- tibble(i1 = sample(0:1, 10, replace=TRUE), i2 = sample(0:1, 10, replace=TRUE),
            i3 = sample(0:1, 10, replace=TRUE), i4 = sample(0:1, 10, replace=TRUE),
            i5 = sample(0:1, 10, replace=TRUE), i6 = sample(0:1, 10, replace=TRUE))

#take a database matrix and a vector of item indices
#compute the supp of an itemset
supp <- function(m) {
  im <- as_tibble(m) |> 
    mutate(sums = rowSums(across(everything())))
  sum(im$sums == (ncol(im)-1))
}

#Run Apriori algorithm on an input matrix M, return output matrix w/ k-vals, k-itemsets
#make NA vals in lower rows as strong rules are narrowed down
apr <- function(m, th) {
  L1 <- m |> 
    summarize(across(everything(), supp))
  L1
}

graph <- df |> 
  ggplot(aes(x = x, y = y)) +
  geom_point()

animation <- graph +
  transition_time(time) +
  labs(subtitle = "step: {frame_time}") +
  shadow_wake(wake_length = 0.1) #adds shadow

animate(animation, height = 500, width = 800, fps = 30, duration = 10, 
        end_pause = 60, res = 100)

#anim_save("graph.gif") to export last rendered anim to gif (set wd to workspace b4)
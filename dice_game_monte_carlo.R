##############################
# 25-May-2020 
# Description: Simple monte carlo simulation 
#   and grahpics / animations for dice and disease article: 
##############################

##### LIBRARIES ##### 
library(tidyverse)  # dplyr, ggplot2 
library(gganimate)  # animated plots 
library(ggthemes)   # themes for plots (minimal) 
library(tweenr)     # tween paths and lines 
library(transformr)


##### FUNCTIONS ##### 
# Calculate probability of winning depending on the number of rolls played 
prob_of_winning <- function(games) {
  prob_win_per_roll <- 5/6
  prob_win <- prob_win_per_roll^games
  prob_win
}

# Simulate 1 game, return binary result (1 = win, 0 = loss)
sim_game <- function (n_rolls) {
  # roll the dice 
  roll <- sample(1:6, n_rolls, replace = TRUE) 
  # If the list contains0, lose, else win 
  result <- ifelse(1 %in% roll, 0, 1)
  result
}

# Function to play B games, and compute the average probability of winning in those games
sim_prob_of_winning <- function(n_rolls) {
  n_games <- 1000
  result <- replicate(n_games, sim_game(n_rolls)) %>% mean() 
  result
}


##### MONTE CARLO SIM #####
# tibble - number of rolls per game
prob_tibble <- as.tibble(1:50) %>%    
  rename("rolls" = "value")         

# Add columns to tibble with results from simulation 
win_sim <- sapply(prob_tibble$rolls, sim_prob_of_winning) 
win_prob <- sapply(prob_tibble$rolls, prob_of_winning)
prob_tibble <- mutate(prob_tibble, 
                      simulated_wins = win_sim, 
                      probability_of_win = win_prob)
head(prob_tibble)


##### PLOT / ANIMATE #####
# Animate chart  
anim <- prob_tibble %>% ggplot() + 
  transition_reveal(along = rolls) + 
  geom_line(aes(x = rolls, y = simulated_wins)) + 
  geom_point(aes(x = rolls, y = simulated_wins)) +
  # geom_line(aes(x = rolls, y = probability_of_win)) + 
  labs(x = "Rolls per game", y = "Proportion of games won") 
# set frame rate and review animation 
animate(anim, fps = 10)
# Save as gif 
anim_save("dice_monte_carlo.gif", anim)

# Plot 
plot <- prob_tibble %>% ggplot() + 
  geom_line(aes(x = rolls, y = probability_of_win), color = "red", alpha = 1) +
  geom_line(aes(x = rolls, y = simulated_wins), alpha = 0.8) + 
  labs(y = "Proportion of games won") 
plot



# Simple Monte Carlo Simulation - Dice game 
Simple monte carlo simulation for a dice game. 

## Rules 
* Roll a single die n times 
* If it lands on any number greater than 1 on all rolls, you win 
* If it lands on 1 on any roll, you lose


## Sample use 
1,000 games simulated for each value of n by default.  

``` R 
# Tibble with Number of rolls (n)
prob_tibble <- as.tibble(1:50) %>%    
  rename("rolls" = "value")         

# Add columns to tibble with results from simulation 
win_sim <- sapply(prob_tibble$rolls, sim_prob_of_winning) 
win_prob <- sapply(prob_tibble$rolls, prob_of_winning)

# Tibble for plotting results 
prob_tibble <- mutate(prob_tibble, 
                      simulated_wins = win_sim, 
                      probability_of_win = win_prob)
```

## Visualizing result 
##### Proportion of simulated games won, for each value of n:
![](https://media.giphy.com/media/Ig9y4anAVvRZMeMmu6/giphy.gif)
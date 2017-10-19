# Exercise 4: DPLYR and flights data

# Install the nycflights13 package and read it in.  Require the dplyr package
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data.frame flights should now be accessible to you.  View it, 
# and get some basic information about the number of rows/columns
data(flights)
View(flights)

# Add a column that is the amount of time gained in the air (`arr_delay` - `dep_delay`)
flights <- flights %>% mutate(time_gained = arr_delay - dep_delay)

# Sort your data.frame desceding by the column you just created
flights <- flights %>% arrange(-time_gained)

# Try doing the last 2 steps in a single operation using the pipe operator
data(flights)
flights <- flights %>% mutate(time_gained = arr_delay - dep_delay) %>% arrange(-time_gained)

# Make a histogram of the amount of gain using the `hist` command
hist(flights$time_gained)

# On average, did flights gain or lose time?
avg.time.gained <- mean(flights[!is.na(flights$time_gained), ]$time_gained)

# Create a data.frame that is of flights headed to seatac ('SEA'), 
sea.flights <- flights %>% filter(dest == 'SEA')

# On average, did flights to seatac gain or loose time?
avg.sea.time.gained <- mean(sea.flights[!is.na(sea.flights$time_gained), ]$time_gained)


### Bonus ###
# Write a function that allows you to specify an origin, a destination, and a column of interest
# that returns a data.frame of flights from the origin to the destination and only the column of interest
## Hint: see chapter 11 section on standard evaluation
GetColumn <- function(fl.origin, fl.destination, column)  {
  return (flights %>% filter(origin == fl.origin & dest == fl.destination) %>% select(column))
}

# Retireve the air_time column for flights from JFK to SEA
jfk.sea.times <- GetColumn("JFK", "SEA", "air_time")
filtered.jfk.sea.times <- jfk.sea.times[!is.na(jfk.sea.times$air_time), ]$air_time

# What was the average air time of those flights (in hours)?  
jfk.sea.mean.time <- mean(filtered.jfk.sea.times)

# What was the min/max average air time for the JFK to SEA flights?
jfk.sea.min.time <- min(filtered.jfk.sea.times)
jfk.sea.max.time <- max(filtered.jfk.sea.times)

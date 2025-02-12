library(tidyverse)
library(lubridate)


library(ggplot2)

########################################
# READ AND TRANSFORM THE DATA
########################################

setwd("~/columbia/APMA4990/msd-homework/homework/homework_1/problem_2")

# read one month of data
trips <- read_csv('201608-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))

names(trips)


########################################
# Graph and Plotting
########################################

#plot(trips)


ggplot(trips, aes(x = "start station id", y = "tripduration")) +
  geom_point()


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)

# find the earliest and latest birth years (see help for max and min to deal with NAs)
max(trips["birth_year"], na.rm = TRUE)
min(trips["birth_year"], na.rm = TRUE)



# use filter and grepl to find all trips that either start or end on broadway

start_filter <- grepl("broadway", trips$start_station_name, ignore.case=TRUE)

end_filter <- grepl("broadway", trips$end_station_name, ignore.case=TRUE)

compare_or <- start_filter | end_filter

trips[compare_or,]

# do the same, but find all trips that both start and end on broadway
compare_and <- start_filter & end_filter

trips[compare_and, ]

# find all unique station names
select(trips, start_station_name) %>%
  unique()

select(trips, end_station_name) %>%
  unique()

# count the number of trips by gender
filter(trips, gender == "Male") %>%
  select(gender) %>%
  count()

filter(trips, gender == "Female") %>%
  select(gender) %>%
  count()


# compute the average trip time by gender
# comment on whether there's a (statistically) significant difference
select(trips, starttime, stoptime, gender) %>%
  group_by(gender) %>%
  mutate(totalTime = stoptime - starttime)

# find the 10 most frequent station-to-station trips



# find the top 3 end stations for trips starting from each start station



# find the top 3 most common station-to-station trips by gender



# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)


# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

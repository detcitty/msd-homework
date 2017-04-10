#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
# cut 201608-citibike-tripdata.csv -d , -f 3


# count the number of unique bikes
##
##

awk -F, '/New York/ { print $5 }' 201608-citibike-tripdata.csv

awk -F, '$5 ~ /Riverside/' 201608-citibike-tripdata.csv

# count the number of trips per day
##
##


# find the day with the most rides
## Sum of the number of rides for each day
## Find the maximum number of rides for each day

# find the day with the fewest rides
## Sum the number of rides for each day
## Find the smallest number of rides 
## Save the day

# find the id of the bike with the most rides
## find each bikes maximum number of rides
## Then find the maximum number
## Get that id of the bike id

# count the number of rides by gender and birth year
## Condition on male
## Count number of lines
## Condition on females
## Count number of lines
## Condition on year
## Count each of those



# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
## use regular expressions,
## split up by field by the deliminter &
## check if each of the fiels have a numeric in each of them
## if they do, count them



# compute the average trip duration
## Subtract end time minus start time
## to get trip duration
## Sum of the total trip duration
## Divide by the number of entries
##

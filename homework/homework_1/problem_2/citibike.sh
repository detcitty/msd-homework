#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
# cut 201608-citibike-tripdata.csv -d , -f 3
# Regular expressions of text are in the /{text}/
# awk -F, '/Park/ { print $0 }' 201608-citibike-tripdata.csv
# awk -F, '/New York/ { print $1} ' 201608-citibike-tripdata.csv 
# count the number of unique bikes

awk -F, '/New York/ { print $5 }' 201608-citibike-tripdata.csv

awk -F, '$5 ~ /Riverside/' 201608-citibike-tripdata.csv

# count the number of trips per day

# find the day with the most rides

# find the day with the fewest rides

# find the id of the bike with the most rides

# count the number of rides by gender and birth year

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)

# compute the average trip duration

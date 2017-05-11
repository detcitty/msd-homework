#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
# cut 201608-citibike-tripdata.csv -d , -f 3

echo "Number of unique stations"
cut 201608-citibike-tripdata.csv -d , -f 4 | sort | uniq | wc -l


cut 201608-citibike-tripdata.csv -d , -f 8 | sort | uniq | wc -l

# Regular expressions of text are in the /{text}/
# awk -F, '/Park/ { print $0 }' 201608-citibike-tripdata.csv
# awk -F, '/New York/ { print $1} ' 201608-citibike-tripdata.csv 

# count the number of unique bikes
##
##
echo 'count the number of unique bikes'
cut 201608-citibike-tripdata.csv -d , -f 12 | sort | uniq | wc -l


# awk -F, '/New York/ { print $5 }' 201608-citibike-tripdata.csv

# awk -F, '$5 ~ /Riverside/' 201608-citibike-tripdata.csv

# count the number of trips per day
##
##
echo 'Count number of trips per day'

cut 201608-citibike-tripdata.csv -d , -f 3 | awk -F'[ ]' '{count[$1]++} END {for (word in count) print word, count[word]}' | sort -k2,2nr

# find the day with the most rides
## Sum of the number of rides for each day
## Find the maximum number of rides for each day
echo 'find the day with the most rides'




# find the day with the fewest rides
## Sum the number of rides for each day
## Find the smallest number of rides 
## Save the day
echo ' find the day with the fewest rides'


# find the id of the bike with the most rides
## find each bikes maximum number of rides
## Then find the maximum number
## Get that id of the bike id

echo  'find the id of the bike with the most rides'


# count the number of rides by gender and birth year
## Condition on male
## Count number of lines
## Condition on females
## Count number of lines
## Condition on year
## Count each of those

echo  'count the number of rides by gender and birth year'


# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
## use regular expressions,
## split up by field by the deliminter &
## check if each of the fiels have a numeric in each of them
## if they do, count them


echo 'count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)'

# compute the average trip duration
## Subtract end time minus start time
## to get trip duration
## Sum of the total trip duration
## Divide by the number of entries
##

echo 'compute the average trip duration'


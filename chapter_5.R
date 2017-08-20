rm(list = ls())
gc()

setwd('d:/DS/r4ds/')

library(tidyverse)
library(nycflights13)

# exercise 1 5.2.4 ----
# 1
flights %>% 
  filter(arr_delay >= 120)
flights %>% 
  filter(dest == 'IAH' | dest == 'HOU')
flights %>% 
  filter(month %in% 7:9)
flights %>% 
  filter(arr_delay >= 120, dep_delay <= 0)
flights %>% 
  filter(dep_delay >= 60, air_time >= 30)
flights %>% 
  filter(dep_time >= 0 & dep_time <= 600)
# 2
?between
flights %>% 
  filter(between(dep_time, 0, 600))
# 3
View(flights %>% 
  filter(is.na(dep_time)))
# 4
NA ^ 0
NA | TRUE
FALSE & NA


# exercise 2 5.3.1 ----
# 1
flights %>% 
  arrange(desc(is.na(dep_time)))
# 2
flights %>% 
  arrange(desc(arr_delay))
# 3
flights %>% 
  arrange(air_time)
# 4
flights %>% 
  arrange(desc(air_time))


# exercise 3 5.4.1 ----
# 1
flights %>% 
  select(dep_time, dep_delay, arr_time, arr_delay)
flights %>% 
  select(4, 6, 7, 9)
flights %>% 
  select(one_of(c('dep_time', 'dep_delay', 'arr_time', 'arr_delay')))
flights %>% 
  select(starts_with('dep'), starts_with('arr'))
flights %>% 
  select(matches('^(dep|arr)_'))
# 2
flights %>% 
  select(dep_delay, dep_time, dep_delay)
# 3
vars <- c('year', 'month', 'day', 'dep_delay', 'arr_delay')
flights %>% 
  select(one_of(vars))
# 4
select(flights, contains('TIME', ignore.case = F))





rm(list = ls())
gc()

setwd('d:/DS/r4ds/')

library(tidyverse)

# exercise 1 3.2.4 ----
ggplot(data = mpg)
dim(mpg)
?mpg
# drv - f = front-wheel drive, r = rear wheel drive, 4 = 4wd
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))


# exercise 2 3.3.1 ----
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = 'blue')) # incorrect
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = 'blue') # correct
str(mpg)
?mpg
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty, size = displ))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = displ))
?geom_point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty), stroke = 1, shape = 21)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty, color = displ < 5), size = 2)


# exercise 3.5.1 ---
# 1
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ displ, nrow = 2)
# 2
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)
# 3
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# 4
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 3)












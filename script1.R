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


# exercise 3 3.5.1 ---
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


# exercise 4 3.6.1
# 1
geom_line()
geom_boxplot()
geom_histogram()
geom_area()
# 2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = F)
# 3
ggplot(data = mpg, mapping = aes(x = displ, y = cty, col = drv)) +
  geom_point(show.legend = T)
# 4
ggplot(data = diamonds, mapping = aes(x = carat, y = price, col = cut)) +
  geom_point() +
  geom_smooth(se = F)
# 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# 6
g <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy))
g + geom_point() + geom_smooth(se = F)
g + geom_point() + geom_smooth(aes(group = drv), se = F)
g + geom_point(aes(col = drv)) + geom_smooth(aes(col = drv), se = F)
g + geom_point(aes(col = drv)) + geom_smooth(se = F)
g + geom_point(aes(col = drv)) + geom_smooth(aes(linetype = drv), se = F)
g + geom_point(aes(col = drv), shape = 16, size = 2)



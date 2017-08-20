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


# exercise 5 3.7.1
# 1
?stat_summary
# original
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
# my plot
diamonds %>%
  group_by(cut) %>%
  summarise(min = min(depth), max = max(depth), depth = median(depth)) %>%
  ggplot(aes(x = cut, y = depth)) +
  geom_pointrange(aes(ymin = min, ymax = max))
# 2
?geom_col
ggplot(data = diamonds, mapping = aes(x = cut, y = carat)) +
  geom_col() # data value
ggplot(data = diamonds, mapping = aes(x = cut)) +
  geom_bar() # count
# 3
library(rvest)
h <- read_html('http://ggplot2.tidyverse.org/reference/index.html#section-layer-geoms')
res <- html_nodes(h, 'td:nth-child(1) p') %>% 
  html_text() %>% 
  stringr::str_trim()
fin.res <- res[grepl('stat', res)][grepl('geom_', res[grepl('stat', res)])]
fin.res
# 4
?stat_smooth
# method = "auto", formula = y ~ x, se = TRUE, n = 80, span = 0.75, fullrange = FALSE, level = 0.95
# 5
# incorrect
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
# correct
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group = color))




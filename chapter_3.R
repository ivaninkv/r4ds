rm(list = ls())
gc()

setwd('d:/DS/r4ds/')

library(tidyverse)
library(gridExtra)

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist = NULL, file, cols = 1, layout = NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots == 1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


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


# exercise 4 3.6.1 ----
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


# exercise 5 3.7.1 ----
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


# exercise 6 3.8.1 ----
# 1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()
# 2
rnd <- 0.95
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter(width = rnd, height = rnd, size = 2)
# 3
p1 <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()
p2 <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()
multiplot(p1, p2, cols = 2) # first variant
grid.arrange(p1, p2, ncol = 2) # second variant
# 4
?geom_boxplot
ggplot(data = mpg, mapping = aes(x = drv, y = displ, col = class)) +
  geom_boxplot()


# exercise 7 3.9.1 ----
# 1
diamonds %>% ggplot(aes(clarity)) +
  geom_bar(aes(fill = cut), position = 'fill') +
  #coord_flip() +
  coord_polar()
# 2
?labs
diamonds %>% ggplot(aes(clarity)) +
  geom_bar(aes(fill = cut), position = 'fill', width = 1) +
  coord_polar() +
  labs(y = 'test')
# 3
?coord_map
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap() # faster
  #coord_map() # approximately spherical
# coord_map projects a portion of the earth, which is approximately spherical,
# onto a flat 2D plane using any projection defined by the mapproj package.
# Map projections do not, in general, preserve straight lines,
# so this requires considerable computation.
# coord_quickmap is a quick approximation that does preserve straight lines.
# It works best for smaller areas closer to the equator.
# 4
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()








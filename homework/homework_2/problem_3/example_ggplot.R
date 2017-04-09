library(tidyverse)
library(ggplot2)

# Set color by cond
ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1)

# Same, but with different colors and add regression lines
ggplot(dat, aes(x=xvar, y=yvar, color=cond)) +
    geom_point(shape=1) +
    scale_colour_hue(l=50) + # Use a slightly darker palette than normal
    geom_smooth(method=lm,   # Add linear regression lines
                se=FALSE)    # Don't add shaded confidence region

# Extend the regression lines beyond the domain of the data
ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1) +
    scale_colour_hue(l=50) + # Use a slightly darker palette than normal
    geom_smooth(method=lm,   # Add linear regression lines
                se=FALSE,    # Don't add shaded confidence region
                fullrange=TRUE) # Extend regression lines


# Set shape by cond
ggplot(dat, aes(x=xvar, y=yvar, shape=cond)) + geom_point()

# Same, but with different shapes
ggplot(dat, aes(x=xvar, y=yvar, shape=cond)) + geom_point() +
    scale_shape_manual(values=c(1,2))  # Use a hollow circle and triangle

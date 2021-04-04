# Shiny application of the PyCon data visualization tool
# Thanks reader for following up on this 
# Let write some code

# load up a couple of packages we'll use tu build up the application
library(shiny)
library(tidyverse)
library(lubridate)
library(colourpicker)
library(DT)
library(plotly)
library(gridExtra)

# importing the data with the read_csv function
# my channel verus James Karanu's channel 
df <- read_csv('~/data/yt_date.csv') 
df2 <- read_csv('~/data/exotic_yt_date.csv')

# make columns for the name of the channel
# Potential source of input requires nrow(df), nrow(df2)
# for different channels apart from these ones
# template: rep("add name of your channel", nrow(df)) and rep("add name of your channel", nrow(df2))
channel_name <- rep("Sliceace channel", 573)
channel_name2 <- rep("James channel", 1526)

# bind this column to the df and df2 datasets
df <- df %>% mutate(channel1 = channel_name)
df2 <- df2 %>% mutate(channel2 = channel_name2)

# identifying the columns of interest 
# date and any other variables that follow which i presume will be in the y axis

# starter code for the plot
p1 <- ggplot(df, aes(date, subscribers_gained)) + geom_line() + geom_area(fill = "red") +
  xlab("Date") + ylab("Views") + labs(caption = "Sliceace channel") + scale_color_brewer()

# Using pipes
p2 <- df2 %>% ggplot(aes(date, subscribers_gained)) + geom_line() + geom_area(fill = "green") +
  xlab("Date") + ylab("Views") + labs(caption = "James channel") + scale_color_brewer()


# joining the plots to appear side by side
grid.arrange(p1,p2, ncol = 2)

# Make a function that  will allow you to call a different variable in the y axis 
# adding ggplotly functionality
# redo exercise to fix this
# fix the title or add a subtitle to distinguish the plots
choose_y_axis_plot <- function(dataframe, yaxis = readline(), dataframe2, yaxis2 = readline()) {
  # define variable p1 with ggplot specifications for the first plot 
  p3 <- ggplot(dataframe, aes(date, yaxis, group = channel)) + geom_line() + geom_area(fill = "red") +
    xlab("Date") + ylab("Views")
  
  # for the second plot 
  p4 <- ggplot(dataframe2, aes(date, yaxis2, group = channel2)) + geom_line() + geom_area(fill = "green") +
    xlab("Date") + ylab("Views")
  
  # joining the plots together with regular ggplot2
  
  # convert the plots to plotly plots this is how it's done 
  plot_p1 <- ggplotly(p3)
  plot_p2 <- ggplotly(p4)
  
  # arrange the two plots to appear side by side
  subplot(plot_p1, plot_p2, titleX = TRUE, titleY = TRUE, margin = 0.05)
}

# call to the function that allows you to change you axis label
# In the shiny app the user will have to this on their own unfortunately
# change the labels to something the users can easily toggle
choose_y_axis_plot(dataframe = df, yaxis = df$views, df2, df2$views)

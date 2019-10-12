# Plans
# make a Line and area plot like above
# I'll need textinput for the user to enter the column that they are interested in and update
# the title as the column updates
# the labs column will also require a textinput to relabel the y-axis
# A code book tab to show the user what the variables mean 
# subsetted plot to compare users that are independent of each other
# a line of best fit as well include it 
# A side bar with the names of the channels, can they be reactive
library(shiny)
library(tidyverse)
library(plotly)
library(DT)

# load data 
df <- read_csv('/Users/aoi-rain/Documents/YT_dataviz/data/yt_date.csv') 
df2 <- read_csv('/Users/aoi-rain/Documents/YT_dataviz/data/exotic_yt_date.csv')

# make category columns for this dataset
channel_name <- rep("Sliceace channel", 573)
channel_name2 <- rep("James channel", 1526)

# bind this column to the df and df2 datasets
df <- df %>% mutate(channel1 = channel_name)
df2 <- df2 %>% mutate(channel2 = channel_name2)


# Define UI for application: consists of various things the user will interract with
ui <- fluidPage(
   sidebarLayout(
   # Application title
   h1("Interractive YT data viz tool"),
   br()

   # Sidebar that takes various inputs into consideration 
))

# Define server logic required to draw plot and the interractive dataframe
server <- function(input, output) {
  
}
# Run the application 
shinyApp(ui = ui, server = server)


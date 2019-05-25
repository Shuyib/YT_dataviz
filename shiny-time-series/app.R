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
df <- read_csv('data/yt_date.csv') 
df2 <- read_csv('data/exotic_yt_date.csv')

# make columns for the name of the channel
# Potential source of input requires nrow(df), nrow(df2)
# for different channels apart from these ones
# template: rep("add name of your channel", nrow(df)) and rep("add name of your channel", nrow(df2))
channel_name <- rep("Sliceace", 573)
channel_name2 <- rep("James channel", 1526)

# bind this column to the df and df2 datasets
df <- df %>% mutate(channel = channel_name)
df2 <- df2 %>% mutate(channel = channel_name2)

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
  p1 <- ggplot(dataframe, aes(date, yaxis, group = channel)) + geom_line() + geom_area(fill = "red") +
   xlab("Date") + ylab("Views")
  
  # for the second plot 
  p2 <- ggplot(dataframe2, aes(date,yaxis2, group = channel_name2)) + geom_line() + geom_area(fill = "green") +
  xlab("Date") + ylab("Views")
  
  # joining the plots together with regular ggplot2
  
  # convert the plots to plotly plots this is how it's done 
  plot_p1 <- ggplotly(p1)
  plot_p2 <- ggplotly(p2)
  
  # arrange the two plots to appear side by side
  subplot(plot_p1, plot_p2, titleX = TRUE, titleY = TRUE, margin = 0.05)
}

# call to the function that allows you to change you axis label
# In the shiny app the user will have to this on their own unfortunately
# change the labels to something the users can easily toggle
choose_y_axis_plot(df, df$views, df2, df2$views)
 
# Plans
# make a Line and area plot like above
# I'll need textinput for the user to enter the column that they are interested in and update
# the title as the column updates
# the labs column will also require a textinput to relabel the y-axis
# A code book tab to show the user what the variables mean 
# subsetted plot to compare users that are independent of each other
# a line of best fit as well include it 
# A side bar with the names of the channels, can they be reactive


# Define UI for application: consists of various things the user will interract with
ui <- fluidPage(
   
   # Application title
   h1("Interractive YT data viz tool"),
   
   # Sidebar that takes various inputs into consideration 
   sidebarLayout(
      sidebarPanel(
         selectInput(inputId = "",label = "",choices = "")),
         colourInput(inputId = "colour", label = "Choose another line color", value = "blue"),
         textInput(inputId = "yaxis", label = "Label Y axis" , value = "subscribers")))
      # placeholder to handle different inputs
      #selectInput("","", choices = "",
      #           selected = "")))
      # placeholders to change dot and line transparency
      #sliderInput(inputId = "alpha1", label = "Line Transparency", min = 0, max = 1, value = 0.5),
      #sliderInput(inputId = "alpha2", label = "Dot Transparency", min = 0, max = 1, value = 0.5),
      #checkboxInput("fit", "Add line of best fit", FALSE),
      
      
      #br(),
      # "by",
         #img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png",
          #   height = "30px"))),
      
   # what appears in the main panel of the plot   
   # placeholder for table output
   #mainPanel(
     #plotlyOutput("plot"),
     #downloadButton(outputId = "download_data", label = "Download data"),
     #DT::dataTableOutput("table"))
   
#)


# Define server logic required to draw a histogram
server <- function(input, output) {}
# Run the application 
shinyApp(ui = ui, server = server)


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

# identifying the columns of interest 
# date and any other variables that follow which i presume will be in the y axis

# starter code for the plot
ggplot(df, aes(date, subscribers_gained)) + geom_area() + geom_line()

# Using pipes
df %>% ggplot(aes(date, subscribers_gained)) + geom_line() + geom_area()

# Make a function that will allow you to call a different variable in the y axis 
# adding ggplotly functionality
# redo exercise to fix this
choose_y_axis_plot <- function(dataframe, yaxis = readline(), dataframe2, yaxis2 = readline()) {
   p1 <- ggplot(dataframe, aes(date, yaxis)) + geom_line() + geom_area()
   p2 <- ggplot(dataframe2, aes(date,yaxis2)) + geom_line() + geom_area()
   plot_p1 <- ggplotly(p1)
   plot_p2 <- ggplotly(p2)
   grid.arrange(plot_p1, plot_p2, ncol=2)
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


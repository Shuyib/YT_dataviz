# Plans
# make a Line and area plot like above
# I'll need textinput for the user to enter the column that they are interested in and update
# the title as the column updates
# the labs column will also require a textinput to relabel the y-axis
# A code book tab to show the user what the variables mean 
# subsetted plot to compare users that are independent of each other
# a line of best fit as well include it 
# A side bar with the names of the channels, can they be reactive
# use this to make the application 
# guide https://stackoverflow.com/questions/34384907/how-can-put-multiple-plots-side-by-side-in-shiny-r
# first guide https://drive.google.com/drive/u/2/search?q=selectInput
library(shiny)
library(tidyverse)
library(plotly)
library(DT)

# load data 
df <- read_csv('/Users/aoi-rain/Documents/YT_dataviz/data/yt_date.csv') 
df2 <- read_csv('/Users/aoi-rain/Documents/YT_dataviz/data/exotic_yt_date.csv')

# make category columns for this dataset
# change this into something you can use someother person's channel
# this could be text input column to export 
channel_name <- rep("Sliceace channel", nrow(df))
channel_name2 <- rep("James channel", nrow(df2))

# bind this column to the df and df2 datasets
df <- df %>% mutate(channel1 = channel_name) 
df2 <- df2 %>% mutate(channel2 = channel_name2) 

# change the columns into factors
df$channel1 <- as.factor(df$channel1)
df2$channel2 <- as.factor(df2$channel2)

# Define UI for application: consists of various things the user will interract with
ui <- fluidPage(
   # Application title
   h1("Interractive YT data viz tool"),
   br(),
  ui <- fluidPage(
    # simply used for arranging inputs in a panel which you can see in the application
    sidebarLayout(position = "left",
      sidebarPanel("sidebar panel",
                   textInput(inputId = "title", label = "Title", value = "Comparing two YouTube channels"),
                   textInput("yaxis", "Label Y axis", "Views"),
                   textInput("xaxis", "Label X axis", "Date"),
                   dateRangeInput(inputId = "daterange",label = "Date",start = "2011-01-01", end = "2017-12-31")),
      # placeholder to input
      #sliderInput(inputId = "alpha1", label = "Line Transparency", min = 0, max = 1, value = 0.5),
      #sliderInput(inputId = "alpha2", label = "Dot Transparency", min = 0, max = 1, value = 0.5),
      #checkboxInput("fit", "Add line of best fit", FALSE),
      
      #h4("Built with",
     #    img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
      #   "by",
      #   img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png",
      #       height = "30px"))),
    
      mainPanel(h3(textOutput("caption")),
                plotOutput("mpgPlot"))
                #downloadButton(outputId = "download_data", label = "Download data"),
                #DT::dataTableOutput("table"))
  )))

# Define server logic required to draw plot and the interractive dataframe
server <- function(input, output) {
  
}
# Run the application 
shinyApp(ui = ui, server = server)


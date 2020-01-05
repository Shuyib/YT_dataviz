# Plans: 
# I'll need textinput for the user to enter the column that they are interested in and update
# the title as the column updates
# the labs column will also require a textinput to relabel the y-axis
# A code book tab to show the user what the variables mean 
# subsetted plot to compare users that are independent of each other
# a line of best fit as well include it 
# A side bar with the names of the channels, can they be reactive?
# A function to upload data independently 

library(shiny)
library(tidyverse)
library(lubridate)
library(colourpicker)
library(DT)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("YT Data visualization application Sliceace channel versus Other channel"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         #sliderInput("bins",
          #           "Number of bins:",
          #           min = 1,
           #          max = 50,
            #         value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         #plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
#   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
#      x    <- faithful[, 2] 
#      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#   })
}

# Run the application 
shinyApp(ui = ui, server = server)


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


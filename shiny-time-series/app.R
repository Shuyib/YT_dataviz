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
library(gridExtra)

# load data 
df <- read_csv('/Users/aoi-rain/Documents/YT_dataviz/data/yt_date.csv') 
df2 <- read_csv('/Users/aoi-rain/Documents/YT_dataviz/data/exotic_yt_date.csv')

# make category columns for this dataset
# change this into something you can use someother person's channel
# this could be text input column to export 
channel_name <- rep("Sliceace channel", nrow(df))
channel_name2 <- rep("James channel", nrow(df2))

# bind this column to the df and df2 datasets
df <- df %>% mutate(channel = channel_name) 
df2 <- df2 %>% mutate(channel = channel_name2) 

# bind the dataframes together
df3 <- bind_rows(df,df2)
df3$channel <- as.factor(df3$channel)


# change the columns into factors
df$channel <- as.factor(df$channel)
df2$channel <- as.factor(df2$channel)

# get all the columns for both channels
#new_df <- df %>% select(-date, -channel1)
#new_df2 <- df2 %>% select(-date, -channel2)
#col_names_df <- names(new_df)
#col_names_df2 <- names(new_df2)

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
                   radioButtons("col_name", "Column name:",
                                c("Watch time minutes" = "watch_time_minutes",
                                  "Views" = "views",
                                  "Youtube Red Views" = "youtube_red_views",
                                  "Average View Duration" = "average_view_duration")),
                   selectInput("columns", "Columns", names(df), multiple = FALSE),
                   dateRangeInput(inputId = "daterange",label = "Date",start = "2011-01-01", end = "2017-12-31"),
      # placeholder to input
      sliderInput(inputId = "alpha1", label = "Line Transparency", min = 0, max = 1, value = 0.5),
      checkboxInput("fit", "Add line of best fit", FALSE),
      
      br(),
      h4("Built with",
     img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
      "by",
      img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png",
      height = "30px"))),
    
      mainPanel(plotOutput("lineplot"))
                #downloadButton(outputId = "download_data", label = "Download data"),
                #DT::dataTableOutput("table"))
  )))

# Define server logic required to draw plot and the interractive dataframe
# needs a restructured dataframe a short one or find a way to change inputs effectively
# try using a dropdown
# used this https://stackoverflow.com/questions/39798042/r-shiny-how-to-use-multiple-inputs-from-selectinput-to-pass-onto-select-optio
server <- function(input, output) {
  
  dataframe <- reactive({
  data <- df
  })
  
  dataframe2 <- reactive({
    data <- df2
  })
  
  dataframe3 <- reactive({
    data <- df3
  })
  
  
  output$lineplot <- renderPlot({
    
    data <- dataframe()
    data2 <- dataframe2()
    data3 <- dataframe3()
    
    p1 <- ggplot(data3, aes(date, views)) + geom_line(alpha = input$alpha1)  +
    facet_grid( ~ channel)
    
    p2 <- data2 %>% ggplot(aes(date, views)) + geom_line() + geom_area(fill = "green") +
    xlab("Date") + ylab("Views") + labs(caption = "James channel") 
    
    if (input$fit) {
      p1 <- p1 + geom_smooth(method = "lm")
    }
    
    
    if (input$fit) {
      p2 <- p2 + geom_smooth(method = "lm")
    }
    p1
    p2
    # joining the plots to appear side by side
    grid.arrange(p1,p2, ncol = 2)
    
  })
}
# Run the application 
shinyApp(ui = ui, server = server)


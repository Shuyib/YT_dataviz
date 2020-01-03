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
library(shinythemes)

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

# replace the underscores with a space instead
names(df) <- str_replace_all(names(df),"_", " ")
names(df2) <- str_replace_all(names(df2),"_", " ")

# transform the dataset into a short format
df_transformed <- gather(df, "channel_properties", "count", 2:41, factor_key = TRUE, na.rm = TRUE)
df2_transformed <- gather(df2, "channel_properties", "count", 2:54,factor_key = TRUE, na.rm = TRUE)



# Define UI for application: consists of various things the user will interract with
ui <- fluidPage(
   # Application title
   h1("Interractive YT data viz tool"),
   br(),
  ui <- fluidPage(
    themeSelector(),
    # simply used for arranging inputs in a panel which you can see in the application
    sidebarLayout(position = "left",
      sidebarPanel(
                   selectInput("property","Channel property", choices = levels(df_transformed$channel_properties), selected = "views"),
                   selectInput("property2","Second channel property", choices = levels(df2_transformed$channel_properties), selected = "views"),
      
      # placeholder to input
      sliderInput(inputId = "alpha1", label = "Line Transparency", min = 0, max = 1, value = 0.5),
      checkboxInput("fit", "Add line of best fit", FALSE),
      
      br(),
      h4("Built with",
     img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
      "by",
      img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png",
      height = "30px"))),
    
      mainPanel("Comparing properties of two YT channels Sliceace (left) and James channel (right) from 2011 to 2017", 
                tabsetPanel(type = "tabs",
                            tabPanel("Plot", plotlyOutput("lineplot")),
                            tabPanel("YT channel", DT::dataTableOutput("table")),
                            tabPanel("Another YT channel", DT::dataTableOutput("table2")),
                        
                downloadButton(outputId = "sliceace_data", label = "channel1 data"),
                downloadButton(outputId = "james_data", label = "channel2 data"))
     
                #downloadButton(outputId = "download_data", label = "Download data"),
                #)
  ))))

# Define server logic required to draw plot and the interractive dataframe
# needs a restructured dataframe a short one or find a way to change inputs effectively
# try using a dropdown
# used this https://stackoverflow.com/questions/39798042/r-shiny-how-to-use-multiple-inputs-from-selectinput-to-pass-onto-select-optio
server <- function(input, output) {
  
  dataframe <- reactive({
  data <- df_transformed %>% filter(channel_properties == input$property) 
  })
  
  dataframe2 <- reactive({
    data2 <- df2_transformed %>% filter(channel_properties == input$property2)
  })
  
  
  output$lineplot <- renderPlotly({
    
    data <- dataframe()
    data2 <- dataframe2()
    
    p1 <- ggplot(data, aes(x = date, y = count)) + geom_line(alpha = input$alpha1) +  geom_area(fill = "yellow") + xlab("Date") +
      ylab(input$property) + labs(caption = data$channel) 
    
    p2 <- data2 %>% ggplot(aes(date, count)) + geom_line(input$alpha) + geom_area(fill = "green") +
    xlab("Date") + ylab(input$property2) + labs(caption = data2$channel) 
    
    if (input$fit) {
      p1 <- p1 + geom_smooth(method = "lm")
    }
    
    
    if (input$fit) {
      p2 <- p2 + geom_smooth(method = "lm")
    }
    p1 
    
    p2
    # joining the plots to appear side by side
    #grid.arrange(p1,p2, ncol = 2)
    
    # convert the plots to plotly plots this is how it's done 
    plot_p1 <- ggplotly(p1)
    plot_p2 <- ggplotly(p2)
    
    # arrange the two plots to appear side by side
    subplot(plot_p1, plot_p2, titleX = TRUE, titleY = TRUE, margin = 0.1)
    
  })
  output$table <- DT::renderDataTable({
    data <- dataframe()
    
  })
  # download filtered data from the functions above
  output$sliceace_data <- downloadHandler(
    # The downloaded file is named "filtered_data.csv"
    filename = "filtered_data1.csv",
    content = function(file) {
      data <- dataframe()
      write.csv(data, file, row.names = FALSE)}
  )
  
  output$table2 <- DT::renderDataTable({
    data2 <- dataframe2()
    
  })
  
 
  # download filtered data from the functions above
  output$james_data <- downloadHandler(
    # The downloaded file is named "filtered_data.csv"
    filename = "filtered_data2.csv",
    content = function(file) {
      data2 <-  dataframe2()
      write.csv(data2, file, row.names = FALSE)}
  )
  
}
# Run the application 
shinyApp(ui = ui, server = server)


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

library(shiny)
library(tidyverse)
library(plotly)
library(DT)
library(shinythemes)

# load data 
df <- read_csv("../data/yt_date.csv") 
df2 <- read_csv("../data/exotic_yt_date.csv")


# label the dataset for each channel
channel_name <- rep("Sliceace channel", nrow(df))
channel_name2 <- rep("James channel", nrow(df2))

# bind these columns to the df and df2 datasets
df <- df %>% mutate(channel = channel_name) 
df2 <- df2 %>% mutate(channel = channel_name2) 

# replace the underscores with a space instead
# Easily readable by the user
names(df) <- str_replace_all(names(df),"_", " ")
names(df2) <- str_replace_all(names(df2),"_", " ")

# transform the dataset into a short format
# alternatively you could try using the aes_string to map the x and y coordinates of the plot
df_transformed <- gather(df, "channel_properties", "count", 2:41, factor_key = TRUE, na.rm = TRUE)
df2_transformed <- gather(df2, "channel_properties", "count", 2:54,factor_key = TRUE, na.rm = TRUE)



# Define UI for application: consists of various things the user will interract with
# in the shiny application
ui <- fluidPage(
   # Application title in HTML
   h1("Interractive YT data viz tool"),
   br(), # line break
  # simply used for arranging inputs in a panel which you can see in the application 
  ui <- fluidPage(
    themeSelector(), # controls theme changes dropdown
    sidebarLayout(position = "left",
      sidebarPanel(
      # placeholders to handle input typed in by the user
      selectInput(inputId = "property", label = "Channel property", choices = levels(df_transformed$channel_properties), selected = "views"),
      selectInput(inputId = "property2", label = "Second channel property", choices = levels(df2_transformed$channel_properties), selected = "views"),
      
      # placeholder to input
      sliderInput(inputId = "alpha1", label = "Line Transparency", min = 0, max = 1, value = 0.5),
      checkboxInput(inputId = "fit", label = "Add line of best fit", value = FALSE),
      
      br(),
      # more HTML to draw the logos in the left panel
      h4("Built with",
     img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
      "by",
      img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png",
      height = "30px"))),
     
     # what appears in the main panel of the layout   
     # Title of plot text
     # tabs to hold the plot, data tables and references
      mainPanel("Comparing properties of two YT channels Sliceace (left) and James channel (right) from 2011 to 2017", 
                tabsetPanel(type = "tabs",
                            tabPanel("Plot", plotlyOutput("lineplot")),
                            tabPanel("YT channel", DT::dataTableOutput("table")),
                            tabPanel("Another YT channel", DT::dataTableOutput("table2")),
                            tabPanel("Codebook", 
                                     br(),
                                     tags$a("Codebook the description of columns", href = "https://github.com/Shuyib/YT_dataviz/blob/master/codebook.txt")
                            ),
                            tabPanel("Reference",
                                    br(),
                                    tags$a("Dean Attali course on datacamp", href = "https://www.datacamp.com/courses/building-web-applications-in-r-with-shiny-case-studies"), 
                                    br(),
                                    tags$a("Mine Çentikaya Rundel courses", href = "https://resources.rstudio.com/webinars/intro-to-shiny?prevItm=NaN&prevCol=&ts=258978"),
                                    br(),
                                    tags$a("Mine's Github", href = "https://github.com/mine-cetinkaya-rundel"),
                                    br(),
                                    tags$a("Plotly documentation", href = "https://plot.ly/r/"),
                                    br(),
                                    tags$a("Tidyverse documentation (dplyr, stringr, readr, ggplot)", href = "https://www.tidyverse.org/"),
                                    br(),
                                    tags$a("Shiny documentation", href = "https://shiny.rstudio.com/"))
                           )
                                            
                      
  ))))

# Define server logic required to draw plot and the interractive dataframe
server <- function(input, output) {
  
  # reactive object to reduce code duplication
  dataframe <- reactive({
  
  # take the imported dataframe then change it based on user input in the dropdown in the UI
  data <- df_transformed %>% filter(channel_properties == input$property) 
  })
  
  dataframe2 <- reactive({
    data2 <- df2_transformed %>% filter(channel_properties == input$property2)
  })
  
  
  # defining plot makeup with plotly functionality
  output$lineplot <- renderPlotly({
    
  # reactive object that reduces code duplication as well as speeding up my code  
  data <- dataframe()
  data2 <- dataframe2()
  
  # defining plots that appear in the UI
  # I think if the columns were in another form  without transformation aes_string would be more useful
  p1 <- ggplot(data, aes(x = date, y = count)) + geom_line(alpha = input$alpha1) +  geom_area(fill = "yellow") + xlab("Date") +
      ylab(input$property) + labs(caption = data$channel) 
    
  p2 <- data2 %>% ggplot(aes(date, count)) + geom_line(input$alpha) + geom_area(fill = "green") +
      xlab("Date") + ylab(input$property2) + labs(caption = data2$channel) 
    
  # add functionality for linear modelling with a 95% confidence interval
  # It is applied to both plots as opposed to one.
    if (input$fit) {
      p1 <- p1 + geom_smooth(method = "lm")
    }
    
    
    if (input$fit) {
      p2 <- p2 + geom_smooth(method = "lm")
    }
  
    # call the plot objects
    p1 
    
    p2
    
    # convert the plots to plotly plots this is how it's done 
    plot_p1 <- ggplotly(p1)
    plot_p2 <- ggplotly(p2)
    
    # arrange the two plots to appear side by side
    subplot(plot_p1, plot_p2, titleX = TRUE, titleY = TRUE, margin = 0.1)
    
  })
  
  # show the resulting dataframe after tickering with the dropdown
  output$table <- DT::renderDataTable({
    data <- dataframe()
    
  })
  
  output$table2 <- DT::renderDataTable({
    data2 <- dataframe2()
    
  })
  
}
# Run the application 
shinyApp(ui = ui, server = server)


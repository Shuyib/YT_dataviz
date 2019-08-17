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
   h1("Interractive YT data viz tool")
   # Sidebar that takes various inputs into consideration 
)

# Define server logic required to draw plot and the interractive dataframe
server <- function(input, output) {}
# Run the application 
shinyApp(ui = ui, server = server)


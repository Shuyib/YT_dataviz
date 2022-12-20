# create a Docker image for the shiny app
FROM rocker/shiny:latest

# install R packages
RUN R -e "install.packages('DT')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('shinythemes')"
RUN R -e "install.packages('shinydashboard')"
RUN R -e "install.packages('shinyjs')"
RUN R -e "install.packages('shinyBS')"
RUN R -e "install.packages('shinyWidgets')"
RUN R -e "install.packages('shinydashboardPlus')"

# copy the app to the image
RUN mkdir /root/shiny
COPY . /root/shiny/

# select port
EXPOSE 3838

# run app
CMD ["R", "-e", "shiny::runApp('/root/shiny')"]


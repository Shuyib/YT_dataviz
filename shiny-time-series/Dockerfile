# create a Docker image for the shiny app
FROM rocker/shiny:3.6.3

# install R packages required for the app
# chain the RUN commands to reduce the number of layers
RUN R -e "install.packages('tidyverse', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('DT', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shiny', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shinythemes', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shinyjs', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shinyBS', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shinyWidgets', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('shinydashboardPlus', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('plotly', repos='http://cran.us.r-project.org')"

# Set working directory
WORKDIR /root/shiny

# copy contents of app into container and create data directory
# make a volume in the data directory
COPY . /root/shiny/

# create data directory
RUN mkdir data

# copy CSVs into data
COPY *.csv data/

# create volume in data directory
VOLUME [ "data/" ]

# select port
EXPOSE 3838

# run app
CMD ["R", "-e", "shiny::runApp('/root/shiny', port=3838, host='0.0.0.0')"]
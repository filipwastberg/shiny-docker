# Example shiny app docker file
# https://blog.sellorm.com/2021/04/25/shiny-app-in-docker/

# get shiny server and R from the rocker project
FROM rocker/shiny:4.0.5

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev
  
# install R packages required 
# Change the packages list to suit your needs
RUN R -e 'install.packages(c(\
              "shiny", \
              "shinydashboard", \
              "ggplot2" \
            ), \
            repos="https://packagemanager.rstudio.com/cran/__linux__/jammy/2023-04-07"\
          )'


# copy the app directory into the image
COPY ./shiny-app/* /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/', host = '0.0.0.0', port = 3838)"]
# run app
#CMD ["/usr/bin/shiny-server"]
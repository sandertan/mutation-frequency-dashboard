FROM rocker/shiny-verse

# copy the app to the image
RUN mkdir /srv/shiny-server/mf
COPY . /srv/shiny-server/mf/

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/mf/', 3838, host='0.0.0.0')"]

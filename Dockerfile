FROM rocker/shiny-verse

# copy the app to the image
RUN mkdir /srv/shiny-server/mf
COPY . /srv/shiny-server/mf/

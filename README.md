# Mutation Frequency Dashboard
Mutation Frequency Dashboard to display how often specific genes are mutated among different types of cancers in patients that are profiled in the TCGA PanCancer project.

Data was extracted from cBioPortal (www.cbioportal.org).

## Running Shiny in Docker
To run this Shiny app locally in Docker, build it first, and then run it by exposing port 3838.
```bash
docker build -t shiny-mf .
docker run --rm -p 3838:3838 shiny-mf
```

It should now be running at `localhost:3838`.

## Running Shiny via ShinyProxy in Docker
ShinyProxy runs it Shiny dashboards in Docker containers. This approach also runs ShinyProxy itself in Docker. Therefore, the `docker.sock` from the host system is mounted to the container.
```bash
docker network create sp-net
docker build . -t shinyproxy-mf
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --net sp-net \
  -p 8080:8080 \
  shinyproxy-mf
```
It should now be running at `localhost:8080` using the following usernames and password:
- User/PW: `jeff`/`password`
- Admin/PW: `jack`/`password`

This setup is based on the examples from the official ShinyProxy repository:
https://github.com/openanalytics/shinyproxy-config-examples/tree/master/02-containerized-docker-engine

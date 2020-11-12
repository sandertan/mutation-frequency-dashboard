# Mutation Frequency Dashboard
Mutation Frequency Dashboard to display how often specific genes are mutated among different types of cancers in patients that are profiled in the TCGA PanCancer project.

Data was extracted from cBioPortal (www.cbioportal.org).

## Docker setup
To run this Shiny app locally in Docker, build it first, and then run it by exposing port 3838.
```bash
docker build -t shiny-mf .
docker run --rm -p 3838:3838 shiny-mf
```

It should now be running at `localhost:8080`.

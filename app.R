library(shiny)
library(tidyr)
library(ggplot2)

# Prepare input data
mf_input <- read.table("mutation_frequencies.tsv", sep='\t', header=T)
mf_input <- mf_input[, colSums(is.na(mf_input)) != nrow(mf_input)]

colnames(mf_input)[1] <- 'Gene'
mf_melted <- pivot_longer(mf_input,
                    cols = -c(Gene),
                    names_to = 'cancer_type',
                    values_to = 'mutation_frequency')

# Define UI for app that draws a bar graph ----
ui <- fluidPage(

  # App title ----
  titlePanel("Mutation frequency per gene per cancer type"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Selector for choosing dataset ----
      selectInput(inputId = "gene",
                  label = "Choose a gene:",
                  choices = mf_input$Gene,
                  selected = "TP53"
                  )
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "mf_bargraph", width = "100%", height = "600px")
    )
  )
)

# Define server logic required to draw a bar graph
server <- function(input, output) {
  output$mf_bargraph <- renderPlot({

    # Select data
    selected_data = mf_melted[mf_melted$Gene == input$gene, ]

    # Plot data
    ggplot(data=selected_data, aes(x=cancer_type, y=mutation_frequency, fill = cancer_type, order = cancer_type)) +
      geom_bar(stat="identity", position=position_dodge()) +
      guides(fill=FALSE) +
      coord_flip() +
      scale_y_continuous(breaks=seq(0, 1, 0.1), lim=c(0,1)) +
      ylab("Mutation Frequency from TCGA PanCancer") +
      xlab("Cancer Type")
  })
}

# Run the application
shinyApp(ui = ui, server = server)

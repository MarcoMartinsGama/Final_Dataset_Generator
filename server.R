library(shiny)
library(shinyjs)
library(dplyr)
library(DT)

options(shiny.maxRequestSize = 1000 * 1024^2)

server <- function(input, output, session) {
  observeEvent(input$merge, {
    output$statusText <- renderText({"Working... Please Wait."}) # Message for user patience
    delay(100, { # Delay to display message correctly
      
      # Read Control Dataset
      control_data <- read.table(input$controlFile$datapath, header = TRUE, sep = "\t")
      control_data <- control_data %>%
        mutate(PreyGene = gsub("_HUMAN", "", PreyGene))
      
      # Read Treatment Dataset
      treatment_data <- read.table(input$treatmentFile$datapath, header = TRUE, sep = "\t")
      
      # Merge datasets
      merged_data <- control_data %>%
        full_join(treatment_data, by = c("Prey", "PreyGene"))
      
      # Render merged table
      output$mergedTable <- renderDT({merged_data})
      output$statusText <- renderText({"Done."})
      
      # Download handler for merged dataset
      output$downloadMergedTable <- downloadHandler(
        filename = function() { "Final_Dataset.txt" },
        content = function(file) {
          write.table(merged_data, file, sep = "\t", row.names = FALSE, quote = FALSE)
        }
      )
    })
  })}
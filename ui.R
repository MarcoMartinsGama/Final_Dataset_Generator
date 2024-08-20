library(shiny)
library(shinyjs)
library(DT)

fluidPage(
  useShinyjs(),
  titlePanel("Final Dataset Generator"),
  sidebarLayout(
    sidebarPanel(
      fileInput("controlFile", "Control Dataset.txt"),
      fileInput("treatmentFile", "Treatment Dataset.txt"),
      actionButton("merge", "Merge Datasets"),
      textOutput("statusText")
    ),
    mainPanel(
      fluidRow(style = 'overflow-x: auto', DT::dataTableOutput("mergedTable")),
      downloadButton("downloadMergedTable", "Download Merged Dataset")
    )
  )
)

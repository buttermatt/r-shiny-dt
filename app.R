library(shiny)
library(DT)

ui <- fluidPage(
  
  titlePanel("Data Tables"),
  tabsetPanel(type = "tabs",
              tabPanel("Basic", shiny::dataTableOutput('dataTable')),
              tabPanel("Base DT", DT::dataTableOutput('dtTable')),
              tabPanel("Styling", DT::dataTableOutput('styleTable')),
              tabPanel("Containers", DT::dataTableOutput('containerTable'))
  )
  
  
)

server <- function(input, output) {
  data <- iris[1:20, c(5, 1:4)]
  
  output$dataTable <- shiny::renderDataTable(data)
  
  # rownames(data) <- paste0(data$Species, 1:nrow(data))
  
  output$dtTable <- DT::renderDataTable(data)
  
  options <- list(
    pageLength = 5,
    searching = F,
    order = list(list(0, 'asc')),
    width = "100%"
  )
  
  output$styleTable <- DT::renderDataTable(data, options = options, rownames = F)
  
  sketch = htmltools::withTags(table(
    class = 'display',
    thead(
      tr(
        th(width = "40%", rowspan = 2, 'Species'),
        th(width = "30%", colspan = 2, 'Sepal'),
        th(width = "30%", colspan = 2, 'Petal')
      ),
      tr(
        lapply(rep(c('Length', 'Width'), 2), th)
      )
    )
  ))
  
  
  # Random comment
  
  output$containerTable <- DT::renderDataTable(data, container = sketch, rownames = FALSE)
}

shinyApp(ui, server)
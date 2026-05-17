library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(shinythemes)

ui <- fluidPage(
  
  theme = shinytheme("flatly"),
  
  tags$head(
    tags$style(HTML("
      
      body {
        background-color: #f5f7fa;
      }
      
      .main-title {
        text-align: center;
        padding-top: 25px;
        padding-bottom: 10px;
      }
      
      .main-title h1 {
        font-size: 42px;
        font-weight: 700;
        color: #1f3c88;
        margin-bottom: 8px;
      }
      
      .main-title p {
        font-size: 20px;
        color: #5c677d;
      }
      
      .control-panel {
        background-color: white;
        padding: 20px;
        border-radius: 15px;
        box-shadow: 0px 2px 10px rgba(0,0,0,0.08);
      }
      
      .plot-panel {
        background-color: white;
        padding: 15px;
        border-radius: 15px;
        box-shadow: 0px 2px 10px rgba(0,0,0,0.08);
      }
      
      .btn-primary {
        background-color: #1f3c88;
        border-color: #1f3c88;
      }
      
      .btn-primary:hover {
        background-color: #163172;
        border-color: #163172;
      }
      
    "))
  ),
  
  div(
    class = "main-title",
    
    h1("Exploración interactiva del dataset iris"),
    
    p("Visualización dinámica y análisis interactivo de datos con Shiny")
  ),
  
  fluidRow(
    
    column(
      width = 3,
      
      div(
        class = "control-panel",
        
        h3("Controles"),
        
        tags$hr(),
        
        selectInput(
          inputId = "xvar",
          label = "Variable eje X:",
          choices = names(iris)[1:4],
          selected = "Sepal.Length"
        ),
        
        selectInput(
          inputId = "yvar",
          label = "Variable eje Y:",
          choices = names(iris)[1:4],
          selected = "Petal.Length"
        ),
        
        selectInput(
          inputId = "species",
          label = "Filtrar especie:",
          choices = c(
            "Todas",
            "setosa",
            "versicolor",
            "virginica"
          ),
          selected = "Todas"
        ),
        
        checkboxInput(
          inputId = "regresion",
          label = "Mostrar línea de regresión",
          value = TRUE
        ),
        
        br(),
        
        downloadButton(
          outputId = "downloadData",
          label = "Descargar datos CSV",
          class = "btn-primary btn-block"
        )
      )
    ),
    
    column(
      width = 9,
      
      div(
        class = "plot-panel",
        
        tabsetPanel(
          
          tabPanel(
            "Gráfico",
            
            br(),
            
            plotOutput(
              "scatterplot",
              height = "550px"
            )
          ),
          
          tabPanel(
            "Resumen estadístico",
            
            br(),
            
            tableOutput("summary_table")
          ),
          
          tabPanel(
            "Datos filtrados",
            
            br(),
            
            DTOutput("tabla_datos")
          )
        )
      )
    )
  )
)

server <- function(input, output) {
  
  datos_filtrados <- reactive({
    
    if (input$species == "Todas") {
      iris
    } else {
      iris %>%
        filter(Species == input$species)
    }
    
  })
  
  output$scatterplot <- renderPlot({
    
    p <- ggplot(
      datos_filtrados(),
      aes_string(
        x = input$xvar,
        y = input$yvar,
        color = "Species"
      )
    ) +
      geom_point(
        size = 4,
        alpha = 0.85
      ) +
      theme_minimal(base_size = 15) +
      labs(
        title = paste(
          input$yvar,
          "vs",
          input$xvar
        ),
        subtitle = "Dataset iris",
        x = input$xvar,
        y = input$yvar,
        color = "Especie"
      ) +
      theme(
        plot.title = element_text(
          size = 24,
          face = "bold",
          color = "#1f3c88"
        ),
        plot.subtitle = element_text(
          size = 14,
          color = "#5c677d"
        ),
        legend.position = "bottom",
        panel.grid.minor = element_blank()
      )
    
    if (input$regresion) {
      p <- p +
        geom_smooth(
          method = "lm",
          se = FALSE,
          linewidth = 1.2
        )
    }
    
    p
    
  })
  
  output$summary_table <- renderTable({
    
    summary(datos_filtrados())
    
  })
  
  output$tabla_datos <- renderDT({
    
    datatable(
      datos_filtrados(),
      options = list(
        pageLength = 10,
        autoWidth = TRUE
      )
    )
    
  })
  
  output$downloadData <- downloadHandler(
    
    filename = function() {
      paste0(
        "datos_filtrados_",
        Sys.Date(),
        ".csv"
      )
    },
    
    content = function(file) {
      write.csv(
        datos_filtrados(),
        file,
        row.names = FALSE
      )
    }
    
  )
  
}

shinyApp(ui = ui, server = server)
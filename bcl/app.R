library(shiny)
library(ggplot2)
library(dplyr)
library(shinythemes)
library(DT)
#library(shinydashboard)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  theme = shinytheme("readable"),
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 300, c(20, 50), pre = "$"),
      selectInput(
        "typeInput",
        "Product type",
        choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
        selected = "WINE",
        multiple = TRUE
      ),
      uiOutput("countryOutput"),
      br(),
      br(),
      h6("BLC image", align = "center"),
      br(),
      br(),
      tags$img(
        src = 'BCL_wine.png',
        align = "right",
        height = 175,
        width = 175
      ),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      checkboxInput("PriceSort", label = "Sort by Price", value = FALSE, width = NULL),
      
      downloadButton("result_download", label = "Download Results", class = NULL)
      
    ),
    mainPanel(tabsetPanel(
      type = "tab",
      tabPanel(
        "BCL Data Assignment",
        br(),
        br(),
        textOutput("aboutBCL"),
        br(),
        br(),
        br(),
        textOutput("BCL2"),
        br(),
        br(),
        tags$img(
          src = 'BCLStorefront.png',
          align = "left",
          height = 300,
          width = 450)),
        tabPanel("Histogram Alcohol Content", plotOutput("coolplot")),
        tabPanel("Histogram Price", plotOutput("BCLPrices")),
        tabPanel("Table Data Sorted", dataTableOutput("results_sorted") )
      ),
      br()
    ))
  )
  
  server <- function(input, output) {
    output$aboutBCL = renderText({
      "This Shiny app is based off of Dean Attali's Shiny tutorial entitled 
      \"Building Shiny apps - an interactive tutorial \" 
      and is JasmineLib's submission for STAT 547 homework 8."
    })
    
    output$BCL2 = renderText({
      " Some of the changes made from the tutorial include: 
      modifying the ggplot historgram to make it appear nicer, 
      adding tabs to the shiny app, 
      allowing users to choose multiple beverage types, 
      addition of several images,
      addition of a download button so that users can download their results"
    })
    
    output$countryOutput <- renderUI({
      selectInput("countryInput", "Country",
                  sort(unique(bcl$Country)),
                  selected = "CANADA")
    })
    
    filtered <- reactive({
      if (is.null(input$countryInput)) {
        return(NULL)
      }
      
      bcl %>%
        filter(
          Price >= input$priceInput[1],
          Price <= input$priceInput[2],
          Type == input$typeInput,
          Country == input$countryInput
        )
    })
    
    output$coolplot <- renderPlot({
      if (is.null(filtered())) {
        return()
      }
      ggplot(filtered(), aes(Alcohol_Content)) +
        geom_histogram(
          bins = 20,
          col = "black",
          fill = "darkslategray4",
          binwidth = 1
        ) +
        theme_bw() +
        labs(x = "Alcohol Content (%)", y = "Number of Results") +
        ggtitle("Your Results!")
    })
    
    
    output$BCLPrices <- renderPlot({
      if (is.null(filtered())) {
        return()
      }
      ggplot(filtered(), aes(Price)) +
        geom_histogram(
          bins = 20,
          col = "black",
          fill = "darkslategray4",
          binwidth = 2.5
        ) +
        theme_bw() +
        labs(x = "Price (CAD$)", y = "Number of Results") +
        ggtitle("Your Results!")
    })
    
    
    output$results_sorted <- renderDataTable({
      if(input$PriceSort == TRUE) {
        return( filtered() %>% 
                  arrange((Price)))
      }
      filtered()
    })
    
    
    output$result_download <- downloadHandler(
      filename = function() {
        paste("BCL_results_", Sys.Date(), ".csv", sep = "")
      },
      content = function(file) {
        write.csv(filtered(), file)
      }
    )
  }
  
  shinyApp(ui = ui, server = server)
  
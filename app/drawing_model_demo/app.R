#

# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# load needed libs
library(tidyverse)
library(magrittr)
# load
imgs <- feats_score$FileName
tbl <- head(feats_score[,1:5])

# Define UI for application that draws a histogram
ui <- fluidPage(# Application title
  titlePanel("Drawing Modelling Demo"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    selectInput("id",
                label = "Choose image file ID",
                choices = imgs),
    
    # show feature score row
    # show drawing image
    mainPanel(# plotOutput("distPlot")
      h2("Table row w/ features and human scores"),
      tableOutput("onerow_intable"),
      h2("Drawing image"),
      imageOutput("imgout"))
  ))

# Define server logic required to draw a histogram
server <- function(input, output) {
  # based on input$id to find the row to render
  output$onerow_intable <- renderTable({
  onerow <- feats_score %>%
    filter(FileName == input$id)
  })
  
  # based on https://shiny.rstudio.com/articles/images.html
  output$imgout <- renderImage({
    filename <-
      normalizePath(file.path('./img', paste0(input$id, '.jpeg')))
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Image ", input$id))
  }, deleteFile = FALSE)
  
}

# Run the application
shinyApp(ui = ui, server = server)

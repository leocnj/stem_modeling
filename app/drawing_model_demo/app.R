#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

imgs <- c("CMS60000678_1_1.jpeg",
          "CMS60000692_1_1.jpeg",
          "CMS60000702_1_1.jpeg")
 
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Test..."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     selectInput("id", 
                 label = "Choose image file ID",
                 choices = imgs),
      
      # Show a plot of the generated distribution
      mainPanel(
         # plotOutput("distPlot")
        imageOutput("imgout")
      )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
 
   output$imgout <- renderImage({
    filename <- normalizePath(file.path('./img', input$id))
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Image ", input$id))
    }, deleteFile = FALSE)
   
}

# Run the application 
shinyApp(ui = ui, server = server)


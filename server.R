library(ggplot2)
library(shiny)
library(readxl)
library(curl)


function(input, output) {
  
  dataset <- reactive({
url <- "https://github.com/AGSCL/Install-R/raw/master/personal_curso.xlsx"
destfile <- "personal_curso.xlsx"
curl::curl_download(url, destfile)
dataset <-  read_excel(destfile)
})
output$plot  <- renderPlot({
  
  p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
  
  if (input$color != 'None')
    p <- p + aes_string(color=input$color)
  
  facets <- paste(input$facet_row, '~', input$facet_col)
  if (facets != '. ~ .')
    p <- p + facet_grid(facets)
  
  if (input$jitter)
    p <- p + geom_jitter()
  if (input$smooth)
    p <- p + geom_smooth()
  
  print(p)
  
}, height=700)

}
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
  
  p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) 
  
  if (input$point)
    p <- p + geom_point()

  if (input$boxplot)
    p <- p + geom_boxplot()

  if (input$x == "sexo" & input$y=="entero1" & input$boxplot)
    p <- p + ggtitle("Segundo gráfico, correcto")
  
  if (input$x == "decimal1" & input$y=="decimal2" & input$point)
    p <- p + ggtitle("Primer gráfico (de dispersión), correcto")
  
  if (input$x == "decimal2" & input$y=="decimal1" & input$point)
    p <- p + ggtitle("Primer gráfico (de dispersión), correcto")
  
  print(p)
  
}, height=700)

}
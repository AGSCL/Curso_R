library(ggplot2)
library(shiny)
library(readxl)
library(curl)

url <- "https://github.com/AGSCL/Install-R/raw/master/personal_curso.xlsx"
destfile <- "personal_curso.xlsx"
curl::curl_download(url, destfile)
dataset <-  read_excel(destfile)

dataset <-dataset

fluidPage(
  
  titlePanel("Explorador de Resultados"),
  
  sidebarPanel(
    
    #sliderInput('sampleSize', 'Tamaño de la muestra', min=1, max=nrow(dataset),
     #           value=min(1, nrow(dataset)), step=100, round=0),
    
    selectInput('x', 'Elija la variable para el eje X', names(dataset)),
    selectInput('y', 'Elija la variable para el eje Y', names(dataset), names(dataset)[[2]]),
    #selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('point', 'Gráfico de Dispersión'),
    checkboxInput('boxplot', 'Diagrama de Cajas'),
    
    #selectInput('facet_row', 'Segmentar por Filas', c(None='.', names(dataset))),
    #selectInput('facet_col', 'Segmentar por Columnas', c(None='.', names(dataset)))
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)

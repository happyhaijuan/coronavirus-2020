#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(spData)
library(dplyr)

#selectInput(inputId = "Select",label = "select a country",choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3))

navbarPage("Information about Coronavirus in 2020", id="main",
           tabPanel("Map", leafletOutput("bbmap", height=1000)),
           tabPanel("Trend",plotOutput("plot")),
           tabPanel("Data", DT::dataTableOutput("data"))
          # tabPanel("Read Me",includeMarkdown("readme.md"))
          )

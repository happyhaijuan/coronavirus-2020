library(shiny)
library(dplyr)
library(leaflet)
library(DT)
library(ggplot2)
shinyServer(function(input,output){
  # Import data
  df_coron <- read.csv("total_numbers.csv",
                      stringsAsFactors = FALSE)
  coronavirus <- read.csv("coronavirus.csv",
                      stringsAsFactors = FALSE)
  time_series_group <- read.csv("time_series_group.csv",
                                stringsAsFactors = FALSE)
  
  df_coron <- data.frame(df_coron)
  coronavirus <- data.frame(coronavirus)
 # column for label
 df_coron <- mutate(df_coron, cntnt=paste0('<strong>Name:</strong>',Country.Region,
                                          '<br><strong>State/Provice:</strong>',Province.State,
                                          '<br><strong>Confirmed:</strong>', confirmed_number,
                                          '<br><strong>death:</strong>', death_number,
                                          '<br><strong>recoverd:</strong>', recoved_number
                                          ))
                                           
  
  # create a color paletter for category type in the data file
 # pal <- colorFactor(pal = c("#1b9e77", "#d95f02", "#7570b3"), domain = c("confirmed", "death", "recovered"))
  
  #create the leaflet map
  output$bbmap <- renderLeaflet({
        leaflet(df_coron) %>%
        addCircles(lng = ~Long, lat = ~Lat) %>%
        addTiles() %>%
        addCircleMarkers(data = df_coron, lat = ~Lat, lng = ~Long, radius = 3,popup = ~as.character(cntnt),
                           stroke = FALSE) %>%
       # addLegend(pal=pal,values=df_coron$type, opacity = 1, na.label = "Not Available") 
        addEasyButton(easyButton(icon="fa-crosshairs",title="ME",onClick = JS("function(btn,map){map.locate({setView:true});}")))
    #create a data object to display data
  })
  output$plot <- renderPlot({ggplot(time_series_group,aes(x = date, y = total_case, group = type)) + geom_line(aes(linetype = type, color = type)) +
      geom_point(aes(color=type)) + theme(legend.position = "bottom",plot.margin = margin(0.1,0.1,0.1,0.1, "cm"))})
  
  output$data <-DT::renderDataTable(datatable(
      coronavirus,filter = 'top',
     colnames = c("Row","Province.State", "Country.Region", "Lat","Long","date","cases","type")
    ))
                          
 
})


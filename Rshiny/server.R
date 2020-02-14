library(shiny)
library(dplyr)
library(leaflet)
library(DT)

shinyServer(function(input,output){
  # Import data
  df_coron <- read.csv("/Users/haijuanzhang/Documents/coronavirus-2020/visulization data/total_numbers.csv",
                      stringsAsFactors = FALSE)
  df_coron <- data.frame(df_coron)
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
    
   # output$data <-DT::renderDataTable(datatable(
   #   df_coron,filter = 'top',
  #   colnames = c("Province.State", "Country.Region", "Lat","Long","date","case","type")
   # ))
                          
  })
})


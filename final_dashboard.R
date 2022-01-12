## app.R ##
library(shiny)
library(shinydashboard)
library(dplyr)
library(highcharter)
library(plotly)



edata <-
  read.csv('https://github.com/hadikachmar3/Data_visualization/blob/main/artist_df_final.csv')
# filt <- edata %>% filter(continent =='Africa')
# View(filt)
fdata <-
  edata  %>% arrange(n)

# fdata <- fdata %>% filter(continent == 'Africa')
edata <-  edata %>%
  rename(z = 'n')
wmap <-
  hcmap(
    borderColor = "#ff0000",
    borderWidth = 0.1,
    color = hex_to_rgba("darkred", alpha = 0.3),
    value = '10'
  )
#####################
##
#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Data visualization")
#Sidebar content of the dashboard
sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(
    "Dashboard",
    tabName = "dashboard",
    icon = icon("dashboard")
  ),
  menuItem(
    selected = TRUE,
    "Show genres per year",
    tabName = "years",
    icon = icon("calendar"),
    sliderInput(
      "year",
      "Years",
      value = c(1945, 2015),
      min = 1945,
      max = 2015,
      step = 5 ,
      ticks = TRUE,
    )
  ),
  
  menuItem(
    "All Genres",
    tabName = "Genres",
    icon = icon("calendar"),
    selectInput(
      inputId =  'genres',
      label =  'Genres',
      choices = c(
        'Blues',
        'Dubstep',
        'Electronic',
        'Hip Hop',
        'Jazz',
        'Pop',
        'Rock',
        'Techno',
        'Rock',
        'Hip Hop',
        'Missing data',
        'Others'
      )
      
    )
  ),
  
  menuItem(
    "Continents",
    tabName = "Continents",
    icon = icon("calendar"),
    selectInput(
      inputId =  'continents',
      label =  'Continents',
      choices = c('Americas',
                  'Oceania',
                  'Asia',
                  'Africa',
                  'Europe'),
      selected = 'Europe'
    )
  )
))
##

#####
frow1 <-
  fluidRow(column(
    12,
    span(textOutput("note"), style="color:red"),
    fluidRow(
      valueBoxOutput("value1"),
      valueBoxOutput("value2")
      ,
      valueBoxOutput("value3")
    )
  ))
frow2 <- fluidRow(
  box(
    title = "Total artists number per each genre for the chosen continet"
    ,
    status = "primary"
    ,
    solidHeader = TRUE
    ,
    collapsible = TRUE
    ,
    # highchartOutput("funnel", height = "600px")
    plotlyOutput('funnel', height = "600px")
  )
  ,
  box(
    title = "Artists distribution for the chosen genre",
    status = "primary",
    solidHeader = TRUE,
    collapsible = TRUE,
    highchartOutput("eqmap", height = "600px")
  )
)
# combine the two fluid rows to make the body
body <- dashboardBody(frow1, frow2)
#####
#completing the ui part with dashboardPage
ui <-
  dashboardPage(title = 'This is my Page title', header, sidebar, body, skin =
                  'red')
# create the server functions for the dashboard
server <- function(input, output) {
  filtered_edata <- reactive(edata %>% filter(genres == input$genres))
  funnel_df <-
    reactive(fdata %>% filter(continent == input$continents))
  
  output$note <- renderText({"Note: The 3 boxes below are synchronized only with the bubble map"})
  #creating the valueBoxOutput content
  output$value1 <-
    renderValueBox({
      valueBox(
        formatC(
          max(filtered_edata()$z),
          format = "d",
          big.mark = ','
        )
        ,
        paste(
          'Is the highest artists number belong to the ',
          input$genres,
          ' genre per continent'
        )
        ,
        
        
        icon = icon("stats", lib = 'glyphicon')
        ,
        color = "purple"
      )
    })
  output$value2 <- renderValueBox({
    valueBox(
      formatC(
        sum(filtered_edata()$z),
        format = "d",
        big.mark = ','
      ),
      paste(
        'is the total artists number belong to the',
        input$genres,
        ' genre'
      ),
      # filtered_edata()$genres
      
      # "",
      icon = icon("gbp", lib = 'glyphicon')
      ,
      color = "green"
    )
  })
  output$value3 <- renderValueBox({
    valueBox(
      formatC(
        min(filtered_edata()$z),
        format = "d",
        big.mark = ','
      )
      ,
      paste(
        'Is the lowest artists number belong to the ',
        input$genres,
        ' genre per continent'
      )
      ,
      icon = icon("menu-hamburger", lib = 'glyphicon')
      ,
      color = "orange"
    )
  })
  #creating the plotOutput content
  
  output$funnel <- renderPlotly({
    fig <- plot_ly()
    fig <- fig %>% add_trace(
      type = "funnel",
      y = funnel_df()$genres,
      x = funnel_df()$n,
      textposition = "inside",
      textinfo = "value+percent initial",
      opacity = 0.65,
      marker = list(
        color = c(
          "darkOrange",
          "lighBlue",
          "red",
          "brown",
          "wheat",
          'yellow',
          'cyan',
          'pruple',
          'teal',
          'blue',
          'orange',
          'green'
        ),
        line = list(
          width = c(5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1),
          color = c(
            "green",
            "orange",
            "blue",
            "teal",
            "wheat",
            'cyan',
            'yellow',
            'purple',
            'teal',
            'blue',
            'darkOrange',
            'green'
          )
        )
      ),
      connector = list(line = list(
        color = "royalblue",
        dash = "dot",
        width = 3
      ))
    )
    fig <- fig %>%
      layout(yaxis = list(categoryarray = funnel_df()$genres))
    
    # plot_ly(type = "funnel",
    #         text = funnel_df()$genres,
    #         values = funnel_df()$n)
    
  },)
  
  # output$funnel <- renderHighchart(funnel_df() %>%
  #                                    hchart(
  #                                      "funnel",
  #                                      hcaes(x = funnel_df()$genres, y = funnel_dfF()$n),
  #                                      name = "Total artists number per each genre"
  #                                    ),)
  # output$funnel <- renderHighchart(fdata %>%
  #                                    hchart("funnel", hcaes(x = fdata$genres, y = fdata$n),
  #                                           name = "Total artists number per each genre"),
  # )
  output$eqmap <- renderHighchart(
    wmap %>%  hc_legend(
      enabled = TRUE,
      # title = list(text = "Artists number", col = 'red'),
      bubbleLegend = list(
        enabled = TRUE,
        borderColor = '#A9A9A9',
        borderWidth = 1,
        color = '#E6E6FA',
        connectorColor = '#A9A9A9'
      ),
      align = "bottom",
      layout = "horizontal",
      floating = TRUE ,
      valueDecimals = 0,
      symbolHeight = 11,
      symbolWidth = 11,
      symbolRadius = 0
    )  %>%
      hc_title(text = "Artists distribution according to their genres") %>%
      # hc_subtitle(text = paste('', nrow(data()), sep = '')) %>%
      hc_tooltip(
        # valueSuffix = "'°C'",
        useHTML = T,
        headerFormat = '',
        crosshairs = FALSE,
        pointFormat = paste('{point.continent}', ': {point.z}')
      ) %>%
      hc_add_series(
        data = filtered_edata(),
        type = "mapbubble",
        name = "Artists distribution",
        maxSize = paste0(10, '%')
      ) %>% #bubble size in perc % ## add the bubbles
      hc_mapNavigation(enabled = T) %>% hc_add_theme(hc_theme_flatdark()) %>%
      hc_colorAxis(dataClasses = color_classes(
        breaks = c(0, 10, 20, 40, 60, 100, 100000),
        colors = c("brown", "green", "blue", "orange", "cyan", "black")
      ))
  )
}
shinyApp(ui, server)
#----------------- Packages -----------------
library(shiny)
library(bs4Dash)

#----------------- Functions -----------------
`%>%` <- magrittr::`%>%`

#----------------- Data -----------------
data("iris")
data("AirPassengers")




#----------------- UI -----------------
ui <- bs4Dash::dashboardPage(
  enable_preloader = FALSE,
  title = "Dashboard title here...",
  navbar = bs4Dash::bs4DashNavbar(
    skin = "dark",
    # status = "primary",
    border = FALSE,
    sidebarIcon = "bars",
    compact = FALSE,
    controlbarIcon = "th",
    leftUi = NULL,
    rightUi = NULL
  ),
  #----------------- Sidebar -----------------
  sidebar = bs4Dash::bs4DashSidebar(inputId = NULL,
                                    disable = TRUE,
                                    title = "title here???",
                                    skin = "dark",
                                    status = "primary",
                                    brandColor = NULL,
                                    url = NULL,
                                    src = NULL,
                                    elevation = 4,
                                    opacity = 0.8,
                                    expand_on_hover = TRUE),
  #----------------- Body -----------------
  body = bs4Dash::dashboardBody(
    bs4Dash::bs4TabSetPanel(
      id = "panel1",
      side = "left",
      #----------------- Tab 1 -----------------
      bs4Dash::bs4TabPanel(
        tabName =  "tab 1",
        bs4Dash::bs4Card(
          inputId = "id1",
          title = "Plot 1",
          closable = FALSE,
          maximizable = TRUE,
          width = 12,
          status = "dark",
          solidHeader = FALSE,
          collapsible = TRUE,
          labelText = paste("You can use here some variable"),
          labelStatus = "info",
          dropdownIcon = "wrench",
          plotly::plotlyOutput("plot1")
        ),
        bs4Dash::bs4Card(
          inputId = "id2",
          title = "Plot 2",
          closable = FALSE,
          maximizable = TRUE,
          width = 12,
          status = "dark",
          solidHeader = FALSE,
          collapsible = TRUE,
          labelText = paste("You can use here some variable"),
          labelStatus = "info",
          dropdownIcon = "wrench",
          plotly::plotlyOutput("plot2")
        )
      ),
      #----------------- Tab 2 -----------------
      bs4Dash::bs4TabPanel(
        tabName =  "tab 2",
        fluidRow(
          bs4Dash::bs4Card(
            inputId = "id3",
            title = "Plot 3",
            closable = FALSE,
            maximizable = TRUE,
            width = 6,
            status = "dark",
            solidHeader = FALSE,
            collapsible = TRUE,
            labelText = paste("You can use here some variable"),
            labelStatus = "info",
            dropdownIcon = "wrench",
            plotly::plotlyOutput("plot3")
          ),
          bs4Dash::bs4Card(
            inputId = "id4",
            title = "Plot 4",
            closable = FALSE,
            maximizable = TRUE,
            width = 6,
            status = "dark",
            solidHeader = FALSE,
            collapsible = TRUE,
            labelText = paste("You can use here some variable"),
            labelStatus = "info",
            dropdownIcon = "wrench",
            plotly::plotlyOutput("plot4")
          )),
        fluidRow(
          bs4Dash::bs4Card(
            inputId = "id5",
            title = "Plot 5",
            closable = FALSE,
            maximizable = TRUE,
            width = 6,
            status = "dark",
            solidHeader = FALSE,
            collapsible = TRUE,
            labelText = paste("You can use here some variable"),
            labelStatus = "info",
            dropdownIcon = "wrench",
            plotly::plotlyOutput("plot5")
          ),
          bs4Dash::bs4Card(
            inputId = "id6",
            title = "Plot 6",
            closable = FALSE,
            maximizable = TRUE,
            width = 6,
            status = "dark",
            solidHeader = FALSE,
            collapsible = TRUE,
            labelText = paste("You can use here some variable"),
            labelStatus = "info",
            dropdownIcon = "wrench",
            plotly::plotlyOutput("plot6")
          ))
      ),
      
      #----------------- Tab 3 -----------------
      
      
      
      
      bs4Dash::bs4TabPanel(
        tabName =  "tab 3",
        fluidPage(
          DT::DTOutput("iris_table")
        )
      )
      
    )
    
  )
  
)

#----------------- Server -----------------
server <- function(input, output, session){
  #----------------- Tab 1 -----------------
  output$plot1 <- plotly::renderPlotly({
    TSstudio::ts_plot(AirPassengers)
  })
  
  output$plot2 <- plotly::renderPlotly({
    TSstudio::ts_cor(AirPassengers)
  })
  
  #----------------- Tab 2 -----------------
  
  output$plot3 <- plotly::renderPlotly({
    TSstudio::ts_seasonal(AirPassengers, type = "normal")
  })
  
  output$plot4 <- plotly::renderPlotly({
    TSstudio::ts_seasonal(AirPassengers, type = "cycle")
  })
  
  
  output$plot5 <- plotly::renderPlotly({
    TSstudio::ts_seasonal(AirPassengers, type = "box")
  })
  
  output$plot6 <- plotly::renderPlotly({
    TSstudio::ts_surface(AirPassengers)
  })
  
  
  #----------------- Tab 3 -----------------
  
  output$iris_table <- DT::renderDT(DT::datatable(iris))
  
}


shinyApp(ui, server)

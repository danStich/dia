library(DT)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Dam Impact Analysis (DIA) model for Atlantic salmon"),

  # Sidebar layout with input and output definitions ----

    # Sidebar panel for inputs ----
  
    sidebarLayout( 
      
      sidebarPanel(
       fluidRow(
         p("To use default values from Nieland and Sheehan (2020), click 
         \"Run Model\" without changing any of the default inputs."), 
         br(),
         p("To test new scenarios, enter input parameter values in the tabs 
         below from left to right and then click \"Run Model\"  to view tabular 
         or graphical results. "),
         br(),
         p("Refresh the browser between scenarios to avoid re-running the model
         each time an input value is changed."), 
         br(),
         numericInput(inputId = "n_runs", label = "How many runs?",
                      value = 10, step = 10
                      ),
         actionButton("go",label = "Run Model")
         ),
       br(), 
       br(), 
       h3("Input parameters"),
       tabsetPanel(
          tabPanel(title = "Passage rates",
                   DTOutput("passage")
                   ),
          tabPanel(title = "Life history",
                   DTOutput("lifehistory")
                   ),
          tabPanel(title = "Stocking",
                   DTOutput("stocking")
                   )          
          )
       ),
      
    # Main panel for displaying outputs ----
    mainPanel(
      tabsetPanel(
        tabPanel(
          title = "Tabular output",
          br(),
          fluidRow(dataTableOutput('model_result')),
          br()
        ),
        tabPanel(
          title = "Plot",
          selectInput(inputId = "result_type", label = "Plot type",
                      choices = c("By generation", "By production unit")
                      ),
          plotOutput("graph")    
        )       
      )
    )
  )
  
)
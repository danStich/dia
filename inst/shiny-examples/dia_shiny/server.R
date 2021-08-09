# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Library loads ----
  library(dia)
  library(doParallel)
  library(foreach)
  library(DT)
  library(tidyverse)
  
  # Data read and default parameter load ----
  # . Default fish passage ----
  passage <- read.csv("data/passage.csv")
  r_passage <- reactiveValues(data = passage)
  
  output$passage <- renderDT({
      DT::datatable(r_passage$data, editable = TRUE,
                    options = list(pageLength = 15, lengthChange = FALSE,
                                   bInfo = FALSE, searching = FALSE,
                                   ordering = FALSE, paging = FALSE))
  })
  
  observeEvent(input$passage_cell_edit, {
      #get values
      info = input$passage_cell_edit
      i = as.numeric(info$row)
      j = as.numeric(info$col)
      k = as.numeric(info$value)

      #write values to reactive
      r_passage$data[i, j] <- k
  })  
  
  # . Default life-history parameters ----
  lifehistory <- read.csv("data/lifehistory.csv")
  r_lifehistory <- reactiveValues(data = lifehistory)
  
  output$lifehistory <- renderDT({
      DT::datatable(r_lifehistory$data, editable = TRUE,
                    options = list(pageLength = 15, lengthChange = FALSE,
                                   bInfo = FALSE, searching = FALSE,
                                   ordering = FALSE, paging = FALSE))
  })
  
  observeEvent(input$lifehistory_cell_edit, {
      #get values
      info = input$lifehistory_cell_edit
      i = as.numeric(info$row)
      j = as.numeric(info$col)
      k = as.numeric(info$value)

      #write values to reactive
      r_lifehistory$data[i, j] <- k
  })
  
  # Stocking options ----
  stocking <- read.csv("data/stocking.csv")
  
  r_stocking <- reactiveValues(data = stocking)
  
  output$stocking <- renderDT({
      DT::datatable(r_stocking$data[1:r_lifehistory$data[1, 2],], editable = TRUE,
                    options = list(pageLength = 15, lengthChange = FALSE,
                                   bInfo = FALSE, searching = FALSE,
                                   ordering = FALSE, paging = FALSE))
  })
  
  observeEvent(input$stocking_cell_edit, {
      #get values
      info = input$stocking_cell_edit
      i = as.numeric(info$row)
      j = as.numeric(info$col)
      k = as.numeric(info$value)

      #write values to reactive
      r_stocking$data[i, j] <- k
  })  
  
  
  # DIA model run ----
  
  model_run <- reactive({
      req(input$go)   
      do.call(rbind, 
      foreach(1:input$n_runs) %do%
        
      run_dia(
      n_generations = r_lifehistory$data[1, 2],
      n_wild = r_lifehistory$data[2, 2], 
      n_hatchery = r_lifehistory$data[3, 2],
      stocking = 1,
      n_stocked = r_stocking$data[1:r_lifehistory$data[1, 2],2],
      upstream = list(
        medway = r_passage$data[1, 2],
        mattaceunk = r_passage$data[2, 2],
        west_enfield = r_passage$data[3, 2],
        upper_dover = r_passage$data[4, 2],
        browns_mills = r_passage$data[5, 2],
        sebec = r_passage$data[6, 2],
        milo = r_passage$data[7, 2],
        howland = r_passage$data[8, 2],
        lowel = r_passage$data[9, 2],
        stillwater = r_passage$data[10, 2],
        milford = r_passage$data[11, 2],
        great_works = r_passage$data[12, 2],
        orono = r_passage$data[13, 2],
        veazie = r_passage$data[14, 2],
        frankfort = r_passage$data[15, 2]),
      downstream = list(
        medway = r_passage$data[1, 3],
        mattaceunk = r_passage$data[2, 3],
        west_enfield = r_passage$data[3, 3],
        upper_dover = r_passage$data[4, 3],
        browns_mills = r_passage$data[5, 3],
        sebec = r_passage$data[6, 3],
        milo = r_passage$data[7, 3],
        howland = r_passage$data[8, 3],
        lowel = r_passage$data[9, 3],
        stillwater = r_passage$data[10, 3],
        milford = r_passage$data[11, 3],
        great_works = r_passage$data[12, 3],
        orono = r_passage$data[13, 3],
        veazie = r_passage$data[14, 3],
        frankfort = r_passage$data[15, 3]),
      mattaceunk_impoundment_mortality = r_lifehistory$data[5, 2],
      p_stillwater = NULL,
      indirect_latent_mortality = r_lifehistory$data[6, 2],
      p_female = r_lifehistory$data[4, 2],
      new_or_old = "new",
      marine_s_hatchery = NULL,
      marine_s_wild = NULL,
      straying_matrix = NULL,
      p_mainstem_up = 1,
      n_broodstock = 150
    ))
      })
  
  
  
  output$model_result <- renderDT({
    mydata <- model_run()
    mydata %>% 
      group_by(generation, origin, production_unit) %>% 
      summarize(abund = round(mean(abundance), 0),
                lwr = round(quantile(abundance, 0.025), 0),
                upr = round(quantile(abundance, 0.975), 0),
                .groups = "keep"
                )
  })
  
    output$graph <- renderPlot({
      
      x <- input$result_type
      
      mydata <- model_run()
      
      if(x == "By generation"){
        
        plotter <- mydata %>% 
          group_by(generation, origin, production_unit) %>% 
          summarize(abund = median(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975),
                    .groups = "keep"
                    ) %>% 
          group_by(generation, origin) %>% 
          summarize(abundance = sum(abund),
                    lwr = sum(lwr),
                    upr = sum(upr),
                    .groups = "keep"
                    )
        # plot(plotter$generation, plotter$abundance)
        p <- ggplot(plotter, aes(x = generation, y = abundance,
               fill = origin, color = origin)) +
             geom_ribbon(aes(xmax = generation, ymin = lwr, ymax = upr,
                             color = NULL), alpha = 0.15) +
             geom_line()
        print(p)
        
      }
      if(x == "By production unit"){
        plotter <- mydata %>%         
          group_by(generation, origin, production_unit) %>% 
          filter(generation == max(generation)) %>% 
          summarize(abundance = mean(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975),
                    .groups = "keep"
                    )
        boxplot(abundance ~ production_unit, data = plotter)
        
      }      
      
      
      
    })
}








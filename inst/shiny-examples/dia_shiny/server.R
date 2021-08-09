# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Library loads ----
  library(dia)
  library(foreach)
  library(DT)
  library(dplyr)
  library(ggplot2)  
  
  # Data read and default parameter load ----
  # . Default fish passage ----
  passage <- read.csv("data/passage.csv")
  r_passage <- shiny::reactiveValues(data = passage)
  
  output$passage <- DT::renderDT({
      DT::datatable(r_passage$data, editable = TRUE,
                    options = list(pageLength = 15, lengthChange = FALSE,
                                   bInfo = FALSE, searching = FALSE,
                                   ordering = FALSE, paging = FALSE))
  })
  
  shiny::observeEvent(input$passage_cell_edit, {
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
  r_lifehistory <- shiny::reactiveValues(data = lifehistory)
  
  output$lifehistory <- DT::renderDT({
      DT::datatable(r_lifehistory$data, editable = TRUE,
                    options = list(pageLength = 15, lengthChange = FALSE,
                                   bInfo = FALSE, searching = FALSE,
                                   ordering = FALSE, paging = FALSE))
  })
  
  shiny::observeEvent(input$lifehistory_cell_edit, {
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
  
  r_stocking <- shiny::reactiveValues(data = stocking)
  
  output$stocking <- DT::renderDT({
      DT::datatable(r_stocking$data[1:r_lifehistory$data[1, 2],], editable = TRUE,
                    options = list(pageLength = 15, lengthChange = FALSE,
                                   bInfo = FALSE, searching = FALSE,
                                   ordering = FALSE, paging = FALSE))
  })
  
  shiny::observeEvent(input$stocking_cell_edit, {
      #get values
      info = input$stocking_cell_edit
      i = as.numeric(info$row)
      j = as.numeric(info$col)
      k = as.numeric(info$value)

      #write values to reactive
      r_stocking$data[i, j] <- k
  })  
  
  
  # DIA model run ----
  
  model_run <- shiny::reactive({
      shiny::req(input$go)   
      do.call(rbind, 
      foreach::foreach(1:input$n_runs) %do%
        
      dia::run_dia(
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
  
  
  output$model_result <- renderDT(server = FALSE,
    model_run() |>
      dplyr::group_by(generation, origin, production_unit) |> 
      dplyr::summarize(Abundance = round(mean(abundance), 0),
                Lower = round(quantile(abundance, 0.025), 0),
                Upper = round(quantile(abundance, 0.975), 0),
                .groups = "keep"
                ),
    rownames = FALSE,
    colnames = c("Generation", "Origin", "Production Unit",
                 "Abundance", "Lower", "Upper")
    , extensions = 'Buttons',
    options = list(dom = 'Bfrtip', buttons = c('copy', 'csv', 'excel'), 
                   exportOptions = list(modifier = list(page = "all")))
  )
  
    
    output$graph <- shiny::renderPlot({
      
      x <- input$result_type
      
      mydata <- model_run()
      
      if(x == "By generation"){
        # Summarize data
        plotter <- mydata %>% 
          dplyr::group_by(generation, origin, production_unit) |> 
          dplyr::summarize(abund = median(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975),
                    .groups = "keep"
                    ) %>% 
          dplyr::group_by(generation, origin) |> 
          dplyr::summarize(abundance = sum(abund),
                    lwr = sum(lwr),
                    upr = sum(upr),
                    .groups = "keep"
                    )
          plotter$origin[plotter$origin == "hatchery"] <- "Hatchery"
          plotter$origin[plotter$origin == "wild"] <- "Wild"
          names(plotter) <- c("Generation", "Origin",
                              "Abundance", "lwr", "upr")
          
        
        # Make plot
        p <- ggplot2::ggplot(plotter, 
                             ggplot2::aes(x = Generation, y = Abundance,
                                          fill = Origin, color = Origin)) +
             ggplot2::geom_ribbon(
               ggplot2::aes(xmax = Generation, ymin = lwr, ymax = upr,
                            color = NULL), alpha = 0.15) +
             ggplot2::geom_line() +
             theme_bw() +
             theme(
               axis.title.x = element_text(vjust = -1),
               axis.title.y = element_text(vjust = 3)
             )
        
        print(p)
        
      }
      if(x == "By production unit"){
        # Summarize data
        plotter <- mydata %>%         
          dplyr::group_by(generation, origin, production_unit) %>% 
          dplyr::filter(generation == max(generation)) %>% 
          dplyr::summarize(abundance = mean(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975),
                    .groups = "keep"
                    )
          plotter$origin[plotter$origin == "hatchery"] <- "Hatchery"
          plotter$origin[plotter$origin == "wild"] <- "Wild"
          names(plotter) <- c("Generation", "Origin", "production_unit",
                              "Abundance", "lwr", "upr")
        
        # Make plot
        p <- ggplot2::ggplot(plotter, 
                             ggplot2::aes(x = production_unit, y = Abundance,
                                          fill = Origin, color = Origin)) +
             ggplot2::geom_boxplot(alpha = 0.10) +
             xlab("Production unit") +
             theme_bw() +
             theme(
               axis.title.x = element_text(vjust = -1),
               axis.title.y = element_text(vjust = 3)
             )
        print(p)
        
      }      
      
      
      
    })
}








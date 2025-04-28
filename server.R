print("---------------------------------1")

server <- function(input, output, session) {

  rv_season      <- reactiveValues()
  rv_gametype    <- reactiveValues()
 # rv_year      <- reactiveValues()



  isolate({
    rv_season$season       <- input$season
    rv_gametype$gametype <- input$gametype
    #rv_year$year       <- input$year
  })

  #observeEvent(input$filt_btn, {




  observeEvent(rv_season$season, {
    updatePickerInput(session, inputId = "gametype",
                      label = "Select Game Type(s):",
                      choices = unique(player_sum[season %in% rv_season$season, playoffs]),
                      selected = unique(player_sum[season %in% rv_season$season, playoffs]))
  })



  # observeEvent(rv_gametype$gametype, {
  #   updatePickerInput(session, inputId = "year",
  #                     label = "Select Year(s):",
  #                     choices = unique(player_sum[playoffs %in% input$gametype, Year]),
  #                     selected = unique(player_sum[playoffs %in% input$gametype, Year]))
  # })



  observe({


    if(!isTRUE(input$season_open) & !isTRUE(input$gametype_open))

    {

      rv_season$season <- input$season
      rv_gametype$gametype <- input$gametype
      #rv_year$year <- input$year

    }

  })


  datasetInput_nba <- reactive({

    get_data_df <- player_sum


    filtered_df <<-  get_data_df[ season %in% rv_season$season &
                                  playoffs %in% rv_gametype$gametype
                                  ,]
    return( (filtered_df ))




  })


  freeThrough_nba <- reactive({

    get_data_df <- free_throw


    filtered_df <-  get_data_df[season %in% rv_season$season &
                                    playoffs %in% rv_gametype$gametype
                                  ,]
    return( (filtered_df ))




  })



  #initial <- reactiveVal(TRUE)

  # filtered_data <- reactive({
  #   if (initial()) {
  #     # First launch: show full player_sum
  #     player_sum
  #   } else {
  #     # After first launch: only on button click
  #     req(input$season, input$gametype)
  #     player_sum[
  #       season %in% input$season &
  #         playoffs %in% input$gametype
  #        # Year %in% input$year
  #     ]
  #   }
  # })

  # Change initial flag after first button click
  # observeEvent(input$filt_btn, {
  #   initial(FALSE)
  # })

  # return(list(filtered_data = filtered_data))

  print("---------------------------------2")


  ##################################
  top_three_ft <- player_sum[playoffs=="regular"][, keyby = .(player), .(FT_perc = round(Total_FT_Made*100/Total_FTA, 0))][order(desc(FT_perc))][1:3]


  PlayerFTServer(id= "first_player_ft",valOne = top_three_ft[1]$player, valTwo = top_three_ft[1]$FT_perc)
  PlayerFTServer(id= "second_player_ft",valOne = top_three_ft[2]$player, valTwo = top_three_ft[2]$FT_perc)
  PlayerFTServer(id= "third_player_ft",valOne = top_three_ft[3]$player, valTwo = top_three_ft[3]$FT_perc)



  top_three_pf <- player_sum[playoffs=="playoffs"][, keyby = .(player), .(FT_perc = round(Total_FT_Made*100/Total_FTA, 0))][order(desc(FT_perc))][1:3]

  PlayerFTServer(id= "first_player_pf",valOne = top_three_pf[1]$player, valTwo = top_three_pf[1]$FT_perc)
  PlayerFTServer(id= "second_player_pf",valOne = top_three_pf[2]$player, valTwo = top_three_pf[2]$FT_perc)
  PlayerFTServer(id= "third_player_pf",valOne = top_three_pf[3]$player, valTwo = top_three_pf[3]$FT_perc)




  top_three_pfmade <- player_sum[, keyby = .(player), .(FT_made = sum(Total_FT_Made, na.rm = T))][order(desc(FT_made))][1:3]

  PlayerFTServer(id= "first_player_ftmade",valOne = top_three_pfmade[1]$player, valTwo = top_three_pfmade[1]$FT_made)
  PlayerFTServer(id= "second_player_ftmade",valOne = top_three_pfmade[2]$player, valTwo = top_three_pfmade[2]$FT_made)
  PlayerFTServer(id= "third_player_ftmade",valOne = top_three_pfmade[3]$player, valTwo = top_three_pfmade[3]$FT_made)



  player_sum[, season_start_year := as.numeric(sub("^(\\d{4}).*", "\\1", season))]

  # Order by player and season year
  setorder(player_sum, player, season_start_year)

  # Calculate previous FT% and improvement
  player_sum[, keyby = .(player)][, prev_FT_Pct := shift(FT_Pct, type = "lag"), by = player]
  player_sum[, FT_Pct_Improvement := round((FT_Pct - prev_FT_Pct)*100,0)]

  most_improved <- player_sum[!is.na(FT_Pct_Improvement)][order(desc(FT_Pct_Improvement))][1:3]

  PlayerFTServer(id= "first_player_impv",valOne = most_improved[1]$player, valTwo = paste0(most_improved[1]$FT_Pct_Improvement,"%"))
  PlayerFTServer(id= "second_player_impv",valOne = most_improved[2]$player, valTwo = paste0(most_improved[2]$FT_Pct_Improvement,"%"))
  PlayerFTServer(id= "third_player_impv",valOne = most_improved[3]$player, valTwo = paste0(most_improved[3]$FT_Pct_Improvement,"%"))

###############################################

  tot_made <- reactive({

  #df <- as.data.table(datasetInput_nba())
  player_ft_mode <- datasetInput_nba()[, keyby = .(season, playoffs), .(tot_made = sum(Total_FT_Made, na.rm = T))]
  player_ft_mode <- player_ft_mode %>% pivot_wider(names_from = "playoffs", values_from = "tot_made")
  return(player_ft_mode)

   })


  mod_line_server(id = "seasonal_ft",df = tot_made, x_col = 'season', y_cols = c('playoffs', 'regular'),chart_title = "Season Wise FT Made",type = "line")


  ft_avg_game <- reactive({
    freeThrough_nba()[, keyby = .(season, playoffs), .(avg_ft_game = round(.N/uniqueN(game_id),0))] %>%
                          dcast(season ~ playoffs, value.var = "avg_ft_game")

              })

  mod_line_server(id = "ft_per_game",df = ft_avg_game, x_col = 'season', y_cols = c('playoffs', 'regular'),
                  chart_title = "Average Number of Free Throws per Game by Season",type = "line")




  ft_avg_period <- reactive({

    ft_attempts <- freeThrough_nba()[,keyby = .(game_id, period, playoffs), .(avg_ft_pd = .N)]
    avg_ft_per_period <- ft_attempts[, .(Avg_FT_Attempted = round(mean(avg_ft_pd),0)), keyby = .(period,playoffs)] %>%
      dcast(period~playoffs, value.var = "Avg_FT_Attempted")

    return(avg_ft_per_period)

  })

  mod_line_server(id = "ft_per_period",df = ft_avg_period, x_col = 'period', y_cols = c('playoffs', 'regular'),
                  chart_title = "Average Number of Free Throws per Period",type = "line")





shooting_stats <- reactive({

  shooting_stats <- freeThrough_nba()[, keyby = .(player), .(FT_Attempts = .N,FT_Percentage = mean(shot_made))][FT_Attempts>100]


})

mod_hist_server(id = "ft_per_period",df = shooting_stats, x_col = 'FT_Percentage',
                chart_title = "Distribution of Shooting Percentages")



success_rate_rc <- reactive({

                    success_rate <- freeThrough_nba()[][, keyby = .(player), .(tot_atm = .N,
                                                  tot_shot_made = sum(shot_made,
                                                                      na.rm = T))][tot_atm>100][, Succ_pct:=
                                                                                                  .(round(tot_shot_made*100/tot_atm,1))][order(desc(Succ_pct))][1:40]

                    success_rate <- success_rate[, rank := .I][,.(player, Succ_pct, rank)]

                    })


reactable_server(id = "player_ranking_table",df = success_rate_rc, col1 = "Succ_pct")









}

PlayerFTUI <- function(id) {
  ns <- NS(id)  # Create a namespace for the module

  tagList(
    uiOutput(ns("third_player_ft"))  # Use ns() to namespace the output
  )
}


PlayerFTServer <- function(id, valOne, valTwo, icon = "fas fa-basketball-ball") {
    moduleServer(id, function(input, output, session) {
      # server logic here


  output$third_player_ft <- renderUI({

    print("---------------------------------")

    # Assuming 'player_sum' is available globally or passed as an input to the module
    # top_three <- player_sum[playoffs == "playoffs"][, keyby = .(player), .(FT_perc = round(Total_FT_Made * 100 / Total_FTA, 0))][order(desc(FT_perc))][1:3][3]
    # print(top_three)

    descriptionBlock(
      numberColor = "gray",
      numberIcon = tags$i(
        class = icon,  # More appropriate NBA-style icon
        style = "font-size: 24px;"
      ),
      header = tags$span(
        style = "color:white; font-size:28px; font-weight:bold; font-family:sans-serif;",
        paste0(valOne)
      ),
      text = tags$span(
        style = "color:white; font-size:16px; font-family:sans-serif;",
        paste0(valTwo)
      ),
      rightBorder = FALSE,
      marginBottom = FALSE
    )

  })
    })
}

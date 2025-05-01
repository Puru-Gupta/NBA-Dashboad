library(shinytest2)

test_that("{shinytest2} recording: ShinyTutorial_v2", {
  app <- AppDriver$new(name = "ShinyTutorial_v2", height = 735, width = 1406)
  app$expect_values(output = "first_player_ft-third_player_ft")
  app$set_inputs(sidebarMenuid = "up_page")
  app$expect_values(output = "ft_per_period-hist_id")
})



test_that("{shinytest2} recording: ShinyTutorial_test2", {
  app <- AppDriver$new(name = "ShinyTutorial_test2", height = 735, width = 1406)
  app$expect_values(output = "second_player_impv-third_player_ft")
  app$set_inputs(sidebarMenuid = "up_page")
  app$set_inputs(gametype = character(0))
  app$set_inputs(gametype = "regular")
  app$expect_values(output = "player_ranking_table-city_aqi")
})


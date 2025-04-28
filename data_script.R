# Load data
free_throw <- as.data.table(read_parquet("./data/free_throws.parquet"))

# Preprocess data
free_throw$flag <- 1

player_sum <- free_throw[, c("Game_Type_Regular", "Game_Type_Playoffs") := .(
  ifelse(playoffs == "regular", 1, 0),
  ifelse(playoffs == "playoffs", 1, 0)
)]

player_sum <- player_sum[, keyby = .(player, season, playoffs), .(
  Game_Type_Regular_Tot = sum(Game_Type_Regular, na.rm = TRUE),
  Game_Type_Playoffs_Tot = sum(Game_Type_Playoffs, na.rm = TRUE),
  Shot_Made = sum(shot_made, na.rm = TRUE),
  Total_Game_Played = uniqueN(game_id),
  Total_FT_Made = sum(shot_made, na.rm = TRUE),
  Total_FTA = .N,
  FT_Pct = round(sum(shot_made, na.rm = TRUE) / .N, 3),
  Game_Type = playoffs
)]

player_sum <- player_sum[Total_Game_Played > 10]

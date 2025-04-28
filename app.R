# Load libraries
library(shiny)
library(tidyverse)
library(data.table)
library(shinyWidgets)
library(shinycssloaders)
library(arrow)

library(RColorBrewer)
library(htmltools)
library(tidyr)
library(stringr)
library(shinyjs)
library(shinyBS)
library(highr)
library(highcharter)
library(reactable)

library(profvis)
library(shinytest2)



library(bs4Dash)
library(dplyr)
library(readr)
library(DT)
library(fresh)

#plot_colour <- "#8965CD"

# theme <- create_theme(
#   bs4dash_color(
#     lime = "#52A1A5",
#     olive = "#4A9094",
#     purple = "#8965CD"
#   ),
#   bs4dash_status(
#     primary = "#E1EDED",
#     info = "#E4E4E4"
#   )
# )

plot_colour <- "#1D428A"  # Deep NBA Blue (Warriors/76ers style)

theme <- create_theme(
  bs4dash_color(
    lime = "#C8102E",    # Gold - energetic, sporty
    olive = "#FFC72C",   # Deep red (NBA/NFL classic)
    purple = "#582C83"   # Lakers-style dark purple
  ),
  bs4dash_status(
    primary = "#52A1A5",  # Light grey (clean dashboard background)
    info = "#4A9094",      # Slightly darker grey for panels
  )
)




#############################################################


# Load modules
source("./data_script.R")
source("./modules/userbox_module.R")
source("./modules/mod_line_charts.R")
source("./modules/histogram_module.R")
source("./modules/reactable_module.R")

# Load UI and Server
source("ui.R")
source("server.R")



# Run the app
shinyApp(ui = ui, server = server)

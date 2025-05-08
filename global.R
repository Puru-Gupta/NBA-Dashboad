# Load libraries
library(shiny)
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

###########################


plot_colour <- "#1D428A"  # Deep NBA Blue (Warriors/76ers style)

theme <- create_theme(
  bs4dash_color(
    lime = "#274B8C",    # Gold - energetic, sporty
    olive = "#274B8C",   # Deep red (NBA/NFL classic)
    purple = "#582C83"   # Lakers-style dark purple
  ),
  bs4dash_status(
    primary = "#274B8C",  # Light grey (clean dashboard background)
    info = "#274B8C",      # Slightly darker grey for panels
  )
)



source(file.path("data_script.R"))

source(file.path("modules", "userbox_module.R"))
source(file.path("modules", "mod_line_charts.R"))
source(file.path("modules", "histogram_module.R"))
source(file.path("modules", "reactable_module.R"))


# Load UI and Server
# source(file.path("ui.R"))
# source(file.path("server.R"))

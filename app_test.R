#############################################################


# Load modules
source(file.path("global.R"))
source(file.path("data_script.R"))

source(file.path("modules", "userbox_module.R"))
source(file.path("modules", "mod_line_charts.R"))
source(file.path("modules", "histogram_module.R"))
source(file.path("modules", "reactable_module.R"))


# Load UI and Server
source(file.path("ui.R"))
source(file.path("server.R"))






# Run the app
shinyApp(ui = ui, server = server)

# ui.R

reactable_ui <- function(id) {
  ns <- NS(id)
  box(
    title = "Best 40 successful shooters",
    closable = FALSE,
    width = 12,
    height = "385px",
    solidHeader = FALSE,
    status = "success",
    tabsetPanel(
      type = "tabs",
      tabPanel("City",  reactableOutput(ns("city_aqi")) %>% withSpinner(color="#0dc5c1"))
      #tabPanel("Stations", reactableOutput(ns("station_aqi")) %>% withSpinner(color="#0dc5c1"))
    )
  )
}


# server.R

# server.R

reactable_server <- function(id, df, col1) {
  moduleServer(id, function(input, output, session) {




    # Function to generate bar charts for AQI values
    bar_chart <- function(label, width = "100%", height = "16px", fill = "#00bfc4", background = NULL) {
      bar <- div(style = list(background = fill, width = width, height = height))
      chart <- div(style = list(flexGrow = 1, marginLeft = "2px", background = background), bar)
      div(style = list(display = "flex", alignItems = "left"), label, chart)
    }

    output$city_aqi <- renderReactable({

      df_data <- df()  # Calling the dynamic data frame passed to the module

      column_names = colnames(df_data)

      reactable(
        df_data,
        pagination = FALSE,
        searchable = TRUE,
        defaultPageSize = 20,
        height = 280,
        defaultColDef = colDef(headerClass = "header", align = "left"),
        columns = list(
          Player = colDef(
            name = column_names[1],
            cell = function(value) { value },
            width = 120
          ),
          Succ_pct = colDef(
            name = column_names[2],
            defaultSortOrder = "desc",
            align = "left",
            cell = function(value) {
              # Normalize the value between 0 and 1
              normalized_value <- (value - min(df_data[[col1]])) / (max(df_data[[col1]]) - min(df_data[[col1]]))

              # Create a green color gradient (dark green for top, light green for lower)
              color <- colorRampPalette(c("darkred", "red", "orange", "yellow", "green", "darkgreen"))(100)
              fill_color <- color[round(normalized_value * 99) + 1]  # +1 because R indexes from 1

              # Create bar chart
              bar_chart(
                value,
                width = paste0(value * 100 / max(df_data[[col1]]), "%"),
                fill = fill_color,
                background = "#e1e1e1"
              )
            },
            style = list(fontFamily = "helvetica", fontWeight = "bold")
          ),
          rank = colDef(
            name = column_names[3],
            cell = function(value) {
              value
            },
            style = list(fontFamily = "helvetica", whiteSpace = "pre", fontWeight = "bold"),
            width = 80
          )
        ),
        defaultSorted = list(Succ_pct = "desc"),
        compact = TRUE,
        fullWidth = TRUE,
        showPageSizeOptions = TRUE,
        highlight = TRUE,
        class = "followers-tbl"
      )


    })
  })
}


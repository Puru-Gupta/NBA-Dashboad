# Line Chart UI
mod_line_ui <- function(id, title = "Write chart title here") {
  ns <- NS(id)

  tagList(
    box(
      title = title,
      solidHeader = FALSE,
      collapsible = TRUE,
      collapsed = FALSE,
      status = "success",
      width = 12,
      highchartOutput(ns("avg_aqi_id"), height = "350px")
    )
  )
}

# Line Chart Server
mod_line_server <- function(id, df, x_col, y_cols, chart_title, type = "line") {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$avg_aqi_id <- renderHighchart({
      req(df())  # Check reactive input exists

      # Strong validation
      shiny::validate(
        need(nrow(df()) > 0, "There is no data to show! Kindly select something else!"),
        need(x_col %in% names(df()), paste0("Column ", x_col, " not found in data!")),
        need(all(y_cols %in% names(df())), "Some y-axis columns not found in data!")
      )

      df_data <- df()  # Store once

      # Create highchart
      hc <- highchart() %>%
        hc_chart(type = type) %>%
        hc_title(text = chart_title) %>%
        hc_xAxis(
          categories = df_data[[x_col]],
          title = list(text = x_col)
        ) %>%
        hc_yAxis(
          # Removed fixed logarithmic
          title = list(text = "Value"),
          allowDecimals = TRUE
        )

      # Add all Y series
      for (col in y_cols) {
        hc <- hc %>%
          hc_add_series(
            name = col,
            data = df_data[[col]],
            type = type
          )
      }

      # Final chart options
      hc %>%
        hc_plotOptions(
          series = list(
            dataLabels = list(enabled = FALSE),
            showInLegend = TRUE
          )
        ) %>%
        hc_tooltip(shared = TRUE, crosshairs = TRUE) %>%
        hc_exporting(enabled = TRUE) %>%
        hc_credits(
          enabled = TRUE,
          text = "Source: UPPCB (2021-22)",
          href = "http://www.uppcb.com/",
          style = list(fontSize = "9px")
        ) %>%
        hc_legend(enabled = TRUE)
    })
  })
}

## To be copied in the UI
# mod_line_ui("create_box_1", title = "Chart Title Here")

## To be copied in the server
# mod_line_server("create_box_1", df = your_data, x_col = "YourX", y_cols = c("YourY1", "YourY2"), chart_title = "Your Chart Title")

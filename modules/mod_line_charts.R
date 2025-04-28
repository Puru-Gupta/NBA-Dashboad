
mod_line_ui <- function(id, title = "write chart title here") {
  ns <- NS(id)
  tagList(



      box(title = title,
          solidHeader = FALSE,
          collapsible = TRUE,
          collapsed = FALSE,
          status = "success",
          width = 12,
          highchartOutput(ns("avg_aqi_id"), height = "350px")
          )





  )
}



mod_line_server <- function(id, df, x_col, y_cols, chart_title, type = "line") {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$avg_aqi_id <- renderHighchart({
      req(df())


      shiny::validate(

        need(nrow(df()) >0, "There is no data to show! Kindly select something else!" )

      )


      if(nrow(df()) == 0){

        return()

      } else{

        shiny::validate(
          need(nrow(df()), "There is no data to show!")
        )

      df_data <- df()


      hc <- highchart() %>%
        hc_chart(type = type) %>%
        hc_title(text = chart_title) %>%
        hc_xAxis(
          categories = df_data[[x_col]],
          title = list(text = x_col)
        ) %>%
        hc_yAxis(
          type = "logarithmic",
          title = list(text = "Value"),
          allowDecimals = FALSE
        )

      for (col in y_cols) {
        hc <- hc %>%
          hc_add_series(
            name = col,
            data = df_data[[col]],
            type = type
          )
      }

      hc %>%
        hc_plotOptions(
          line = list(
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
      }
    })
  })
}


## To be copied in the UI
# mod_line_ui("create_box_1")

## To be copied in the server
# mod_line_server("create_box_1")

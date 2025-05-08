mod_hist_ui <- function(id, title =  "write chart title here") {
  ns <- NS(id)
  tagList(



    box(title = title,
        solidHeader = FALSE,
        collapsible = TRUE,
        collapsed = FALSE,
        status = "navy",
        width = 12,
        highchartOutput(ns("hist_id"), height = "350px")
    )





  )
}


mod_hist_server <- function(id, df, x_col, chart_title) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$hist_id <- renderHighchart({
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


        hc <- hchart(
          df_data[[x_col]],
          color = "#B71C1C", name = "Weight") %>%
         # hc_chart(type = type) %>%
          hc_title(text = chart_title) %>%
          # hc_xAxis(
          #   categories = df_data[[x_col]],
          #   title = list(text = x_col)
          # ) %>%


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










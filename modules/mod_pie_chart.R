
mod_pie_chart_ui <- function(id) {
  ns <- NS(id)
  tagList(



      box(title = "CBOs Type Distributions",
          solidHeader = FALSE,
          collapsible = TRUE,
          collapsed = FALSE,
          status = "navy",
          width = 5,
          highchartOutput(ns("cbo_type"), height = "350px")
      )




  )
}


mod_pie_chart_server <- function(id, df, x_col, y_cols){
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    output$cbo_type <- renderHighchart({

      shiny::validate(

        need(nrow(df()) >0, "There is no data to show! Kindly select something else!" )

      )


      if(nrow( df()) == 0){

        return()

      } else{

        # df_temp <- df_current_up_predominant
        #
        # df_temp <- df_temp %>% filter( city %in% get_df()$city, station_name %in% get_df()$station_name)



        shiny::validate(
          need(nrow(df()), "There is no data to show!")
        )

        df_data <- df()

        hchart(df_data,
               'pie', hcaes(x = TYPE_SHORT_NAME, y = count
               )
        ) %>%
          # hc_title(text = paste0(span(" (","Total Cadre(s) =",format(sum(data$count, na.rm = T), nsmall=0, big.mark=","),")", style="color:#e32c3e")),
          #          style = list(fontWeight = "bold"),align = "center"
          #          # hc_yAxis(type = "logarithmic",
          #          #          title = list(text = "Cadre count"),
          #          #          labels = list(format = "{value}")
          # ) %>%

          hc_yAxis(
            title = list(text = "No. of CBO(s)")) %>%
          hc_tooltip(
            pointFormat = "
    Total: {point:y}<br>"
          ) %>% hc_exporting(enabled = TRUE) %>% hc_credits(enabled = TRUE,
                                                            text = "Source: CBO MIS, BRLPS (2020-21)",
                                                            href = "https://www.brlps.in/",
                                                            style = list(fontSize = "9px")) %>%

          hc_plotOptions( pie = list(#colors = brewer.pal(6,"Set2"),
                                     # type = "pie",
                                     #name = "No. of Calls",
                                    # colorByPoint = TRUE,
                                     showInLegend = TRUE,
                                     # center = c('55%', '50%'),
                                     size = 200,
                                     dataLabels = list(enabled = TRUE,
                                                       format = '{point.name}: ({point.percentage:.2f}%)'

                                     ))) %>% hc_legend(enabled = TRUE, align = "left",
                                                       verticalAlign = "top",
                                                       layout = "vertical",
                                                       x = 0,
                                                       y = 100)

      }


    })




  })
}

## To be copied in the UI
# mod_pie_chart_ui("pie_chart_1")

## To be copied in the server
# mod_pie_chart_server("pie_chart_1")

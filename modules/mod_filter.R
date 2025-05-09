
mod_filter_ui <- function(id, data) {
  ns <- NS(id)
  tagList(

    fluidRow(

      column(width = 3, offset = 0,

             pickerInput(
               ns("city"),label = 'Select District(s):',
               choices = sort(unique(data$DISTRICT_NAME_ID)),
               selected = sort(unique(data$DISTRICT_NAME_ID)),
               multiple = TRUE,
               options = list(
                 `actions-box` = TRUE,
                 size = 8,
                 `selected-text-format` = "count > 2",
                 `live-search`=TRUE
               ))

      ),

      column(width = 3, offset = 0,

             pickerInput(
               ns("station"),label = 'Select Block(s):',
               choices = "",
               selected = "",
               multiple = TRUE,
               options = list(
                 `actions-box` = TRUE,
                 size = 8,
                 `selected-text-format` = "count > 2",
                 `live-search`=TRUE
               ))

      ),

      column(width = 3, offset = 0,

             pickerInput(
               ns("year"),label = 'Select Year(s):',
               choices = "",
               selected = "",
               multiple = TRUE,
               options = list(
                 `actions-box` = TRUE,
                 size = 8,
                 `selected-text-format` = "count > 2",
                 `live-search`=TRUE
               ))

      ),

      column(width = 2, style = "display: flex; align-items: center; height: 100%;",
             div(
               style = "margin-top: 25px;",  # Optional: tweak this to align better with inputs
               actionButton(ns("filt_btn"), label = "Apply Filter"))
      )


    )



  )
}


mod_filter_server <- function(id, data){
  moduleServer(id, function(input, output, session){

    ns <- session$ns
    # observeEvent(input$filt_btn, {

    rv_city      <- reactiveValues()
    rv_station   <- reactiveValues()
    rv_year      <- reactiveValues()



    isolate({
      rv_city$city       <- input$city
      rv_station$station <- input$station
      rv_year$year       <- input$year
    })

    #observeEvent(input$filt_btn, {

    observeEvent(rv_city$city, {
      updatePickerInput(session, inputId = "station",
                        label = "Select Station(s):",
                        choices = unique(data[DISTRICT_NAME_ID %in% input$city, BLOCK_NAME_ID]),
                        selected = unique(data[DISTRICT_NAME_ID %in% input$city, BLOCK_NAME_ID]))
    })



    observeEvent(rv_station$station, {
      updatePickerInput(session, inputId = "year",
                        label = "Select Year(s):",
                        choices = unique(data[BLOCK_NAME_ID %in% input$station, Year]),
                        selected = unique(data[BLOCK_NAME_ID %in% input$station, Year]))
    })



    observe({


      if(!isTRUE(input$city_open) & !isTRUE(input$station_open) & !isTRUE(input$year_open))

      {

        rv_city$city <- input$city
        rv_station$station <- input$station
        rv_year$year <- input$year

      }

    })



    initial <- reactiveVal(TRUE)

    filtered_data <- reactive({
      if (initial()) {
        # First launch: show full data
        data
      } else {
        # After first launch: only on button click
        req(input$city, input$station, input$year)
        data[
          DISTRICT_NAME_ID %in% input$city &
            BLOCK_NAME_ID %in% input$station &
            Year %in% input$year
        ]
      }
    })

    # Change initial flag after first button click
    observeEvent(input$filt_btn, {
      initial(FALSE)
    })

    return(list(filtered_data = filtered_data))
  })
}

## To be copied in the UI
# mod_filter_ui("filter_1")

## To be copied in the server
# mod_filter_server("filter_1")

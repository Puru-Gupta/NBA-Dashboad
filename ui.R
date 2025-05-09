ui <-
  dashboardPage(
    title = "NBA|Analysis",

    freshTheme = theme,
    dark = NULL,
    help = NULL,
    fullscreen = TRUE,
    scrollToTop = TRUE,

    # Header ----
    header = dashboardHeader(
      status = "lime",
      title = dashboardBrand(
        title = "NBA FT Analysis",
        color = "olive",
        image = "https://iili.io/3eMxpJ1.jpg"
      ),
      controlbarIcon = icon("circle-info"),
      fixed = TRUE,
      rightUi = dropdownMenu(
        badgeStatus = "info",
        type = "notifications",
        notificationItem(
          text = "Success",
          status = "success",
          icon = icon("circle-check")
        ),
        notificationItem(
          text = "Warning",
          status = "warning",
          icon = icon("circle-exclamation")
        ),
        notificationItem(
          text = "Error",
          status = "danger",
          icon = icon("circle-xmark")
        )
      )
    ),

    # Sidebar ----
    sidebar = dashboardSidebar(
      sidebarMenu(
        id = "sidebarMenuid",
        menuItem(
          "Home",
          tabName = "glance_page",
          icon = icon("home")
        ),
        menuItem(
          "Dashboard",
          tabName = "up_page",
          icon = icon("bar-chart")
        )
      )
    ),

    # Control bar ----
    controlbar = dashboardControlbar(),

    # Footer ----
    footer = dashboardFooter(
      left = "Ashleigh Latter",
      right = "2024"
    ),

  body = dashboardBody(

    tags$head(
      # Link to custom CSS
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),

    # tags$head(
    #   # Link to custom JavaScript
    #   tags$script(src = "scripts.js")
    # ),




    tabItems(
      tabItem(
        tabName = "up_page",


    fluidRow(

      column(width = 3, offset = 0,

             pickerInput(
               ("season"),label = 'Select Season(s):',
               choices = sort(unique(free_throw$season)),
               selected = sort(unique(free_throw$season)),
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
               ("gametype"),label = 'Select Game Type(s):',
               choices = "",
               selected = "",
               multiple = TRUE,
               options = list(
                 `actions-box` = TRUE,
                 size = 8,
                 `selected-text-format` = "count > 1",
                 `live-search`=TRUE
               ))

      ),

      # column(width = 2, style = "display: flex; align-items: center; height: 100%;",
      #        div(
      #          style = "margin-top: 25px;",  # Optional: tweak this to align better with inputs
      #          actionButton(("filt_btn"), label = "Apply Filter"))
      # )

    ),

    fluidRow(
      column(width=7, offset = 0,
             reactable_ui(id = "player_ranking_table")),

      column(width=5, offset = 0,
             mod_hist_ui("ft_per_period", title = "Distribution of Shooting Percentages"))



    ),

    fluidRow(

      column(width=6, offset = 0,
        mod_line_ui("seasonal_ft",title = "Season Wise FT Made")),

      column(width=6, offset = 0,
        mod_line_ui("ft_per_game",title = "Average Number of Free Throws per Game by Season"))

    ),

    fluidRow(

      column(width=6, offset = 0,
             mod_line_ui("ft_per_period",title = "Average Number of Free Throws per Period")),



    )





    ),


    tabItem(
      tabName = 'glance_page',

      userBox(
        title = userDescription(
          title = tags$span(style="color:white; font-size:32px; font-family:sans-serif;", "NBA Free Throw at Glance"),
          subtitle = "Top 3 Players by FT% - NBA",
          type = 2,
          image = "https://media.giphy.com/media/XEFViEQqEKPSOYPotM/giphy.gif"
        ),
        status = "maroon",
        collapsed = TRUE,
        width = 12,

        # 🚨 FIX: Add fluidRow here
        fluidRow(
          column(width = 4,
                 boxPad(
                   color = "olive",
                  # boxLabel(status = "primary", text = "BTDP"),
                   PlayerFTUI("first_player_ft"),
                   hr(),
                   PlayerFTUI("first_player_pf")
                 )
          ),
          column(width = 4,
                 boxPad(
                   color = "teal",
                   PlayerFTUI("second_player_ft"),
                   hr(),
                   PlayerFTUI("second_player_pf")
                 )
          ),
          column(width = 4,
                 boxPad(
                   color = "indigo",
                   PlayerFTUI("third_player_ft"),
                   hr(),
                   PlayerFTUI("third_player_pf")
                 )
          )
        )
      ),


  # userBox(
  #
  #   title = userDescription(
  #     title = tags$span(style="color:white; font-size:32px; font-family:sans-serif;", "NBA Free Throw at Glance"),
  #
  #     subtitle = "Top 3 Players by FT% - NBA",
  #     type = 2 ,
  #     image = "https://media.giphy.com/media/XEFViEQqEKPSOYPotM/giphy.gif"
  #     # image = tags$img(src="https://giphy.com/clips/xbox-minecraft-xbox-series-x-villager-S4eCYlu0J36Na3oRUX", align = "left",height='50px',width='50px')
  #   ),
  #
  #   status = "maroon",
  #   collapsed = FALSE,
  #   width = 12,
  #
  #   #boxLabel("text", "primary", style = "default"),
  #
  #   column( width = 4,
  #           # box(
  #
  #           boxPad(
  #             color = "olive",
  #             # ,
  #             # column(
  #             #   width = 4,
  #             boxLabel(status = "primary", text = "BTDP"),
  #
  #
  #             PlayerFTUI("first_player_ft"),
  #             hr(),
  #             PlayerFTUI("first_player_pf"),
  #
  #           ) #boxPad closes here
  #
  #   ),
  #
  #
  #   column( width = 4,
  #           # box(
  #           boxPad(
  #             color = "fuchsia",
  #             # ,
  #             # column(
  #             #   width = 4,
  #             #boxLabel("NRETP", "warning", style = "default"),
  #
  #             PlayerFTUI("second_player_ft"),
  #             hr(),
  #             PlayerFTUI("second_player_pf"),
  #
  #
  #           ) #boxPad closes here
  #
  #   ),
  #
  #   column( width = 4,
  #           # box(
  #           boxPad(
  #             color = "primary",
  #             # ,
  #             # column(
  #             #   width = 4,
  #             #boxLabel(( "NRLM"), "warning", style = "default"),
  #
  #             PlayerFTUI("third_player_ft"),
  #             hr(),
  #             PlayerFTUI("third_player_pf"),
  #
  #
  #
  #           ) #boxPad closes here
  #
  #   )
  #
  #
  # ),


  userBox(

    title = userDescription(
      title = tags$span(style="color:white; font-size:32px; font-family:sans-serif;", "NBA Free Throw at Glance"),

      subtitle = "Most Free Throws Made: NBA(Player who made the most free throws)",
      type = 2 ,
      image = "https://media.giphy.com/media/XEFViEQqEKPSOYPotM/giphy.gif"
      # image = tags$img(src="https://giphy.com/clips/xbox-minecraft-xbox-series-x-villager-S4eCYlu0J36Na3oRUX", align = "left",height='50px',width='50px')
    ),

    status = "navy",
    collapsed = TRUE,
    width = 12,

    #boxLabel("text", "primary", style = "default"),
    fluidRow(
    column( width = 4,
            # box(

            boxPad(
              color = "olive",
              # ,
              # column(
              #   width = 4,
              #boxLabel(("Top"),status =  "warning"),


              PlayerFTUI("first_player_ftmade")
              # hr(),
              # PlayerFTUI("first_player_pf"),

            ) #boxPad closes here

    ),


    column( width = 4,
            # box(
            boxPad(
              color = "teal",
              # ,
              # column(
              #   width = 4,
              # boxLabel("NRETP", "warning", style = "default"),

              PlayerFTUI("second_player_ftmade")



            ) #boxPad closes here

    ),

    column( width = 4,
            # box(
            boxPad(
              color = "primary",
              # ,
              # column(
              #   width = 4,
              # boxLabel(( "NRLM"), "warning", style = "default"),

              PlayerFTUI("third_player_ftmade")
              # hr(),




            ) #boxPad closes here

    )
    )


  ),



  userBox(

    title = userDescription(
      title = tags$span(style="color:white; font-size:32px; font-family:sans-serif;", "Most Improved Free Throw Shooter"),

      subtitle = "Top 3 Players by FT% - NBA",
      type = 2 ,
      image = "https://media.giphy.com/media/XEFViEQqEKPSOYPotM/giphy.gif"
      # image = tags$img(src="https://giphy.com/clips/xbox-minecraft-xbox-series-x-villager-S4eCYlu0J36Na3oRUX", align = "left",height='50px',width='50px')
    ),

    status = "purple",
    collapsed = TRUE,
    width = 12,

    #boxLabel("text", "primary", style = "default"),
    fluidRow(
    column( width = 4,
            # box(

            boxPad(
              color = "olive",
              # ,
              # column(
              #   width = 4,
              # boxLabel(("Top"),status =  "warning"),


              PlayerFTUI("first_player_impv")

            ) #boxPad closes here

    ),


    column( width = 4,
            # box(
            boxPad(
              color = "teal",

              # boxLabel("NRETP", "warning", style = "default"),

              PlayerFTUI("second_player_impv")
              # hr(),


            ) #boxPad closes here

    ),

    column( width = 4,
            # box(
            boxPad(
              color = "primary",

              # boxLabel(( "NRLM"), "warning", style = "default"),

              PlayerFTUI("third_player_impv")




            ) #boxPad closes here

    )
    )


  )





))
)


)

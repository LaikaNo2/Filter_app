##
shinyUI(
 navbarPage("Filter App",
  tabPanel("Transmission",
   sidebarLayout(
    sidebarPanel(
        # tabs on sidebar panel
        tabsetPanel(type = "pills", selected = "Data",
            # Tab 1: Data Transmission
            tabPanel("Data",
                  tags$hr(),
                  strong("Select filters"),
                  chooserInput("filterInput", "Filters available:", "Filters chosen:", filters, c(),
                               multiple = TRUE,  size = 5),
                  tags$hr(),
                  radioButtons(
                    "stimulationInput",
                    label = "Stimulation",
                    choices =
                      c("None" = "NA",
                        "Violet: 405 ∆ 3 nm " = "violett",
                        "Blue: 458 ∆ 3 nm" = "blue",
                        "Green: 525 ∆ 20 nm" = "green",
                        "Infrared: 850 ∆ 3 nm" = "infrared")
                    )
            ), # End Tab 1

            # Tab 2: Export plots + datatable Transmission
            tabPanel("Export",
                     tags$hr(),
                  textInput(
                    "filename",
                    label = "Filename",
                    value = "Enter filename..."),
                  tags$hr(),
                  fluidRow(
                          column(6,
                           numericInput(
                             "widthInput",
                             label = "Image width",
                             value = 7
                             )),
                          column(6,
                          numericInput(
                             "heightInput",
                             label = "Image height",
                             value = 7
                             ))),
                  downloadButton("exportPlot", label = "Download plot as PDF"),
                  tags$hr(),
                  downloadButton("exportTable", label = "Download rawdata as CSV")
            ), # End Tab 2

            # Tab 3: Plot Options Transmission
            tabPanel("Plot Options",
                     tags$hr(),
                     textInput("main",
                               label = "Plot title",
                               value = "Filter Combinations"),
                     tags$hr(),
                     sliderInput("range",
                                 "Wavelength range",
                                 min = 200,
                                 max = 1000,
                                 value = c(200, 1000)),
                     checkboxInput(inputId = "legend",
                                   label = "Show legend",
                                   value = TRUE)


            ) # End Tab 3

            )),



    mainPanel(span(textOutput("warningtext"), style = "color:red; font-size:15px", align = "center"),
              plotOutput("filterPlot"),
              tableOutput("metadata")
              )
   )
  ),
  tabPanel("Optical Density",
   sidebarLayout(
     sidebarPanel(
       # tabs on sidebar Panel
       tabsetPanel(type = "pills", selected = "Data & Plot Options",
                   # Tab 1: Data Optical Density
                   tabPanel("Data & Plot Options",
                            tags$hr(),
                            selectInput("opticaldensity", label = "Select filters",
                                        choices = filters),
                            tags$hr(),
                            textInput("mainOD",
                                      label = "Plot title",
                                      value = "Filter"),
                            sliderInput("rangeOD",
                                        "Wavelength range",
                                        min = 200,
                                        max = 1000,
                                        value = c(200, 1000))



                   ), # End Tab 1
                   # Tab 2: Plot Options Optical Density
                   tabPanel("Export",
                            tags$hr(),
                            textInput(
                              "filenameOD",
                              label = "Filename",
                              value = "Enter filename..."),
                            fluidRow(
                              column(width = 6,
                                     numericInput(
                                       "widthInputOD",
                                       label = "Image width",
                                       value = 7)
                              ),
                              column(width = 6,
                                     numericInput(
                                       "heightInputOD",
                                       label = "Image height",
                                       value = 7)
                              )
                            ),
                            downloadButton("exportPlotOD", label = "Download plot as PDF"),
                            tags$hr(),
                            downloadButton("exportTableOD", label = "Download rawdata as CSV")
        )
       )
     ),
    mainPanel(span(textOutput("warningtextOD"), style = "color:red; font-size:15px", align = "center"),
      plotOutput("densityPlot")
    )
   )
  ),

  tabPanel("Downloads", downloadLink("MasterFile",label = "Download Filterdatabase", icon = "download"))
)
)


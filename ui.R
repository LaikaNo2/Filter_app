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
                  div(h5("Data Selection"), align = "center"),
                  strong("Select filters"),
                  chooserInput("filterInput", "Filters available:", "Filters chosen:", filters, c(),
                               multiple = TRUE,  size = 5),
                  numericInput(
                    "thicknessInput",
                    label = "Filter thickness",
                    value = 0,
                    min = 0,
                    max = 50),
                  numericInput(
                    "reflectionInput",
                    "ReflectionFactor",
                    value = 0,
                    min = 0,
                    max = 5),
                  radioButtons(
                    "stimulationInput",
                    label = "Select Stimulation Unit",
                    choices =
                      c("None" = "NA",
                        "LD Violett" = "violett",
                        "LED Blue" = "blue",
                        "LED Green" = "green",
                        "LED Infrared" = "infrared")
                    )
            ), # End Tab 1

            # Tab 2: Export plots + datatable Transmission
            tabPanel("Data Export",
                  div(h5("Download PDF"), align = "center"),
                  textInput(
                    "filename",
                    label = "Filename",
                    value = "Enter filename..."),
                  fluidRow(
                    column(width = 6,
                           numericInput(
                             "widthInput",
                             label = "Image width",
                             value = 7)
                    ),
                    column(width = 6,
                           numericInput(
                             "heightInput",
                             label = "Image height",
                             value = 7)
                    )
                  ),
                  downloadButton("exportPlot", label = "Download Plot"),

                  div(h5("Download CSV"), align = "center"),
                  textInput(
                    "filenameCSV",
                    label = "Filename",
                    value = "Enter filename..."),
                  downloadButton("exportTable", label = "Download Datatable")
            ), # End Tab 2

            # Tab 3: Plot Options Transmission
            tabPanel("Plot Options",
                     div(h5("Plot Adjustment"), align = "center"),
                     textInput("main",
                               label = "Plot title",
                               value = "Filter Combinations"),
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



    mainPanel(plotOutput("filterPlot"),
              tableOutput("metadata"))
   )
  ),
  tabPanel("Optical Density",
   sidebarLayout(
     sidebarPanel(
       # tabs on sidebar Panel
       tabsetPanel(type = "pills", selected = "Data & Export",
                   # Tab 1: Data Optical Density
                   tabPanel("Data & Export",
                            div(h5("Data Selection"), align = "center"),
                            selectInput("opticaldensity", label = "Select filters",
                                        choices = filters,
                                        selected = "HU01_HEBO"),

                            div(h5("Download PDF"), align = "center"),
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
                            downloadButton("exportPlotOD", label = "Download Plot"),

                            div(h5("Download CSV"), align = "center"),
                            textInput(
                              "filenameCSVOD",
                              label = "Filename",
                              value = "Enter filename..."),
                            downloadButton("exportTableOD", label = "Download Datatable")


                   ), # End Tab 1
                   # Tab 2: Plot Options Optical Density
                   tabPanel("Plot Options",
                            div(h5("Plot Adjustment"), align = "center"),
                            textInput("mainOD",
                                      label = "Plot title",
                                      value = "Filter"),
                            sliderInput("rangeOD",
                                        "Wavelength range",
                                        min = 200,
                                        max = 1000,
                                        value = c(200, 1000))

                   )


       )
     ),

    mainPanel(plotOutput("densityPlot"))
   )
  ),


  tabPanel(downloadLink("MasterFile",label = "Download Filterdatabase")


 )
)
)


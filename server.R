##
shinyServer(function(input, output) {

  # Transmission: Prepare data + plot
  output$filterPlot <- renderPlot({
    if (length(input$filterInput$right) != 0) {
      data <- lapply(input$filterInput$right, function(x) {
        as.matrix(readxl::read_excel(
          path = "Data/FilterDataBase_Bdx.xlsx",
          sheet = x,
          skip = 14
        ))

      })

      plot_FilterCombinations(filters = data,
                              d = input$thicknessInput,
                              P = input$reflectionInput,
                              xlim = input$range,
                              main = input$main,
                              legend = input$legend,
                              legend.text = input$filterInput$right)
      if(input$stimulationInput == "NA"){
        NA}
      if(input$stimulationInput == "violett"){
        rect(402, 0, 408, 1, col = "purple", lty = 0)}
      if(input$stimulationInput == "green"){
        rect(505, 0, 545, 1, col = "green", lty = 0)}
      if(input$stimulationInput == "blue"){
        rect(455, 0, 462, 1, col = "blue", lty = 0)}
      if(input$stimulationInput == "infrared"){
        rect(847, 0, 853, 1, col = "red", lty = 0)}


    }
  })

  # Optical Density: Prepare data + plot
  output$densityPlot <- renderPlot({
    data <- as.matrix(readxl::read_excel(
        path = "Data/FilterDataBase_Bdx.xlsx",
        sheet = input$opticaldensity,
        skip = 14
      ))


     plot(data[,c(1,3)], type = "l",
          xlim = input$rangeOD,
          xlab = "Wavelength [nm]",
          ylab = "Optical Density [a. u.]",
          main = input$mainOD)

  })
  # Metadata
  output$metadata <- renderTable({
    if (length(input$filterInput$right) != 0) {
      data <- lapply(input$filterInput$right, function(x) {
        data <- as.data.frame(t(readxl::read_excel(
          path = "Data/FilterDataBase_Bdx.xlsx",
          sheet = x,
          col_names = FALSE,
          n_max = 7)),
          stringsAsFactors = FALSE)

        ##change column names & remove unwanted characters
        colnames(data) <- gsub(pattern = ":", replacement = "", x = as.character(data[1,]), fixed = TRUE)

        ##remove first row
        data <- data[-1,]

        ##remove NA values
        data <- data[!sapply(data[,1],is.na),]

        ##remove row with "BACK to Filterlist"
        data <- data[!grepl(pattern = "Back to Filterlist", x = data[,1]), ]

      })


      data.table::rbindlist(data)



    }
  })

  # Transmission: plot download
  output$exportPlot <- downloadHandler(
    filename = function() {
      paste(input$filename, ".pdf", sep = "")
    },
    content = function(file) {
      pdf(file,
          width = input$widthInput,
          height = input$heightInput,
          paper = "special")
      if (length(input$filterInput$right) != 0) {
        data <- lapply(input$filterInput$right, function(x) {
          as.matrix(readxl::read_excel(
            path = "Data/FilterDataBase_Bdx.xlsx",
            sheet = x,
            skip = 14))
        })
        plot_FilterCombinations(filters = data,
                                d = input$thicknessInput,
                                P = input$reflectionInput,
                                xlim = input$range,
                                main = input$main,
                                legend = input$legend,
                                legend.text = input$filterInput$right)
        if(input$stimulationInput == "NA"){
          NA}
        if(input$stimulationInput == "violett"){
          rect(402, 0, 408, 1, col = "purple", lty = 0)}
        if(input$stimulationInput == "green"){
          rect(505, 0, 545, 1, col = "green", lty = 0)}
        if(input$stimulationInput == "blue"){
          rect(455, 0, 462, 1, col = "blue", lty = 0)}
        if(input$stimulationInput == "infrared"){
          rect(847, 0, 853, 1, col = "red", lty = 0)}


      }
      dev.off()
    }
  )
 # Transmission: data-table download
  output$exportTable <- downloadHandler(
    filename = function(){
      paste(input$filenameCSV, ".csv", sep = "")
    },
    content = function(file) {
      if (length(input$filterInput$right) != 0) {
        data <- lapply(input$filterInput$right, function(x) {
          as.matrix(readxl::read_excel(
            path = "Data/FilterDataBase_Bdx.xlsx",
            sheet = x,
            skip = 14))
        })

        write.csv(data, file)
      }
    }
  )

 # Optical Density: plot download
  output$exportPlotOD <- downloadHandler(
    filename = function() {
      paste(input$filenameOD, ".pdf", sep = "")
    },
    content = function(file) {
      pdf(file,
          width = input$widthInputOD,
          height = input$heightInputOD,
          paper = "special")
      data <- as.matrix(readxl::read_excel(
        path = "Data/FilterDataBase_Bdx.xlsx",
        sheet = input$opticaldensity,
        skip = 14
      ))

        plot(data[,c(1,3)], type = "l",
             xlim = input$rangeOD,
             xlab = "Wavelength [nm]",
             ylab = "Optical Density [a. u.]",
             main = input$mainOD)

      dev.off()
    }
  )

  # Optical Density: data table download
  output$exportTableOD <- downloadHandler(
    filename = function(){
      paste(input$filenameCSVOD, ".csv", sep = "")
    },
    content = function(file) {
      data <- as.matrix(readxl::read_excel(
        path = "Data/FilterDataBase_Bdx.xlsx",
        sheet = input$opticaldensity,
        skip = 14
      ))

        write.csv(data, file)

    }
  )


 # Download Filterdatabase Master File
output$MasterFile <- downloadHandler(
  filename = "Filterdatabase_Bordeaux",
  content = function(file){
    file.copy("Data/FilterDataBase_Bdx.xlsx", file)

  }




)

})

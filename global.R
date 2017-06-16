library(shiny)
library(Luminescence)
require(readxl)
source("chooser.R")

##check whether a real database exists or the template should be loaded
if(dir.exists("Data")){
  ##set to first file
  database_path <- list.files("Data/", full.names = TRUE)[1]

  ##check whether this is a real XLSX file
  if(rev(strsplit(database_path, split = ".", fixed = TRUE)[[1]])[1] != "xlsx"){
    stop("The filter database file needs to be of type 'xlsx'!")

  }

}else{
  database_path <- "template/template.xlsx"

}


# ##load data
# masterfile <- read_excel_sheets("Data/FilterDataBase_Bdx.xlsx")
filters <- readxl::excel_sheets(database_path)
remove <- "Filter_List"
filters <- setdiff(filters, remove)



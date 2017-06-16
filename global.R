library(shiny)
library(Luminescence)
require(readxl)
source("chooser.R")

read_excel_allsheets <- function(filename) {
  sheets <- readxl::excel_sheets(filename)
  x <-    lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  names(x) <- sheets
  x
}



##load data
masterfile <- read_excel_allsheets("Data/FilterDataBase_Bdx.xlsx")
filters <- readxl::excel_sheets("Data/FilterDataBase_Bdx.xlsx")
remove <- "Filter_List"
filters <- setdiff(filters, remove)



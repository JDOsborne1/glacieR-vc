#' Find Files
#'  Finding the files in the directory which match the filename
#'
#' @param filename
#' @param directory
#'
#' @return
#' @export
#'
#' @examples
find_files <- function(filename, path){
  require(dplyr)
  return(list.files(path, pattern = filename))
}

#' Get Max
#'   Get the most recent date of the date stamps used in the files
#'
#' @param files
#'
#' @return
#' @export
#'
#' @examples
get_max <- function(files){
  require(dplyr)
  out <- files %>%
    str_match("\\d{4}-\\d{2}-\\d{2}") %>%
    as.Date() %>%
    max()
  return(out)
}

#' Latest File
#'   Function to get the filename of the most recent file
#'
#' @param files
#'
#' @return
#' @export
#'
#' @examples
latest_file <- function(files){
  require(dplyr)
  out <- files %>%
    get_max() %>%
    grep(files, value = T)
  return(out)
}

#' Get Face Function
#'   gets the full  path of the face of the glacier, the most recent snapshot of the data
#'
#' @param filename
#' @param path
#' @param legacy_time
#'
#' @return
#' @export
#'
#' @examples
get_face <- function(filename, path = getwd(), legacy_time = 10){
  require(lubridate)
  require(dplyr)
  files <- list.files(path, pattern = filename)
  if(files %>% get_max() + days(legacy_time) < Sys.Date()) print(paste0("File is more than ",legacy_time, " out of date, consider rerunning the data prep"))
  out <- file.path(path, files %>% latest_file())
  return(out)
}

#' Refresh Sheet Function
#'   Gets the most recent format of an object, if that object follows glacier
#'   naming conventions
#'
#' @param varname
#' @param path
#' @param flat_type
#'
#' @return
#' @export
#'
#' @examples
refresh_sheet <- function(varname, path = getwd(), flat_type = ".csv"){
  if(flat_type == ".csv"){
    filename <- paste0(deparse(substitute(varname)), ".csv")
    face <- filename %>%
      get_face(path)
    out <- read.csv(face, header = F)
  } else {
    print("No read define for that type")
  }
  return(out)
}


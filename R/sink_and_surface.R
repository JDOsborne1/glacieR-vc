#### Sinking and Surfacing functions ####

#' Sink
#'
#' @description  Function to take a variable in the environment and sink it to the processed data directory in the config file
#'
#' @return
#' @export
#'
#' @examples
iceSink <- function(object){

  path <- iceGetCleanPath()

  object_name <- deparse(substitute(`object`))

  object_class <- class(object)

  save_type <- iceGetMethod(object_class)

  saveMethod <- save_type$savemethod

  extension <- save_type$extension

  full_path <- iceBuildGlacierPath(path, object_name, extension)

  saveMethod(object, full_path)
}

#' Method Getter for glacier
#'
#' @param obj_class
#'
#' @return
#' @export
#'
#' @examples
iceGetMethod <- function(obj_class){
  if(any(obj_class %in% c("data.frame", "matrix", "tbl_df", "data.frame"))){
    return(list(savemethod = readr::write_csv, readmethod = readr::read_csv, extension = ".csv"))
  } else {
    print("No save method for that object class")
  }
}

#' Path builder for glacier
#'
#' @param path
#' @param file
#' @param extension
#'
#' @return
#' @export
#'
#' @examples
iceBuildGlacierPath <- function(path, file, extension) {
  return(paste0(path, Sys.Date(), file, extension))
}

#'  Getter function to find the clean path to the configured data location
#'
#' @return
#' @export
#'
#' @examples
iceGetCleanPath <- function(){
  path <- config::get('processed_data')

  if(!grepl("/$", path)){
    print("No closing slash adding one in ")
    path <- paste0(path, "/")

  }
  return(path)
}


#' Surface
#'
#' @description  Function search the processed data directory in the config file for the named file and pull it up
#'
#' @return
#' @export
#'
#' @examples
iceSurface <- function(object, show = FALSE){
  path <- iceGetCleanPath()

  object_name <- deparse(substitute(`object`))

  object_class <- class(object)

  save_type <- iceGetMethod(object_class)

  readMethod <- save_type$readmethod

  extension <- save_type$extension

  full_path <- get_face(paste0(object_name, extension), iceGetCleanPath())

  retrieved_object <- readMethod(full_path)

  assign(object_name, retrieved_object, envir = .GlobalEnv)

  if(show){
    return(retrieved_object)
  }
}

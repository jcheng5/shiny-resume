#' Launch Resume in the default browser
#'
#' @details ...
#'
#' @param app Choose one
#'
#' @export
resume <- function(app = "")
  runApp(system.file("test", package="resume"), launch.browser = TRUE)

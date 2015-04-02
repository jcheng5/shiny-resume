#' Set initial value for shiny input
#'
#' @details Useful for radio button or checkbox
#'
#' @param inputvar Name shiny input
#' @param init Initial value to use if state value for input not set
#'
#' @return value for inputvar
#'
#' @examples
#'
#' r_state <- list()
#' state_init("test")
#' state_init("test",0)
#' r_state$test <- c("a","b")
#' state_init("test",0)
#'
#' @seealso \code{\link{state_single}}
#' @seealso \code{\link{state_multiple}}
#'
#' @export
state_init <- function(inputvar, init = "")
  r_state %>% { if(is.null(.[[inputvar]])) init else .[[inputvar]] }

#' Set initial value for shiny input from a list of values
#'
#' @details Useful for select input with multiple = FALSE
#'
#' @param inputvar Name shiny input
#' @param vals Possible values for inputvar
#' @param init Initial value to use if state value for input not set
#'
#' @return value for inputvar
#'
#' @examples
#'
#' r_state <- list()
#' state_single("test",1:10,1)
#' r_state$test <- 8
#' state_single("test",1:10,1)
#'
#' @seealso \code{\link{state_init}}
#' @seealso \code{\link{state_multiple}}
#'
#' @export
state_single <- function(inputvar, vals, init = character(0))
  r_state %>% { if(is.null(.[[inputvar]])) init else vals[vals == .[[inputvar]]] }

#' Set initial values for shiny input from a list of values
#'
#' @details Useful for select input with multiple = TRUE and when you want to use inputs selected for another tool
#'
#' @param inputvar Name shiny input
#' @param vals Possible values for inputvar
#' @param init Initial value to use if state value for input not set
#'
#' @return value for inputvar
#'
#' @examples
#'
#' r_state <- list()
#' state_multiple("test",1:10,1:3)
#' r_state$test <- 8:10
#' state_multiple("test",1:10,1:3)
#'
#' @seealso \code{\link{state_init}}
#' @seealso \code{\link{state_single}}
#'
#' @export
state_multiple <- function(inputvar, vals, init = character(0)) {
  # "a" %in% character(0) --> FALSE, letters[FALSE] --> character(0)
  r_state %>%
  { if(is.null(.[[inputvar]]))
      vals[vals %in% init]
    else
      vals[vals %in% .[[inputvar]]]
  }
}

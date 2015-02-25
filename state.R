# Set initial value for shiny input (e.g., radio button or checkbox)
state_init <- function(inputvar, init = "")
  if(is.null(r_state[[inputvar]])) init else r_state[[inputvar]]

# Selecting a single value
state_single <- function(inputvar, vals, init = character(0)) {
  if(is.null(r_state[[inputvar]]))
    init
  else
    vals[vals == r_state[[inputvar]]]
}

# Selecting multiple values
state_multiple <- function(inputvar, vals, init = character(0)) {
  if(is.null(r_state[[inputvar]]))
    # "a" %in% character(0) --> FALSE, letters[FALSE] --> character(0)
    vals[vals %in% init]
  else
    vals[vals %in% r_state[[inputvar]]]
}

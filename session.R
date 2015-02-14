library(shiny)

sessionStore <- new.env(parent = emptyenv())

state_singlevar <- function(inputvar, vars)
  vars[vars == r_state[[inputvar]]]

# Set initial selection for shiny input (e.g., selectInput with multiple = TRUE)
state_multvar <- function(inputvar, vars)
  vars[vars %in% r_state[[inputvar]]]

# Set initial value for shiny input
state_init <- function(inputvar, init = "")
  if(is.null(r_state[[inputvar]])) init else r_state[[inputvar]]

# Set initial value for shiny input from a list of values
state_init_list <- function(inputvar, init, vals)
  if(is.null(r_state[[inputvar]])) init else state_singlevar(inputvar, vals)

# Set initial values for variable selection from a prior analysis
state_init_multvar <- function(inputvar, pre_inputvar, vals) {
  if(is.null(r_state[[inputvar]]))
    vals[vals %in% pre_inputvar]
  else
    state_multvar(inputvar, vals)
}

manageSession <- function(save_state, save_data, restore, session = getDefaultReactiveDomain()) {

  isolate({
    params <- parseQueryString(session$clientData$url_search)
    prevSSUID <- params[["SSUID"]]
    if (!is.null(prevSSUID)) {
      if (!is.null(sessionStore[[prevSSUID]])) {
        restore(sessionStore[[prevSSUID]])
      }
    }
  })

  if(is.null(prevSSUID))
    ssuid <- shiny:::createUniqueId(16)
  else
    ssuid <- prevSSUID

  session$sendCustomMessage("session_start", ssuid)
  observe({
    tryCatch(
      sessionStore[[ssuid]] <- list(
        r_data = save_data(),
        r_state = save_state(),
        timestamp = Sys.time()
      ),
      error = function(e) {
        warning("Failed to save session: ", e)
        rm(ssuid, pos = sessionStore, inherits = FALSE)
      }
    )
  })
}

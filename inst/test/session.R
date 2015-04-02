library(shiny)

sessionStore <- new.env(parent = emptyenv())

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

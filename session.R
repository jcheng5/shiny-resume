library(shiny)

sessionStore <- new.env(parent = emptyenv())

manageSession <- function(save, restore, session = getDefaultReactiveDomain()) {

  isolate({
    params <- parseQueryString(session$clientData$url_search)
    prevSSUID = params[["SSUID"]]
    if (!is.null(prevSSUID)) {
      if (!is.null(sessionStore[[prevSSUID]])) {
        restore(sessionStore[[prevSSUID]]$data)
      }
    }
  })

  ssuid <- shiny:::createUniqueId(16)
  session$sendCustomMessage("session_start", ssuid)
  observe({
    tryCatch(
      sessionStore[[ssuid]] <- list(
        data = save(),
        timestamp = Sys.time()
      ),
      error = function(e) {
        warning("Failed to save session: ", e)
        rm(ssuid, pos = sessionStore, inherits = FALSE)
      }
    )
  })
}

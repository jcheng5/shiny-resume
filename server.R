source("session.R")

function(input, output, session) {
  v <- reactiveValues(clicks = 0)

  # The call to manageSession starts a new session, but if we are continuing a
  # previous session it first calls restore() with the saved data.
  manageSession(
    save = reactive({
      list(clicks = v$clicks, remember = input$remember)
    }),
    restore = function(data) {
      v$clicks <- data[["clicks"]]
      updateNumericInput(session, "remember", value = data[["remember"]])
    }
  )

  observeEvent(input$click, {
    v$clicks <- v$clicks + 1
  })

  output$clickCount <- renderText({
    v$clicks
  })
}

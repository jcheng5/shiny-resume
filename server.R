# initialize state containers
r_data <<- reactiveValues()
r_data$cars <- mtcars
r_state <<- list()

source("session.R")

function(input, output, session) {

  # The call to manageSession starts a new session, but if we are continuing a
  # previous session it first calls restore() with the saved data.
  manageSession(
    save_state = reactive({
      reactiveValuesToList(input)
    }),
    save_data = reactive({
      reactiveValuesToList(r_data)
    }),
    restore = function(data) {
      r_data <- data$r_data
      r_state <<- data$r_state
    }
  )
  output$ui_state <- renderUI({
    # select for single value
    tagList(
      selectInput("select_one", label = "Select:", choices = c("a","b","c"),
        selected = state_init("select_one"), multiple = FALSE),
      selectInput("select_multiple", label = "Select:", choices = c("a","b","c"),
        selected = state_init_list("select_one"), multiple = FALSE),
    )

  })

#   observeEvent(input$click, {
#     v$clicks <- v$clicks + 1
#   })

#   output$clickCount <- renderText({
#     v$clicks
#   })

  output$value_selected <- renderText({
    input$select_one
  })
}

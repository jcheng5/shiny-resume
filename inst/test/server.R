source("session.R")
library(magrittr)

function(input, output, session) {

  # initialize state containers
  r_data <- reactiveValues()
  r_data$clicks <- 0
  r_state <- list()

  # the default approach in shiny apps
  # source("../../R/state.R", local = TRUE)

  # trying import
  import::here(resume, state_init, state_single, state_multiple)

  # this would be nice
  # import::here(resume, state*)

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
      r_data <<- do.call(reactiveValues, data$r_data)
      r_state <<- data$r_state

      r_data$clicks <- r_data[["clicks"]]
      updateNumericInput(session, "remember", value = r_state[["remember"]])
    }
  )
  output$ui_state <- renderUI({
    vals <- c("a","b","c")
    # select for single value
    tagList(
      tags$textarea(id="message", rows="2", class="form-control",
        state_init("message","[empty]")),
      radioButtons("radio", label = "Option:", choices = vals,
        selected = state_init("radio", "a"), inline = TRUE),
      checkboxGroupInput("check", label = "Options:", choices = vals,
        selected = state_init("check", "a"), inline = TRUE),
      selectInput("select_one", label = "Select one:", choices = vals,
        selected = state_single("select_one", vals), multiple = FALSE),
      selectInput("select_two", label = "Select two (or more):", choices = vals,
        selected = state_multiple("select_two", vals), multiple = TRUE)
    )
  })

  observeEvent(input$click, {
    r_data$clicks <- r_data$clicks + 1
  })

  output$values_selected <- renderPrint({
    cat("Click count: ")
    cat(r_data$clicks)
    cat("\nSelected one: ")
    cat(input$select_one)
    cat("\nSelected two: ")
    cat(input$select_two)
    cat("\nRemember: ")
    cat(input$remember)
  })

  output$state_values <- renderPrint({
    cat("r_data:\n")
    print(reactiveValuesToList(r_data))
    cat("\nr_state:\n")
    if(length(r_state) == 0)
      cat("[empty]")
    else
      str(r_state[sort(names(r_state))])

  })
}

fluidPage(
  # This line is required for the session ID to appear in the URL
  tags$script(src="session.js"),

  h3("Saving state demo"),
  hr(),

  # testing with different inputs
#   textInput("rename", "", input$dataset),

  uiOutput("ui_state"),
  textOutput("value_selected")

#   br(),
#   actionButton("click", "Click me"),
#   br(),
#   "Clicks:",
#   textOutput("clickCount", container = span),
#   hr(),
#   numericInput("remember", "Remember this value:", 0),
#   hr(),
#   textOutput("value_selected")
)

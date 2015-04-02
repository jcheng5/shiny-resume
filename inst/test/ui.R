fluidPage(
  # This line is required for the session ID to appear in the URL
  tags$script(src="session.js"),

  h3("Saving state demo"),
  hr(),
  uiOutput("ui_state"),
  actionButton("click", "Click me"),
  numericInput("remember", "Remember this value:", 0),
  verbatimTextOutput("values_selected"),
  verbatimTextOutput("state_values")
)

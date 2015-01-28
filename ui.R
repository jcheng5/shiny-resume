fluidPage(
  # This line is required for the session ID to appear in the URL
  tags$script(src="session.js"),

  h3("Demo of pushstate sessions"),
  hr(),
  actionButton("click", "Click me"),
  br(),
  "Clicks:",
  textOutput("clickCount", container = span),
  hr(),
  numericInput("remember", "Remember this value:", 0)
)

library(magrittr)

test <- function() {

  # source("../../R/state.R", local = TRUE)
  import::here(state_init, state_single, state_multiple, .from = resume)

  r_state <- list()
  state_init("test") %>% print

}

test()

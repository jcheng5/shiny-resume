library(magrittr)

# a few utility funcs, might as well take them from `import`
import::here(symbol_list, symbol_as_character, .from = import)

copy_from <- function(.from, ...) {
  symbols <- symbol_list(...)
  parent  <- parent.frame()
  from    <- symbol_as_character(substitute(.from))

  for (s in seq_along(symbols)) {
    fn <- get(symbols[s], envir = asNamespace(from), inherits = TRUE)
    assign(names(symbols)[s],
           eval.parent(call("function", formals(fn), body(fn))),
           parent)
  }

  invisible(NULL)
}

test <- function() {

  # source("../../R/state.R", local = TRUE)
  # import::here(state_init, state_single, state_multiple, .from = resume)
  copy_from(resume, state_init, state_single, state_multiple)

  r_state <- list()
  state_init("test") %>% print
}

test()

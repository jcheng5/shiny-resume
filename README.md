This is fork from [https://github.com/jcheng5/shiny-resume](shiny-resume). This is a proof of concept of saving/restoring session data for a Shiny app to avoid losing state on browser refresh. If can also be used to save and share state. See [vnijs/radiant](https://github.com/vnijs/radiant) for a related approach.

The logic for save and restore must be provided by the app author, using a call to `manageSession(save, restore)` during session start. The `save` parameter must be a reactive expression, while `restore` is a single-arg function that will be invoked with a value returned by `save`.


Functionality to be added:
1. Save session information to file when the R-process ends.
2. Remove old sessions

To run the app:

devtools::install_github("vnijs/shiny-resume")
library(resume)
resume()


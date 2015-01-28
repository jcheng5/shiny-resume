This is a proof of concept of saving/restoring session data for a Shiny app, allowing browser refreshes not to lose all of the state that an app has set up.

The logic for save and restore must be provided by the app author, using a call to `manageSession(save, restore)` during session start. The `save` parameter must be a reactive expression, while `restore` is a single-arg function that will be invoked with a value returned by `save`.

Serious limitations at the moment, that make this not well suited for production use:

1. All session data is stored in an in-memory environment, so when the R process ends or the app is restarted, all sessions are wiped.
2. Sessions are only created or overwritten, never destroyed, so memory usage will climb with each session.


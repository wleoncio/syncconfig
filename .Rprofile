require(utils, quietly=TRUE)
require(colorout, quietly=TRUE)
.First <- function() if(interactive()) try(loadhistory("~/.Rhistory"))
.Last <- function() if(interactive()) try(savehistory("~/.Rhistory"))
tryCatch(
  options(width = as.integer(system('tput cols',intern=TRUE))),
  error = function(err) {
    write("Can't get your terminal width. Put ``export COLUMNS'' in your \
           .bashrc. Or something. Setting width to 120 chars",
           stderr());
    options(width=120)}
)
.q <- function() quit("no")

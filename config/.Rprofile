require(utils, quietly=TRUE)
require(colorout, quietly=TRUE)
if ("colorout" %in% installed.packages()) {
	setOutputColors(
		normal = 39,
		number = 51,
		negnum = 183,
		date = 43,
		string = 79,
		const = 75,
		verbose = FALSE
	)
}
.First <- function() if(interactive() & Sys.getenv("RADIAN_VERSION") == "") try(loadhistory("~/.Rhistory"))
.Last <- function() if(interactive() & Sys.getenv("RADIAN_VERSION") == "") try(savehistory("~/.Rhistory"))
tryCatch(
  options(width = as.integer(system('tput cols',intern=TRUE))),
  error = function(err) {
    write("Can't get your terminal width. Put ``export COLUMNS'' in your \
           .bashrc. Or something. Setting width to 120 chars",
           stderr());
    options(width=120)}
)
options(browser="firefox")
options(repos="https://cran.uib.no")
.reload <- function(pkg) {
  pkg_string <- paste0("package:", pkg, collapse="")
  detach(pkg_string, unload=TRUE, character.only=TRUE)
  library(pkg, verbose=TRUE, character.only=TRUE)
}
if (as.numeric(format(Sys.time(), "%H")) < 10) {
	message("Updating packages")
	update.packages()
}

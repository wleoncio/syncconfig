# Basic packages
require(utils, quietly=TRUE)

# Options for base R
is_radian <- Sys.getenv("RADIAN_VERSION") != ""
is_interactive <- interactive()

if (!is_radian && is_interactive) {
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
	.First <- function() try(loadhistory("~/.Rhistory"))
	.Last <- function()  try(savehistory("~/.Rhistory"))
	tryCatch(
		options(width = as.integer(system('tput cols',intern=TRUE))),
		error = function(err) {
			write("Can't get your terminal width. Put ``export COLUMNS'' in your \
						 .bashrc. Or something. Setting width to 120 chars",
						 stderr());
			options(width=120)}
	)
}

# Custom options
options(browser="firefox")
options(repos="https://cran.uib.no")

.reload <- function(pkg) {
  pkg_string <- paste0("package:", pkg, collapse="")
  detach(pkg_string, unload=TRUE, character.only=TRUE)
  library(pkg, verbose=TRUE, character.only=TRUE)
}

# Updates packages on monday mornings
now <- Sys.time()
is_monday <- format(now, "%u") == 1
is_morning <- format(now, "%H") < 10
if (is_monday && is_morning) {
	message("Updating packages")
	update.packages()
}

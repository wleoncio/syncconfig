require(utils, quietly = TRUE)

# Options for base R
is_radian <- Sys.getenv("RADIAN_VERSION") != ""
is_interactive <- interactive()

if (!is_radian && is_interactive) {
	require(colorout, quietly = TRUE)
	if ("colorout" %in% installed.packages()) {
		setOutputColors(
			normal  = 39,
			number  = 51,
			negnum  = 183,
			date    = 43,
			string  = 79,
			const   = 75,
			verbose = FALSE
		)
	}
	.First <- function() try(loadhistory("~/.Rhistory"))
	.Last  <- function() try(savehistory("~/.Rhistory"))
	tryCatch(
		options(width = as.integer(system('tput cols',intern = TRUE))),
		error = function(err) {
			write("Can't get your terminal width. Put ``export COLUMNS'' in your \
						 .bashrc. Or something. Setting width to 120 chars",
						 stderr())
			options(width = 120)
		}
	)
}

# Options for Radian can be found on .radian_profile

# Custom options
options(browser = "firefox")
options(repos = "https://cran.uib.no")
options(error = rlang::entrace)
Sys.setenv(LANGUAGE = "en_US.UTF-8")

# Updates packages on monday mornings
now <- Sys.time()
is_monday <- format(now, "%u") == 1
is_morning <- format(now, "%H") < 12
if (is_monday && is_morning && is_interactive) {
	message("Updating packages")
	local_package_path <- .libPaths()[1]
	update.packages(lib.loc = local_package_path, ask = FALSE)
}

# Cleanup
rm(is_radian, is_interactive, is_monday, is_morning, now)

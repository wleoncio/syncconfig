# config

This is a repository containing some configuration files I use across my computers. Hopefully this is useful for someone else.

# Usage

Just browse the repository and hand-pick the code you want. To make my own life easier, I've created the `syncconfig.sh` script to manually sync these files between my system and a local clone of this repository. You can use it on Linux, but I'd strongly advise against it at this point, as it is a destructive and ad-hoc operation.

# License

This software is licenced under GPL-3 and citation details can be found in the [CITATION.cff](CITATION.cff) file. Contributions are welcome!

# To-dos
- [x] Add script to pull and push files
- [x] Add CITATION.cff
- [ ] Add confirmation when pulling
- [ ] Add diff when pulling
- [ ] Add switches to select file groups to sync
- [x] Add workmode to i3
- [x] Move .compton.conf to `~/.config`
- [x] Fix VSC syncing for "Code - OSS" (Arch)
- [ ] Add support for non-users of dunst (Arch)
- [ ] Fix vim colors (Arch)
- [ ] Make local repository file path flexible (non-Dropbox dependent)
- [ ] Add presentation mode (e.g. kill compton or restart it with basic config)
- [ ] Add solution to focus window when compton is not running (e.g. game and presentation modes)
- [x] Change work mode on IMB to load stable Teams release (instead of beta)


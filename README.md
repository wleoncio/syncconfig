# Introduction

This is a repository containing some configuration files I use across my computers. It helps me sync files across PCs, but hopefully this is useful to someone else.

# Usage

Just browse the repository and hand-pick the code you want. To make my own life easier, I've created the `syncconfig` CLI entrypoint to manually sync these files between my system and a local clone of this repository. Pull operations now prompt for each file overwrite with a default answer of `no`, and print when a missing local file is being created; use `--skip-confirmation` to apply all repository changes without prompting.

# License

This software is licenced under GPL-3 and citation details can be found in the [CITATION.cff](CITATION.cff) file. Contributions are welcome, feel free to tackle any of the currently opened [issues](https://github.com/wleoncio/config/issues).

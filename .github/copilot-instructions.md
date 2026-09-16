# syncconfig repository instructions

## Repository model

This is a personal Linux dotfile repository, not an application package. `config/`, `i3/`, and `VSC/` hold files that are copied into a user's home directory; `myScripts/` holds standalone desktop/workflow utilities.

The root `syncconfig` executable is the synchronization manifest and the primary integration point:

- It reads `location` from `~/.config/syncconfig.conf` (created interactively by `create-config.sh`, or with the default clone location by `syncconfig`).
- `push` copies live files into this clone; `pull` copies repository files back to the live configuration after warning about differences; `diff` compares the two without copying.
- It selects the i3 profile from the current hostname and maps it to `i3/<hostname>/`. When adding a supported machine profile, ensure its directory name exactly matches `hostname`.
- It conditionally syncs the detected compositor (`picom.conf` or `compton.conf`), dunst, and one supported VS Code-family configuration directory. Keep both the repository path and the corresponding `syncFiles` mapping in sync when adding a managed file.

The tracked shell startup files make the repository executable in normal use: `config/.bashrc` links `myScripts/*` and `syncconfig` into `~/.local/bin`, and Fish adds the repository root to its path. i3 profiles invoke those utilities and expect the per-machine `i3/<hostname>/scripts/` tree to be installed under `~/.config/i3/scripts/`.

## Commands and validation

There is no project build, test suite, linter, or single-test command. Do not treat the R-oriented entries in `VSC/tasks.json` as runnable repository tests; they are saved VS Code tasks for other projects.

Use the command's built-in dry run to inspect the managed dotfiles on a configured Linux desktop:

```bash
./syncconfig diff
```

For Bash scripts changed in this repository, use syntax validation for the individual file(s):

```bash
bash -n syncconfig
bash -n myScripts/uiosync
```

Run `./syncconfig --help` or `<script> --help` to inspect a command's supported interface. Many argument-parsing utilities require the external `docopts` command.

## Conventions

- Treat changes to managed dotfiles as deployment changes. Preserve destination paths, executable bits for launchable scripts, and i3 references to scripts/configuration that are installed together.
- `myScripts` contains independent tools with heterogeneous interpreters (Bash, POSIX shell, Perl, and Python). Follow the existing shebang and syntax of the target script instead of applying Bash syntax broadly.
- Command-line Bash utilities commonly declare `version` and `usage`, parse options through `docopts`, and source `uio-colors.sh` or `bash-colors.sh` for terminal colors. Keep the usage text, parser options, and behavior aligned when changing these interfaces.
- `uiosync` reads `local` and `remote` from the untracked `~/.config/uiosync.conf` and uses destructive `rsync --delete` after interactive confirmation. Preserve its conflict-check and confirmation flows when modifying synchronization behavior.
- Machine and user paths in these configs are intentionally personalized. Do not add credentials, tokens, or other private values to tracked dotfiles; keep them in separate local files such as the `.sensitive_env` file sourced by `config/.bash_aliases`.
- This repository is GPL-3.0 licensed; retain applicable license notices in files derived from upstream scripts.

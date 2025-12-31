set dotenv-filename := ".envrc"

# TODO: Update this to match your project's Maven group ID with slashes
group_id_with_slashes := "com/example"

import ".just/console.just"
import ".just/maven.just"
import ".just/git.just"
import ".just/git-test.just"

# `just --list --unsorted`
default:
    @just --list --unsorted

# `mise install`
mise:
    mise install --quiet
    mise current

# clean (maven and git)
@clean: _clean-git _clean-maven _clean-m2

# Run all formatting tools for pre-commit
precommit: mvn

# Override this with a command called `woof` which notifies you in whatever ways you prefer.
# My `woof` command uses `echo`, `say`, and sends a Pushover notification.
echo_command := env('ECHO_COMMAND', "echo")

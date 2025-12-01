set dotenv-filename := ".envrc"

# TODO: Update this to match your project's Maven group ID with slashes
group_id_with_slashes := "com/example"

# `just --list --unsorted`
default:
    @just --list --unsorted

# Run build and auto-formatters
precommit: mise mvn

# `mise install`
mise:
    mise install --quiet
    mise current

# Run Maven build
mvn:
    mvn verify

# Run Maven tests
test:
    mvn test

# Clean build output
clean:
    mvn clean
    rm -rf ~/.m2/repository/{{ group_id_with_slashes }}

# Override this with a command called `woof` which notifies you in whatever ways you prefer.
# My `woof` command uses `echo`, `say`, and sends a Pushover notification.
echo_command := env('ECHO_COMMAND', "echo")

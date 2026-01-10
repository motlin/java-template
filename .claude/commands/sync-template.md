# Java Template Sync

This template is the source of truth for Java/Maven project configurations.

## Managed Tools

### Mise Tools

Read tool versions from `.mise/config.toml` in this template. Java should use Temurin with full LTS tag format.

### Maven (pom.xml)

- Plugin versions
- Dependency management

### GitHub Workflows

- Auto-fix commit message format
- CI/CD patterns

## Java Version Policy

- **Own projects**: Use Temurin with full LTS tag format (e.g., `temurin-21.0.6+7.0.LTS`)
- **Forks**: Keep existing vendor (Oracle), just update version numbers
- **Never use short versions** like `temurin-21` - always use full LTS tag

## Projects

Read the list of projects from `.llm/projects.yaml`. This file is gitignored so each user can configure their own projects.

Example `.llm/projects.yaml`:

```yaml
# Your projects - use Temurin Java with full LTS tag format
own:
    - ~/projects/my-project-1
    - ~/projects/my-project-2

# Forks - keep existing Java vendor (Oracle), only update version numbers
forks:
    - ~/projects/some-fork

# Nested projects within parent projects that also need syncing
# These are archetypes or templates that generate new projects
nested:
    - ~/projects/my-project/my-archetype/src/main/resources/archetype-resources
```

### Nested Projects

Nested projects are archetypes or templates embedded within a parent project. They need the same updates as regular projects but have special considerations:

- **Velocity templates**: Workflow files may have `.vm` extension (e.g., `pull-request.yml.vm`)
- **Variable substitution**: Files may contain `${...}` placeholders - preserve these
- **Partial structure**: May not have all files (e.g., no `.mise/config.toml` if version comes from parent)

## Workflow

### Step 1: Update This Template

Check if this template's versions are the latest:

```bash
# Check latest mise tool versions via API (mise ls-remote may have network issues)
curl -s "https://api.github.com/repos/casey/just/releases/latest" | jq -r '.tag_name'
curl -s "https://api.github.com/repos/apache/maven/releases" | jq -r '.[].tag_name' | grep "^maven-3.9" | head -1
curl -s "https://api.adoptium.net/v3/info/release_versions?architecture=aarch64&heap_size=normal&image_type=jdk&lts=true&os=mac&page=0&page_size=1&project=jdk&release_type=ga&vendor=eclipse&version=%5B17%2C18%29" | jq -r '.versions[0].semver'
curl -s "https://api.adoptium.net/v3/info/release_versions?architecture=aarch64&heap_size=normal&image_type=jdk&lts=true&os=mac&page=0&page_size=1&project=jdk&release_type=ga&vendor=eclipse&version=%5B21%2C22%29" | jq -r '.versions[0].semver'
curl -s "https://nodejs.org/dist/index.json" | jq -r '[.[] | select(.version | startswith("v24."))][0].version'
```

Compare with `.mise/config.toml` in this project. If outdated, update them first.

### Step 2: Pull Improvements from Projects

Read `.llm/projects.yaml` and scan each project's `.mise/config.toml`.

Compare versions - if any project has a newer version, consider pulling it in.

Also check for workflow improvements:

- New auto-fix jobs
- Better CI patterns
- Useful justfile recipes

If a project has something better:

1. Verify it's intentional (not a mistake)
2. Update this template to match
3. Then push to all other projects

### Step 3: Push Template Versions to Projects

For each project in `.llm/projects.yaml`, compare versions and create tasks for any mismatches.

Use `/markdown-tasks:add-one-task` or the `task_add.py` script from the markdown-tasks plugin to add tasks to each project's `.llm/todo.md`.

### Task Templates

**Mise tool update:**

```
Update just <current> → <target>
  Edit .mise/config.toml
  Change: just = "<current>"
  To: just = "<target>"
```

**Java version format fix:**

```
Fix Java version format
  Edit .mise/config.toml
  Change: java = "temurin-21"
  To: java = "temurin-21.0.9+10.0.LTS"
  Note: Always use full LTS tag format
```

**Java vendor migration (own projects only, not forks):**

```
Migrate Java vendor oracle → temurin
  Edit .mise/config.toml
  Change: java = "oracle-17.0.10"
  To: java = "temurin-17.0.17+10.0.LTS"
```

**Auto-fix commit message update:**

```
Update auto-fix commit messages (exact replacements)
  Edit .github/workflows/pull-request.yml
  "Auto-fix: Apply OpenRewrite recipe changes" → "Apply OpenRewrite changes."
  "Auto-fix: Apply Spotless POM formatting" → "Apply Spotless POM formatting."
  "Auto-fix: Apply Spotless Prettier Java with Sorted Imports" → "Apply Spotless Prettier Java with Sorted Imports auto-formatting."
  ...etc
```

## Report Format

After syncing, report:

### This Template Status

- Current versions in this template
- Any updates made

### Improvements Pulled In

- List any newer versions found in siblings

### Tasks Distributed

- Number of siblings that received tasks
- Total tasks created
- Forks handled specially (kept existing Java vendor)
- Nested projects updated (with .vm file handling noted)

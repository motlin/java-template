---
description: Sync tool versions from this template to sibling Java projects
argument-hint: [project-name|all]
---

# Java Template Sync

This template is the source of truth for Java/Maven project configurations.

Template path: !`pwd`

## Managed files

- `scripts/audit-just-options.py` — repository-wide `just` option policy audit

### Mise tools

Read tool versions from `.mise/config.toml` in this template. Java should use Temurin
with full LTS tag format.

### Maven (pom.xml)

- Plugin versions
- Dependency management

### GitHub workflows

- Auto-fix commit message format
- CI/CD patterns

### Java version policy

- **Own projects**: Use Temurin with full LTS tag format (e.g., `temurin-25.0.2+10.0.LTS`)
- **Forks**: Keep existing vendor (Oracle), just update version numbers
- **Never use short versions** like `temurin-21` - always use full LTS tag

## Version policy

@.claude/includes/sync-version-policy.md

Versions to check for this template:

```bash
mise ls-remote just | tail -1
mise ls-remote maven | tail -1
mise ls-remote node | tail -1
mise ls-remote java | grep '^temurin-17\.' | tail -1
mise ls-remote java | grep '^temurin-21\.' | tail -1
mise ls-remote java | grep '^temurin-25\.' | tail -1
```

## Projects

`$ARGUMENTS` is a project name, `all`, or empty (treated as `all`).

@.claude/includes/sync-project-list.md

### Nested projects

Nested projects are archetypes or templates embedded within a parent project. They
need the same updates as regular projects but have special considerations:

- **Velocity templates**: Workflow files may have `.vm` extension (e.g., `pull-request.yml.vm`)
- **Variable substitution**: Files may contain `${...}` placeholders - preserve these
- **Partial structure**: May not have all files (e.g., no `.mise/config.toml` if version comes from parent)

## Stale and conflicting tool configs

@.claude/includes/sync-stale-configs.md

## Default git test

@.claude/includes/sync-git-test.md

## Just recipe options

@.claude/includes/sync-just-options.md

## Workflow

1. **Refresh the template.** Run the version checks above; if this template is
   behind, update it first.
2. **Pull from projects.** Read `.llm/projects.yaml` and scan each project's
   `.mise/config.toml` and workflows. If any project has a newer version, a new
   auto-fix job, a better CI pattern, or a useful justfile recipe, verify it is
   intentional, update this template, then push to the others.
3. **Scan for stale configs.** For each project, run the stale-config scan above
   before generating tooling tasks. Alert on findings; do not delete.
4. **Audit recipe options.** Run the shared `just` option audit against each project
   and create one project-scoped task for every failure.
5. **Generate tasks.** For each project, compare against this template and write
   tasks into its `.llm/todo.md` for any mismatches. Handle forks specially (keep
   existing Java vendor) and note `.vm` file handling for nested projects.

## Creating tasks

@.claude/includes/sync-task-dedup.md

Marker for this template: `Source: ~/projects/java-template`

### Task templates

**Mise tool update:**

```
Update just <current> → <target>
  Edit .mise/config.toml
  Change: just = "<current>"
  To: just = "<target>"
  Source: ~/projects/java-template
```

**Java version format fix:**

```
Fix Java version format
  Edit .mise/config.toml
  Change: java = "temurin-21"
  To: java = "temurin-21.0.9+10.0.LTS"
  Note: Always use full LTS tag format
  Source: ~/projects/java-template
```

**Java vendor migration (own projects only, not forks):**

```
Migrate Java vendor oracle → temurin
  Edit .mise/config.toml
  Change: java = "oracle-17.0.10"
  To: java = "temurin-17.0.17+10.0.LTS"
  Source: ~/projects/java-template
```

**Auto-fix commit message update:**

```
Update auto-fix commit messages (exact replacements)
  Edit .github/workflows/pull-request.yml
  "Auto-fix: Apply OpenRewrite recipe changes" → "Apply OpenRewrite changes."
  "Auto-fix: Apply Spotless POM formatting" → "Apply Spotless POM formatting."
  "Auto-fix: Apply Spotless Prettier Java with Sorted Imports" → "Apply Spotless Prettier Java with Sorted Imports auto-formatting."
  ...etc
  Source: ~/projects/java-template
```

## Report

@.claude/includes/sync-report.md

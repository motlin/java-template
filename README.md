# Java Project Template

A standardized template for Java/Maven projects with pre-configured tooling for formatting, linting, and CI/CD.

## Quick Start

1. Copy or fork this template
2. Update `GROUP_ID` in:
    - `.github/workflows/merge-group.yml`
    - `.github/workflows/pull-request.yml`
    - `.github/workflows/push.yml`
    - `justfile`
3. Create your `pom.xml`
4. Run `mise install` to set up tools

## Configuration Files

### Tool Versions (`.mise/config.toml`)

Uses [mise](https://mise.jdx.dev/) for tool version management:

- **Java**: Oracle JDK 17.0.10
- **Maven**: 3.9.11
- **mvnd**: 1.0.2 (Maven Daemon for faster builds)
- **just**: 1.40.0 (task runner)
- **Node.js**: 24.4.1 (for biome/prettier)

### Formatting

#### JSON/JSONC (`biome.jsonc`)

Uses [Biome](https://biomejs.dev/) for JSON formatting:

- 2 spaces, no tabs
- 120 character line width
- LF line endings
- No bracket spacing
- Trailing commas: none for `.json`, all for `.jsonc`
- Linter disabled (formatting only)

#### YAML/Markdown (`.prettierrc.json5`)

Uses [Prettier](https://prettier.io/) for non-JSON files:

- 2 spaces, no tabs
- 120 character print width
- LF line endings
- No bracket spacing
- Trailing commas: all
- Binary operators at start of wrapped lines (experimental)

#### Prettier Ignores (`.prettierignore`)

Prettier skips:

- All JSON/JSONC files (handled by Biome)
- `pom.xml` (handled by Maven Spotless)
- `.just` files
- `.graphqls` files
- Minified CSS

### Pre-commit Hooks (`.pre-commit-config.yaml`)

Runs on every commit:

**Standard Checks:**

- `check-yaml`, `check-json`, `check-toml`, `check-xml`
- `end-of-file-fixer`, `trailing-whitespace`
- `check-added-large-files` (max 1000KB)
- `check-case-conflict`, `check-merge-conflict`
- `detect-private-key`
- `mixed-line-ending` (fix to LF)

**Formatters:**

- `biome format` for `.json`/`.jsonc`
- `prettier` for YAML, Markdown, etc.

### Git Configuration

#### `.gitignore`

Generated from [gitignore.io](https://www.toptal.com/developers/gitignore/api/java,maven,intellij+iml,visualstudiocode) with:

- Java build artifacts (`*.class`, `*.jar`, etc.)
- Maven (`target/`, `pom.xml.*`)
- IntelliJ IDEA (user-specific files, keeping shared config)
- VS Code
- Local files (`.envrc`, `JUSTFILE_BRANCH`)

#### `.gitattributes`

- Normalize all text to LF
- Windows `.cmd` files use CRLF
- `.idea/` not marked as linguist-generated (visible in diffs)

### Maven Configuration

#### `.mvn/jvm.config`

- `-Xmx8g` - 8GB heap for builds

#### `.mvn/maven.config`

- `--errors` - Show errors
- `--no-transfer-progress` - Clean CI output
- `--fail-fast` - Stop on first failure
- `--color=always` - Color output
- `--threads=2C` - Parallel builds (2x CPU cores)

### GitHub Configuration

#### Dependabot (`.github/dependabot.yml`)

- Daily updates at 7:00 AM ET
- Maven dependencies
- GitHub Actions
- Up to 99 open PRs

#### CI Workflows

**merge-group.yml** (runs on PR and merge queue):

- Maven test
- Prettier check
- Biome check
- Reviewdog: markdownlint, yamllint, actionlint
- All-checks gate

**pull-request.yml** (PR-only):

- Forbid merge commits
- Auto-merge Dependabot PRs
- Auto-fix: Prettier, Biome (push to fix branch)

**push.yml** (main branch):

- Maven verify

### Task Runner (`justfile`)

Common commands:

```bash
just           # List available recipes
just precommit # Run mise install + Maven build
just mvn       # Run Maven verify
just test      # Run Maven tests
just clean     # Clean build output
```

## Extending This Template

### Adding Checkstyle

Add to `pom.xml` and extend `.github/workflows/merge-group.yml` with checkstyle jobs.

### Adding SpotBugs

Add to `pom.xml` and extend `.github/workflows/merge-group.yml` with spotbugs jobs.

### Adding Error Prone

Add to `pom.xml` and extend `.github/workflows/merge-group.yml` with errorprone jobs.

### Adding OpenRewrite

Add to `pom.xml` and extend workflows with rewrite dry-run and auto-fix jobs.

## License

Apache 2.0

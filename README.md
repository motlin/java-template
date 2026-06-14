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

### Formatting

#### JSON, JSON5, YAML, Markdown (`vite.config.ts`)

Uses [oxfmt](https://oxc.rs/) (via [vite-plus](https://www.npmjs.com/package/vite-plus)'s `vp fmt`)
for JSON, JSON5, YAML, Markdown, and other non-Java files. Configuration lives in the `fmt`
block of `vite.config.ts` — oxfmt ignores `.oxfmtrc.json`, so the config must live there.
This matches `../project-template` and `../typescript-template`.

Java and `pom.xml` are formatted separately by [Maven Spotless](https://github.com/diffplug/spotless).
Java formatting uses prettier-plugin-java, whose config lives in `.prettierrc.json5` (read only by
Spotless — the prettier CLI is no longer used for other file types).

#### Markdown linting (`.markdownlint.jsonc`, `.markdownlint-cli2.jsonc`)

Uses [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) for Markdown linting.
List indentation (4 spaces) is set to match oxfmt's Markdown formatting.

#### YAML linting (`.yamllint.yaml`)

Uses [yamllint](https://yamllint.readthedocs.io/) for YAML linting.

### Pre-commit Hooks (`.pre-commit-config.yaml`)

**Standard Checks:**

- `check-yaml`, `check-json`, `check-toml`, `check-xml`
- `end-of-file-fixer`, `trailing-whitespace`
- `check-added-large-files`
- `check-case-conflict`, `check-merge-conflict`
- `detect-private-key`
- `mixed-line-ending`

**Formatters:**

- `vp fmt` (oxfmt) — JSON, JSON5, YAML, Markdown, etc.
- `markdownlint-cli2` — Markdown linting

### Git Configuration

#### `.gitignore`

Generated from [gitignore.io](https://www.toptal.com/developers/gitignore/api/java,maven,intellij+iml,visualstudiocode).

#### `.gitattributes`

- Normalize all text to LF
- Windows `.cmd` files use CRLF
- `.idea/` not marked as linguist-generated (visible in diffs)

### Maven Configuration

- `.mvn/jvm.config`
- `.mvn/maven.config`

### GitHub Configuration

#### Dependabot (`.github/dependabot.yml`)

#### CI Workflows (`.github/workflows`)

### Task Runner (`justfile`)

## License

Apache 2.0

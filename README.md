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

#### JSON/JSONC (`biome.jsonc`)

Uses [Biome](https://biomejs.dev/) for JSON formatting:

#### YAML/Markdown (`.prettierrc.json5`)

Uses [Prettier](https://prettier.io/) for non-JSON files:

#### Prettier Ignores (`.prettierignore`)

Prettier skips:

- All JSON/JSONC files (handled by Biome)
- `pom.xml` (handled by Maven Spotless)
- `.just` files
- `.graphqls` files
- Minified CSS

### Pre-commit Hooks (`.pre-commit-config.yaml`)

**Standard Checks:**

- `check-yaml`, `check-json`, `check-toml`, `check-xml`
- `end-of-file-fixer`, `trailing-whitespace`
- `check-added-large-files`
- `check-case-conflict`, `check-merge-conflict`
- `detect-private-key`
- `mixed-line-ending`

**Formatters:**

- `biome format`
- `prettier`

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

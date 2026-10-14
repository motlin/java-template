Find which ignore rule matched each ignored file in the working tree:

```bash
git ls-files --others --ignored --exclude-standard -z \
    | xargs -0 -r -n 500 git check-ignore -v \
    | awk -F'\t' '{print $1}' | sort -u
```

- **`.git/info/exclude`:** propose moving an entry to `.gitignore` when every clone would produce the path (build output, caches, generated or agent scratch directories). Propose dropping entries that `.gitignore` already covers.
- **Global ignore file:** report entries that belong in this project's `.gitignore`, but never edit the global file.
- **`.gitignore` entries that match nothing:** propose removal only for a hand-added entry naming a path the project no longer has, confirmed with `git log --oneline -1 -- '<path>'`. Never propose removing gitignore.io blocks, secret patterns, OS or editor cruft, failure-only output (crash dumps, coverage), or negations and the patterns they depend on.

## Keep the gitignore.io block pristine

A vendored gitignore.io block runs from its `# Created by https://www.toptal.com/developers/gitignore/api/…` header to its matching `# End of …` footer. Everything between those markers must stay byte-identical to what the header URL returns; every hand-added entry, including ones promoted from `.git/info/exclude`, belongs outside the block, above the header.

To change the block, change the template list in the URL, fetch it again, and replace the whole block, header and footer included. Never edit lines inside it.

Check each project for drift:

```bash
url=$(sed -n 's/^# Created by \(https:\/\/www\.toptal\.com\/developers\/gitignore\/api\/.*\)$/\1/p' .gitignore)
diff <(curl -fsSL "$url") \
    <(sed -n '\|^# Created by https://www.toptal.com/developers/gitignore/api/|,\|^# End of https://www.toptal.com/developers/gitignore/api/|p' .gitignore)
```

An empty diff means the block is pristine. Report any diff with the project and the differing lines. Lines only in `.gitignore` are hand edits to move above the header; lines only in the fetched output mean upstream changed since the block was generated, and the fix is to regenerate the block. If `curl` fails, report the check as not run for that project rather than as passing.

Never edit ignore files automatically. Report each finding as a task with its file, line, pattern, and reason.

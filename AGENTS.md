# AGENTS.md

LaTeX sources for the Russian-language course "Введение в разработку на C++" (presentations, homeworks, projects). All prose is in Russian — write new content in Russian, matching the existing style.

## Build

- Toolchain comes from Nix: run `nix-shell` (provides texliveFull + GNU Make via a pinned nixpkgs tarball in `shell.nix`). Host LaTeX tools may be missing or mismatched; always build inside `nix-shell`.
- `make` builds every PDF; build one doc with e.g. `make pr-01`, `make hw-07`, `make prj-auth-lib` (list via `make help`). Output lands in `build/`, not next to sources (set in `.latexmkrc`: lualatex, `-shell-escape` for minted). `build/` is gitignored, so stale PDFs are easy to miss.
- The default branch is `master`; GitHub Actions only run on push/PR to `master`. Always verify with `make install` too — CI runs `PREFIX=install make install -j $(nproc)`.

## Layout

- `Presentations/NN-<topic>/<topic>.tex` — beamer slides, one directory per lecture.
- `Homeworks/NN-<name>/` — homework documents; some contain git submodules (e.g. `hw-project`, `submodule`) pointing at separate `../hw-*.git` repos. Their URLs are relative and must stay relative.
- `Projects/<...>.tex` — course projects (see `Projects/images/` for included figures).
- Shared styles: repo-root `Packages/*.sty` plus per-dir `presentationtemplate.sty`, `homeworktemplate.sty`, `projectstemplate.sty`. Committed fonts in `Fonts/` are referenced via hardcoded `Path=Fonts/...` inside the templates — do not relocate font files.

## Editing documents

- Code shown on slides is included from real files with `\myinputlisting{<dirname>/}{<file>}` (minted); inline snippets use `mycppinplacelisting` / `myinplacelisting`; command sessions use `terminalwindow` with `\shellcommand{...}`. It is teaching material, so C++ snippets must be accurate and compile.
- Makefile prerequisites glob source files per directory, but GNU make treats `**` as a single directory level (stacked `**` used for presentations 04–10). After editing a nested `.cpp`/`.h`, force a rebuild with `make clean` or `rm build/<name>.pdf`.

## Adding a document

Create `<NN>-<topic>/` and the `.tex`, then edit the Makefile in three places: the `.PHONY` list, the `build:` prerequisites, and the `install:` copy rules (deliverable filenames are Cyrillic, e.g. `«Презентации/01 Введение.pdf»`).

## Versioning

Releases use adapted semver via git tags: bump MAJOR when a document is removed, MINOR when one is added (or new information added), PATCH for fixes/structural changes. Rules live in README.
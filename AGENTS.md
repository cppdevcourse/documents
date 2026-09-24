# AGENTS.md

LaTeX sources for the Russian-language course "Введение в разработку на C++" (presentations, homeworks, projects). All prose is in Russian — write new content in Russian, matching the existing style.

## Build

- Toolchain comes from Nix via Flakes (`flake.nix` + committed `flake.lock`, nixpkgs pinned in `inputs`): `nix develop` opens a shell with texliveFull + GNU Make; `nix shell .#make .#texlive` is the throwaway variant; `nix build` compiles every document into a `result/` tree (`Презентации/`, `Домашние задания/`, `Проекты/`) via the Makefile's `install` target. Host LaTeX tools may be missing or mismatched — always build inside Nix.
- For a single doc inside the dev shell: `make pr-01`, `make hw-07`, `make prj-auth-lib` (list via `make help`). In `nix build` output lands in `result/`; in the Makefile sandbox it lands in `build/` — both are gitignored, so stale PDFs are easy to miss.
- The homework starter repos (`Homeworks/NN-*/hw-project`, `Homeworks/07-Real48/submodule`) are also flake inputs pinned in `flake.nix`, so `nix build` is hermetic without a `git submodule update`. Keep those pins in sync with `.gitmodules` when a submodule is bumped, then re-run `nix flake lock`.
- The default branch is `master`; GitHub Actions only run on push/PR to `master`. CI runs `nix build` on that branch (see `.github/workflows/compile.yml`).

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
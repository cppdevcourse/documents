# AGENTS.md

LaTeX sources for the Russian-language course "Введение в разработку на C++" (presentations, homeworks, projects). All prose is in Russian — write new content in Russian, matching the existing style.

## Build

- Toolchain comes from Nix via Flakes (`flake.nix` + committed `flake.lock`, nixpkgs pinned in `inputs`): `nix develop` opens a shell with texliveFull, gnumake and zip; `nix build` compiles every document via the Makefile's `install` target into a `result/` tree (`presentations/`, `homeworks/`, `projects/`). Host LaTeX tools may be missing or mismatched — always build inside Nix. `nix flake check` runs a `nixpkgs-fmt` formatting check on the flake.
- For a single doc inside the dev shell: `make pr-01`, `make hw-07`, `make prj-auth-lib` (list via `make help`). In `nix build` output lands in `result/` (a gitignored symlink into the nix store); with plain `make` it lands in `build/` (also gitignored) — so stale PDFs are easy to miss.
- The homework starter repos (`Homeworks/NN-*/hw-project`, `Homeworks/07-Real48/submodule`) are git submodules pulled into the flake source via `self.submodules = true`, so `nix build` is hermetic without a local `git submodule update`. To bump one, update the submodule and commit the new gitlink — there are no flake input pins to keep in sync.
- The default branch is `master`; GitHub Actions only run on push/PR to `master`. CI runs `nix build` on that branch (see `.github/workflows/compile.yml`); the Release workflow (`.github/workflows/release.yml`) reuses it to publish per-category zips on releases.

## Layout

- `Presentations/NN-<topic>/<topic>.tex` — beamer slides, one directory per lecture.
- `Homeworks/NN-<name>/` — homework documents; some contain git submodules (e.g. `hw-project`, `submodule`) pointing at separate `../hw-*.git` repos. Their URLs are relative and must stay relative.
- `Projects/<...>.tex` — course projects (see `Projects/images/` for included figures).
- Shared styles: repo-root `Packages/*.sty` plus per-dir `presentationtemplate.sty`, `homeworktemplate.sty`, `projectstemplate.sty`. Committed fonts in `Fonts/` are referenced via hardcoded `Path=Fonts/...` inside the templates — do not relocate font files.

## Editing documents

- PDFs are built with lualatex: `.latexmkrc` selects the engine (with `-shell-escape`, required by minted) and sets `out_dir=build`; the Makefile passes `-lualatex` as well.
- Code shown on slides is included from real files with `\myinputlisting{<dirname>/}{<file>}` (minted); inline snippets use `mycppinplacelisting` / `myinplacelisting`; command sessions use `terminalwindow` with `\shellcommand{...}`. It is teaching material, so C++ snippets must be accurate and compile.
- Makefile prerequisites glob source files per directory, but GNU make treats `**` as a single directory level (stacked `**` used for presentations 04–10). After editing a nested `.cpp`/`.h`, force a rebuild with `make clean` or `rm build/<name>.pdf`.

## Adding a document

Create `<NN>-<topic>/` and the `.tex`, then edit the Makefile in three places: the `.PHONY` list, the `build:` prerequisites, and the `install:` copy rules (deliverable filenames are ASCII, e.g. `presentations/01-intro.pdf`).

## Versioning

Releases use adapted semver via git tags: bump MAJOR when a document is removed, MINOR when one is added (or new information added), PATCH for fixes/structural changes. Rules live in README.
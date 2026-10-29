# AGENTS.md

LaTeX sources for the Russian-language course "Введение в разработку на C++" (presentations, homeworks, projects). All prose is in Russian — write new content in Russian, matching the existing style.

## Build

- Toolchain comes from Nix via Flakes (`flake.nix` + committed `flake.lock`, nixpkgs pinned in `inputs`): `nix develop` opens a shell with texliveFull, gnumake and zip; `nix build` compiles every document via the Makefile's `install` target into a `result/` tree (`presentations/`, `homeworks/`, `projects/`). Host LaTeX tools may be missing or mismatched — always build inside Nix. `nix flake check` runs a `nixpkgs-fmt` formatting check on the flake.
- For a single doc inside the dev shell: `make pr-01`, `make hw-07`, `make prj-auth-lib` (list via `make help`). In `nix build` output lands in `result/` (a gitignored symlink into the nix store); with plain `make` it lands in `build/` (also gitignored) — so stale PDFs are easy to miss.
- The homework starter repos (`Homeworks/NN-*/hw-project`, `Homeworks/07-Real48/submodule`) are git submodules pulled into the flake source via `self.submodules = true`, so `nix build` is hermetic without a local `git submodule update`. To bump one, update the submodule and commit the new gitlink — there are no flake input pins to keep in sync.
- The default branch is `master`; GitHub Actions only run on push/PR to `master`. CI runs `nix build` on that branch (see `.github/workflows/compile.yml`); the Release workflow (`.github/workflows/release.yml`) reuses it to publish per-category zips on releases.
- **Final check — `nix build`.** A presentation is ready only when `nix build` succeeds and its pdf is in `result/presentations/`. Iteration (editing LaTeX, building a single target, reading logs) happens in `nix develop`; the final run before reporting completion is always `nix build`.
- **`nix build` sees only git-tracked files** (with their working-tree contents): new (untracked) files do not reach the build sandbox, so stage them before `nix build` (`git add Presentations/NN-topic/` — plain staging, no commit; the user commits). Changes to tracked files (e.g. the Makefile) are visible without staging. Symptom: `make: *** No rule to make target 'Presentations/NN-topic/topic.tex'` in `nix build` only.

## Rules

- **No commits.** Never run `git commit`, `git push`, `git commit --amend` or `git reset`. The user commits themselves. This is also enforced at the harness level: `opencode.json` denies `git commit*`, `git push*` and `git reset*` for all agents. The only git command agents may run is staging (`git add`) before `nix build` (see "Build").
- Do not delete or rename existing presentations without an explicit request.
- Do not modify shared resources (`Presentations/presentationtemplate.sty`, `Packages/*.sty`, `Fonts/`, the Makefile as a whole) unless necessary; when adding a presentation only its Makefile targets are touched.
- **Record conventions.** Any new project agreement (structure, style, build parameters) is written into this file immediately, and — when it touches presentation creation/building — also into the corresponding skill in `.opencode/skills/`. Do not wait to be asked.

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

Create `<NN>-<topic>/` and the `.tex`, then edit the Makefile in six places: the `.PHONY` list, the `build:` prerequisites, the alias `pr-NN: pr-NN.pdf`, the `pr-NN.pdf:` rule (with wildcards + `$(call generate_pdf)`), the `help:` line, and the `install:` copy rule (deliverable filenames are ASCII, e.g. `presentations/01-intro.pdf`). Details in the skill `.opencode/skills/new-presentation/`.

## Presentation conventions

- Directory `Presentations/NN-topic/`: NN — next number in the series (current max + 1), topic — kebab-case (e.g. `16-constexpr`). Main file — `topic.tex`; exemplar: `Presentations/01-Intro/intro.tex`.
- Slides are 4:3 (128×96mm) — beamer's default; the `aspectratio` option is not set anywhere (no `aspectratio=169`).
- Skeleton: `\documentclass[compress]{beamer}` + `\usepackage{presentationtemplate}` + `\usepackage{terminal}` / `\usepackage{mylisting}` (only when there are examples) + `\subtitle{...}`. Fonts, logos, author and date come from the template — do not redeclare them.
- Code examples — `.cpp`/`.h` files in the presentation directory; inserted with `\myinputlisting[minted language=cpp]{Presentations/NN-topic/}{file}` (path relative to the project root), short fragments — `\myinplacelisting` / `mycppinplacelisting`, program runs — `terminalwindow` with `\shellcommand{...}`. Frames with code get `[fragile]`.
- The course standard is C++23; every example must compile with `g++ -std=c++23 -Wall -Wextra`. `cpp-expert` compiles and verifies each example before handing the draft over (see "Roles and pipeline (subagents)").
- Listing limits (measured for 4:3, `\footnotesize` with line numbers): no more than 54 characters per line (full-width listing), no more than 25 (a `0.48\textwidth` column), no more than 19 lines per frame (single listing; less when the slide also carries text). Beyond that — split the slide or reduce the font size. Fit check: `grep -n "Overfull" build/pr-NN.log` (vertical overflow only — a horizontal line wrap is not logged) + `pdftotext -layout` / `pdftoppm -png -r 60` (poppler-utils is in the devshell).
- Drafts live in `build/drafts/` (gitignored): plan — `build/drafts/NN-topic.plan.md`, text — `build/drafts/NN-topic.md`, example code — `build/drafts/NN-topic/`.

## Roles and pipeline (subagents)

Work on presentations is split between three subagents (configs in `.opencode/agent/`):

| Agent        | Role                                                                                                                                    | Restrictions                                                        |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `cpp-expert` | C++ expert: prepares the presentation plan (for approval) and, after approval, its full text; compiles and verifies every code example (`g++ -std=c++23 -Wall -Wextra`); at the typesetting stage (stage 3) decides whether proposed listing/text changes are acceptable | writes only drafts in `build/drafts/`; bash is for compiling code only |
| `latex-dev`  | Document developer: turns the text into LaTeX, wires it into the Makefile, builds and fixes errors; checks that code fits the 4:3 slides                                        | edits files, runs `make`/`nix develop`, poppler utilities           |
| `pm`         | Project manager: runs the pipeline, approves the plan with the user, coordinates listing/text changes between latex-dev and cpp-expert, verifies the result                          | does not edit files; stages and runs `nix build`, checks `result/`  |

Pipeline:

```
user request
  → pm
  → cpp-expert      (plan → build/drafts/NN-topic.plan.md)
  → user            (plan approval; comments → cpp-expert revises the plan)
  → cpp-expert      (text → build/drafts/NN-topic.md, compiled code)
  → latex-dev       (.tex + Makefile, make until success, fit check)
  ↺ typesetting problems: latex-dev → pm → cpp-expert
    (cpp-expert decides: accept the listing/text change or propose
     an alternative; the loop repeats until resolved)
  → pm              (check: git add, nix build, result/presentations/ contents)
  → report to the user
```

The plan is always approved by the user before any text is written. When the
task is to create or substantially update a presentation, delegate it to the
subagent `pm` (subagent tool) instead of doing it yourself.

cpp-expert's stage 3 (corrections) starts after latex-dev has typeset the
presentation: pm passes the typesetting problems, and cpp-expert decides
whether the proposed changes to listings/text are acceptable or proposes an
alternative. Structural changes to listings (beyond whitespace and line
wraps) always go through this agreement.

Subagents' blocking questions: pm first tries to answer them from the
requirement, and forwards them to the user only if it cannot. All subagent
commands run with a timeout.

Subagents do not run git commands: `git commit*`, `git push*` and
`git reset*` are denied for every agent (global rules in `opencode.json`,
repeated in each agent's own permissions), and any other git operation —
in particular staging — is a pm-only job. The single exception is the
staging `git add Presentations/NN-topic/` that `pm` runs before
`nix build` (see "`nix build` sees only git-tracked files" in "Build");
nobody commits.

Subagent config requirements (`.opencode/agent/*.md`, native V2
frontmatter): the `permissions` list uses the V2 action names — `shell`
(not V1 `bash`), `subagent` (not V1 `task`), `edit` (covers write/patch);
old action names in a V2 `permissions` array are NOT converted and silently
invalidate the rule. Rules are ordered and the last match wins; evaluation
order is base policy → global `opencode.json` rules → agent rules. Because
agent rules come last, an agent's broad `shell: allow` would override the
global git denies — therefore every agent with a `shell: allow` repeats the
three git denies after it. `pm` must have `subagent: allow` (delegating to
cpp-expert / latex-dev) and `question: allow` (plan approval with the user).
`opencode.json` sets `experimental.subagent_depth: 2`: the V2 default (1)
lets only the top-level session launch subagents, which would stall the
pipeline at the pm → expert delegation; depth 2 allows exactly the
main → pm → expert chain (experts themselves still cannot delegate).

## Versioning

Releases use adapted semver via git tags: bump MAJOR when a document is removed, MINOR when one is added (or new information added), PATCH for fixes/structural changes. Rules live in README.
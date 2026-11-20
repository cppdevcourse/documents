# AGENTS.md

LaTeX sources for the Russian-language course "Введение в разработку на C++" (presentations, homeworks, projects). All prose is in Russian — write new content in Russian, matching the existing style.

## Build

- Toolchain comes from Nix via Flakes (`flake.nix` + committed `flake.lock`, nixpkgs pinned in `inputs`): `nix develop` opens a shell with texliveFull, gnumake, zip, gcc and poppler-utils (coreutils, grep, findutils and sed come in as dependencies); `nix build` compiles every document via the Makefile's `install` target into a `result/` tree (`presentations/`, `homeworks/`, `projects/`). Host tools may be missing or mismatched — never rely on the host toolchain. `nix flake check` runs a `nixpkgs-fmt` formatting check on the flake.
- Subagents run all their commands inside the devShell: `nix develop --command <cmd>` (cpp-expert — g++, grep, coreutils; latex-dev — make, lualatex, poppler-utils).
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
- Code listing files are prerequisites of every presentation target:
  the `pdf_deps` macro lists them recursively
  (top level plus two levels of subdirectories,
  extensions `.cpp`/`.h`/`.hpp`).
  The `generate_pdf` recipe removes the built PDF before running
  latexmk if any source file is newer than the PDF:
  latexmk does not track code files included via minted,
  and without this the PDF would stay stale.
  After editing a nested `.cpp`/`.h`, plain `make pr-NN` suffices.

## Adding a document

Create `<NN>-<topic>/` and the `.tex`, then edit the Makefile in six places: the `.PHONY` list, the `build:` prerequisites, the alias `pr-NN: pr-NN.pdf`, the `pr-NN.pdf:` rule (with `$(call pdf_deps,<NN-topic>)` and `$(call generate_pdf,Presentations/<NN-topic>/<topic>.tex)`), the `help:` line, and the `install:` copy rule (deliverable filenames are ASCII, e.g. `presentations/01-intro.pdf`). Details in the skill `.opencode/skills/new-presentation/`.

## Presentation conventions

- Directory `Presentations/NN-topic/`: NN — next number in the series (current max + 1), topic — kebab-case (e.g. `16-constexpr`). Main file — `topic.tex`; exemplar: `Presentations/01-Intro/intro.tex`.
- Slides are 16:9 (160×90mm); `aspectratio=169` is set in each `.tex`'s `\documentclass` along with `compress` and the font size (01 — default 11pt, 02 — 10pt, 03–19 — 8pt).
- Skeleton: `\documentclass[compress, 8pt, aspectratio=169]{beamer}` + `\usepackage{presentationtemplate}` + `\usepackage{terminal}` / `\usepackage{mylisting}` (only when there are examples). Fonts, logos, author, date and the subtitle come from the template — do not redeclare them.
- `\subtitle` is never defined in a deck's .tex: the subtitle "Введение в разработку на C++" is set in `presentationtemplate.sty`.
- Code examples — `.cpp`/`.h` files in the presentation directory; inserted with `\myinputlisting[minted language=cpp]{Presentations/NN-topic/}{file}` (path relative to the project root), short fragments — `\myinplacelisting` / `mycppinplacelisting`, program runs — `terminalwindow` with `\shellcommand{...}`. Frames with code get `[fragile]`.
- The course standard is C++23; every example must compile with `g++ -std=c++23 -Wall -Wextra`. `cpp-expert` compiles and verifies each example before handing the draft over (see "Roles and pipeline (subagents)").
- Listing limits (measured for 16:9, 8pt, `\footnotesize` with line numbers): no more than 81 characters per line (full-width listing), no more than 38 (a `0.48\textwidth` column), no more than 24 lines per frame (single listing; less when the slide also carries text). Beyond that — split the slide or reduce the font size. Fit check: `grep -n "Overfull" build/pr-NN.log` (vertical overflow only — a horizontal line wrap is not logged) + `pdftotext -layout` / `pdftoppm -png -r 60` (poppler-utils is in the devshell).
- Drafts live in `build/drafts/` (gitignored): plan — `build/drafts/NN-topic.plan.md`, text — `build/drafts/NN-topic.md`, example code — `build/drafts/NN-topic/`.
- Slide text is impersonal: no "personal" address to the audience ("вы передаёте", "мы напишем", "разбираем", "вызвали", "меняйте") — only impersonal formulations ("итераторы на данные передаются", "алгоритм можно разработать самостоятельно").
- `\itemize`/`\item` — only for genuine multi-item lists; a single item goes into plain text without a marker.
- A "Итоги" frame (a summary of the whole presentation) does not exist — it is never needed. A `task` box (homework) may be present but never as a "write code" assignment: students do not write code during lectures — allowed are tasks like finding an error in a listing, reasoning about the code, and proposing a fix.
- Long dashes (—) are preferably avoided in slide text: rephrase instead of the dash (bad: "не нашёл — возвращает end"; good: "возвращает end, если не нашёл"). If a dash does remain, write `\textemdash \space` — a regular space after `\textemdash` is swallowed by lualatex (in the PDF it becomes "слово—слово"). A short dash (`\textendash`) is never used as a dash in slide text. The convention is in `Presentations/08-Arrays/arrays.tex`.

## Roles and pipeline (subagents)

Work on presentations is split between three agents (configs in
`.opencode/agent/*.md`). `pm` is the default agent
(`"default_agent": "pm"` in `opencode.json`): the user talks to pm
directly, and pm delegates to the specialists. If the current
session is not pm and the task is to create or substantially update
a presentation, delegate it to pm instead of doing it yourself.

### Access rights

The authoritative source of access rights is the `permissions` list
in each agent's frontmatter; the global rules (git denies) live in
`opencode.json`. Rules are ordered, the last matching rule wins;
evaluation order is base policy → global `opencode.json` rules →
agent rules. `*` in a resource pattern matches any number of
characters, including `/`.

Note: the `skills:` field in agent frontmatter is decorative in
OpenCode V2 — it does not grant or restrict anything; skill loading
is controlled by the `skill` permission action only.

| Agent        | Access                                                                                                                                              |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `pm`         | `subagent`, `question`, `shell` (except `git commit*`/`git push*`/`git reset*`); edit: all files (harness owner); document files — only on explicit user instruction, outside the pipeline |
| `cpp-expert` | `shell` (except git denies), `websearch`, `webfetch` (fact checking); edit: `build/drafts/**` only; `skill` denied (information barrier from typesetting conventions)                   |
| `latex-dev`  | `shell` (except git denies); edit: all project files except `.opencode/*`, `opencode.json`, `AGENTS.md`                                                                                    |

### 1. pm — project manager (default agent)

* Runs the pipeline and both scenarios: new presentation (plan →
  approval → text → typesetting) and editing an existing one
  (classifies content vs. layout, routes to cpp-expert and/or
  latex-dev).
* Writes all subagent prompts (task, inputs, expected result, report
  requirements); stores sessionIDs and resumes the same sessions for
  follow-up fixes.
* Responsible for the result: verifies subagents' claims itself
  (files, build logs, `nix build`) before reporting to the user —
  does not trust a report on faith; rejects reports missing the
  `Skills loaded:` line or the required skill.
* Does not do the specialists' work (no LaTeX debugging, no C++
  content); the exceptions are the harness (pm edits `.opencode/*`,
  `AGENTS.md`, `opencode.json` per the `edit-skill` conventions,
  on explicit user commission) and point edits to document files
  on the user's direct instruction (verified by `nix build`).
* Approves the plan with the user via the `question` tool.

### 2. cpp-expert — C++ content expert

* Stage 1: plan → `build/drafts/NN-topic.plan.md` (for user
  approval); stage 2 (after approval): full text →
  `build/drafts/NN-topic.md` with every example compiled
  (`g++ -std=c++23 -Wall -Wextra`); stage 3 (after typesetting):
  decides whether proposed listing/text changes are acceptable or
  proposes an alternative.
* `websearch`/`webfetch` — fact checking of C++ statements.
* `skill: deny` — cannot load typesetting/build skills (information
  barrier); listing limits live in its own config instead.
* Writes only `build/drafts/**`.
* Runs all commands only inside the devShell
  (`nix develop --command <cmd>`).

### 3. latex-dev — LaTeX document developer

* Turns the approved draft into `.tex`, wires it into the Makefile
  (six places), builds until success, checks 16:9 fit (the
  `new-presentation` skill).
* May propose listing changes when something does not fit — but does
  not interpret text meaning; structural listing changes always go
  through pm → cpp-expert (stage 3).
* No access to harness files.
* Runs all commands only inside the devShell
  (`nix develop --command <cmd>`).

### Pipeline

```
user request
  → pm                (new presentation | edit existing: classify
                        content vs. layout and route)
  → cpp-expert        (plan → build/drafts/NN-topic.plan.md)
  → user              (plan approval via question; comments →
                        cpp-expert revises the plan)
  → cpp-expert        (text → build/drafts/NN-topic.md, compiled code)
  → latex-dev         (.tex + Makefile, make until success, fit check)
  ↺ typesetting problems: latex-dev → pm → cpp-expert
    (cpp-expert decides: accept the listing/text change or propose
     an alternative; the loop repeats until resolved)
  → pm                (verify itself; git add, nix build,
                        result/presentations/ contents)
  → report to the user
```

The plan is always approved by the user before any text is written.
Editing an existing presentation: content changes go through
cpp-expert first, layout-only changes go straight to latex-dev;
structural changes to listings (beyond whitespace and line wraps)
always go through the cpp-expert agreement.

### Communication and iteration rules

* pm writes every subagent prompt and requires a `Skills loaded:`
  line in every report (the loaded skills, or «нет» — always for
  cpp-expert, whose skill access is denied); a report without the
  line or the required skill is rejected.
* pm stores each subagent's sessionID and resumes the same session
  for follow-up fixes instead of starting a new one.
* pm oversees subagents (hangs, loops) and relays blocking
  questions: it first tries to answer them from the requirement,
  and forwards them to the user only if it cannot.
* All subagent commands run with a timeout.

### Git and harness

Subagents do not run git commands: `git commit*`, `git push*` and
`git reset*` are denied for every agent (global rules in
`opencode.json`, repeated in each agent's own permissions), and any
other git operation — in particular staging — is a pm-only job. The
single exception is the staging `git add Presentations/NN-topic/`
that `pm` runs before `nix build` (see "`nix build` sees only
git-tracked files" in "Build"); nobody commits.

The harness (`.opencode/`, `AGENTS.md`, `opencode.json`) is owned by
pm: subagents have `edit: deny` on these files, and pm edits the
harness following the `edit-skill` conventions. pm has
`edit: allow` on all files, but document-file edits outside the
pipeline are made only on explicit user instruction and are
verified by `nix build`.

Subagent config requirements (`.opencode/agent/*.md`, native V2
frontmatter): the `permissions` list uses the V2 action names —
`shell` (not V1 `bash`), `subagent` (not V1 `task`), `edit` (covers
write/patch); old action names in a V2 `permissions` array are NOT
converted and silently invalidate the rule. Because agent rules come
last, an agent's broad `shell: allow` would override the global git
denies — therefore every agent with a `shell: allow` repeats the
three git denies after it. `pm` must have `subagent: allow`
(delegating to cpp-expert / latex-dev) and `question: allow` (plan
approval with the user). `opencode.json` sets
`experimental.subagent_depth: 2`: the V2 default (1) lets only the
top-level session launch subagents; depth 2 covers both the direct
case (pm is the default agent → expert = one level) and the case
where the main session is another agent and delegates to pm
(→ expert = two levels; the experts themselves still cannot
delegate).

## Versioning

Releases use adapted semver via git tags: bump MAJOR when a document is removed, MINOR when one is added (or new information added), PATCH for fixes/structural changes. Rules live in README.
---
name: new-presentation
description: Рецепт добавления новой презентации в cppdevcourse-documents — конвейер (план с согласованием с пользователем → текст и скомпилированный код → LaTeX + Makefile → сборка и проверка вписываемости на слайды 4:3), структура beamer-источника, подключение к Makefile (шесть мест), сборка через make в nix develop и финальная проверка nix build. Use when creating, adding or updating a presentation, editing its Makefile targets, or debugging the pdf build.
---

# Новая презентация cppdevcourse-documents

## 0. Конвейер

Новая презентация создаётся только по конвейеру (управляет `pm`):

1. **План** — `cpp-expert` готовит план тем и примеров
   → `build/drafts/<NN-topic>.plan.md`.
2. **Согласование** — `pm` показывает план пользователю и получает
   утверждение (замечания → `cpp-expert` дорабатывает план, согласование
   повторяется). Без утверждённого плана конвейер не продолжается.
3. **Текст** — `cpp-expert` пишет текст по слайдам по согласованному
   плану и компилирует все примеры кода
   → `build/drafts/<NN-topic>.md` + `build/drafts/<NN-topic>/`.
4. **Сборка** — `latex-dev`: каркас (раздел 1) + Makefile (раздел 2)
   + `make` до успеха (раздел 3) + проверка вписываемости на слайды.
5. **Проверка** — `pm`: `git add` + `nix build` + содержимое
   `result/presentations/`.

## 1. Каркас

Директория `Presentations/<NN-topic>/` (NN — следующий номер серии,
имя — kebab-case), основной файл `<topic>.tex`. Образец:
`Presentations/01-Intro/intro.tex`.

Структура `.tex`:

- `\documentclass[compress]{beamer}` — слайды 4:3 (128×96мм),
  значение beamer по умолчанию; опцию `aspectratio` **не указывать**
  (в частности, никакого `aspectratio=169`);
- `\usepackage{presentationtemplate}` — шрифты, логотипы, автор, дата
  уже заданы в шаблоне; повторно объявлять нельзя
- `\usepackage[fontsize=\footnotesize, askip=3mm]{terminal}` и
  `\usepackage[fontsize=\footnotesize, linenosfontsize=\tiny, askip=3mm]{mylisting}`
  — только если в презентации есть примеры/терминал
- `\subtitle{...}` — переопределяет подзаголовок по умолчанию из шаблона
- Фреймы `\begin{frame}[...]{...}\frametitle{...}\end{frame}`;
  фреймы с кодом — обязательная опция `[fragile]`

Примеры кода:

- Файловый пример: файл `Presentations/<NN-topic>/<file>.cpp` (или `.h`) и
  `\myinputlisting[minted language=cpp]{Presentations/<NN-topic>}/}{<file>.cpp}`
  — путь от корня проекта: первый аргумент — каталог (с завершающим
  `/`), второй — имя файла (оно же становится заголовком листинга).
- Короткий фрагмент: окружение
  `\begin{myinplacelisting}[minted language=cpp]` …код…
  `\end{myinplacelisting}` (или `mycppinplacelisting` — язык cpp по
  умолчанию).
- Короткий фрагмент с заголовком: окружения
  `\begin{mytitledinplacelisting}[minted language=cpp]{<TITLE>}` /
  `\begin{mycpptitledinplacelisting}{<TITLE>}` …код…
- Запуск программы: окружение `terminalwindow`, команды
  `\shellcommand{g++ file.cpp}` и т.п.; escape-последовательность по
  умолчанию `!!` (в `01-Intro` используется вариант `[||]`).

Весь C++-код во всех примерах должен быть корректным и компилируемым
`g++ -std=c++23 -Wall -Wextra`; стандарт курса — C++23. `cpp-expert`
компилирует каждый пример до передачи черновика, поэтому на этапе
верстки код уже проверен.

Ограничения листингов (измерены для 4:3, `\footnotesize` с номерами
строк):

- строка кода не длиннее 54 символов, если листинг занимает шириной
  весь слайд, и не длиннее 25 символов, если он в колонке
  `0.48\textwidth`;
- не более 19 строк в одном фрейме (если на слайде ещё и текст —
  меньше): более длинный листинг разбить на два слайда или
  отмасштабировать (уменьшить размер шрифта), чтобы вписался по высоте;
- все структурные изменения в листингах (переносы строк, пробелы и т.д. к
  ним не относятся) должны быть согласованы `latex-dev` с `cpp-expert`
  через `pm`.

## 2. Makefile — шесть мест

По образцу цели `pr-01` (NN — следующий номер серии):

1. Список `.PHONY`: добавить `pr-NN`.
2. Цель `build`: добавить `pr-NN` в зависимости.
3. Алиас рядом с остальными: `pr-NN: pr-NN.pdf`.
4. Правило (в секции целей презентаций):

   ```make
   pr-NN.pdf: \
   	Presentations/<NN-topic>/<topic>.tex \
   	Presentations/presentationtemplate.sty \
   	$(wildcard Presentations/images/*-logo.png) \
   	$(wildcard Presentations/<NN-topic>/*.cpp) \
   	$(wildcard Presentations/<NN-topic>/*.h) \
   	$(wildcard Presentations/<NN-topic>/**/*.cpp) \
   	$(wildcard Presentations/<NN-topic>/**/*.h) \
   	Packages/terminal.sty \
   	Packages/mylisting.sty
   	$(call generate_pdf,$<,$@)
   ```

   `Packages/terminal.sty` — только если презентация использует
   `terminalwindow`; `Packages/mylisting.sty` — если есть листинги.
   Если код лежит в поддиректориях, добавьте явные wildcard именно
   для этих директорий (`$(wildcard Presentations/<NN-topic>/<sub>/*.cpp)`)
   — образец `pr-02` (`library/`, `relocations/`): в make `**` —
   ровно один уровень директории.
5. Цель `help`: строка
   `@printf "pr-NN\tbuild presentation pr-NN.pdf\n"`.
6. Цель `install`: строка
   `cp "$(BUILD_DIR)/pr-NN.pdf" "$(PREFIX)/presentations/<NN-topic>.pdf"`
   (имя pdf — ASCII, например `16-constexpr.pdf`).

## 3. Сборка

- Одна цель (отладка): `nix develop --command make pr-NN`
- Все цели: `nix develop --command make`
- Лог сборки: `build/pr-NN.log` (out_dir задан в `.latexmkrc`)
- После правки вложенного `.cpp`/`.h` (глубже одного уровня) make может
  не заметить изменение (`**` = один уровень): принудительная пересборка
  через `make clean` или `rm build/pr-NN.pdf`.
- Проверка вписываемости на слайды (4:3):
  - `grep -n "Overfull" build/pr-NN.log` — вертикальный перелив
    (`Overfull \vbox`). Горизонтальный перенос строк листинга в лог
    НЕ попадает (minted с `breaklines` переносит молча) — проверяется
    отдельно:
  - `pdftotext -layout build/pr-NN.pdf - > /tmp/opencode/fit.txt` —
    перенесённая строка кода отобразится как две физические строки;
  - `pdftoppm -png -r 60 build/pr-NN.pdf /tmp/opencode/page` — визуально;
  - `pdfinfo build/pr-NN.pdf` — число страниц и размер (128×96мм).
  Утилиты poppler есть в devshell; вне devshell —
  `nix shell nixpkgs#poppler-utils --command pdftotext ...`
  (`nix run ... --command` не работает: unrecognised flag).
- Финальная проверка: `nix build` → убедиться, что
  `result/presentations/<NN-topic>.pdf` существует и не пуст.
  Перед ней — `git add Presentations/<NN-topic>/`: flake копирует в
  песочницу только отслеживаемые git-файлы (с содержимым рабочего
  дерева), untracked-файлы в `nix build` невидимы (коммит при этом
  не нужен). Стейджинг делает pm; прочие git-команды субагенты не
  запускают — сессия на них зависает.

## 4. Частые ошибки

- `Undefined control sequence` / `Environment terminalwindow undefined` —
  не подключён пакет `terminal`/`mylisting` в `.tex`.
- `Package minted Error: ... file not found` — неверный путь в
  `\myinputlisting` (указывается от корня проекта, не от директории `.tex`).
- Minted/verbatim-проблемы внутри фрейма — не стоит опция `[fragile]`.
- Код «переносится» справа — строка длиннее 54 символов (вся ширина)
  или 25 символов (полслайда): сократить строки или уменьшить размер
  шрифта. В лог `Overfull` при этом не попадёт.
- Листинг упирается в низ / `Overfull \vbox` в логе — в фрейме больше
  19 строк (для одиночного листинга): разбить слайд или уменьшить
  размер шрифта.
- `make: *** No rule to make target 'pr-NN.pdf'` — цель не добавлена
  в Makefile.
- `nix build` не видит новый pdf — цель не добавлена в `install`
  (проверить все шесть мест: `.PHONY`, `build`, алиас, правило,
  `help`, `install`).
- `make: *** No rule to make target 'Presentations/<NN-topic>/<topic>.tex'`
  только в `nix build` (в `nix develop` всё собирается) — новые файлы
  untracked: сделать `git add Presentations/<NN-topic>/` (стейджинг) и
  повторить `nix build`.

---
name: edit-skill
description: Конвенции правки файлов харнесса проекта (.opencode/, AGENTS.md, opencode.json). Use when explicitly asked to modify agents, skills, or harness configuration.
---

# Когда применять

Только по явной просьбе пользователя.

# Правила

- Отказать в редактировании этого файла.
- Использовать минимум markdown-разметки.
- Hard wrap всего текста.
  Держать ширину строки меньше 80 символов.
- Каждое новое предложение — с новой строки.
- Права агентов живут только во frontmatter
  `.opencode/agent/*.md` — единый источник прав.
  В `opencode.json` — только глобальные правила: git denies,
  `default_agent`, `experimental.subagent_depth`.
- Правила упорядочены, последнее совпадение выигрывает;
  `*` в паттерне ресурса сопоставляется с любым числом
  символов, включая `/`. Агент с широким `shell: allow`
  обязан повторить три git denies после него.
- После правки перечитать изменённый файл; проверить, что
  frontmatter — валидный YAML, а `opencode.json` — валидный JSON.
- Новые договорённости о презентациях или сборке сразу
  записывать в `AGENTS.md` (см. правило «Record conventions»).

# SQL Playground

Песочница для практики SQL на PostgreSQL. Каждая задача лежит в своей папке со схемой, тестовыми данными и файлом для решения. База поднимается в Docker, а все команды запускаются через [Task](https://taskfile.dev).

## Структура репозитория

```
.
├── docker/
│   └── docker-compose.yaml   # контейнер Postgres
├── tasks/
│   └── 001-profiles/
│       ├── task.md           # условие
│       ├── schema.sql        # таблицы
│       ├── data.sql          # тестовые данные
│       └── solution.sql      # решение
├── .env.example              # шаблон настроек
└── Taskfile                  # команды
```

## Что нужно установить

- [Docker](https://docs.docker.com/get-docker/) с Compose v2 (команда `docker compose`).
- [Task](https://taskfile.dev/installation/), например:
    - macOS: `brew install go-task`
    - Linux: `sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin`
    - Windows: `winget install Task.Task`

Локальный `psql` не нужен: все запросы выполняются внутри контейнера.

## Подключение из IDE

К базе можно подключиться из DBeaver, DataGrip, VS Code и т.п. Параметры берутся из `.env`:

| Параметр | Значение по умолчанию |
|---|---|
| Host | `localhost` |
| Port | `5101` (`POSTGRES_PORT`) |
| Database | `playground` (`POSTGRES_DB`) |
| User | `playground` (`POSTGRES_USER`) |
| Password | `playground` (`POSTGRES_PASSWORD`) |

## Быстрый старт

```sh
git clone https://github.com/mutan/sql-playground.git
cd sql-playground
cp .env.example .env              # при желании поменяйте пароль и порт
task up                           # запустить Postgres
task load T=001-profiles          # загрузить схему и данные задачи
task run T=001-profiles           # выполнить своё решение
```

Задание читайте в `tasks/001-profiles/task.md`, решение пишите в `tasks/001-profiles/solution.sql`.

## Как решать задачу

1. `task load T=<задача>` очищает базу и загружает `schema.sql` и `data.sql` выбранной задачи. Повторяйте, если испортили данные.
2. Пишите запросы в `solution.sql`. Папка `tasks` примонтирована в контейнер, поэтому изменения видны сразу, без перезапуска.
3. `task run T=<задача>` выполняет `solution.sql`. Другой файл из той же папки: `task run T=<задача> S=draft.sql`.
4. Для экспериментов вручную: `task psql`.

Выполнение файлов останавливается на первой ошибке, так что в выводе будет видна только она.

## Как добавить задачу

1. `task new T=002-something` создаст папку с файлами `task.md`, `schema.sql`, `data.sql`, `solution.sql`.
2. Опишите таблицы в `schema.sql`, данные в `data.sql`, условие в `task.md`.
3. Проверьте загрузку: `task load T=002-something`.

Номер в начале имени держит задачи по порядку. `data.sql` можно не заполнять: если файла нет, загрузится только схема.





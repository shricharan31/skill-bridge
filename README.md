# SkillBridge Actual Code Content

This archive contains the actual source code from the requested directories, preserved in the languages used by the application.

## Directory language map

| Directory | Language | Contents |
|---|---|---|
| `client/` | React + TypeScript + CSS | Complete browser interface, pages, SAIL chat UI, manager portal, learner dashboard, and UI components. |
| `server/` | TypeScript + Node.js | Express/tRPC backend, database helpers, authentication procedures, SAIL recommendation engine, storage, and tests. |
| `shared/` | TypeScript | Shared constants and types used by frontend and backend. |
| `drizzle/` | TypeScript + SQL | MySQL schema, relations, and generated database migrations. |
| `scripts/` | Python | SQLite-to-MySQL catalogue migration utility using `mysql-connector-python`. |

## Why the files are not all Python

The client is a browser application. React, TypeScript, CSS, and Vite are required for the existing interface and cannot be directly converted into Python without rebuilding it as a different framework such as Flask, Django, or Streamlit.

The backend is already written in TypeScript/Node.js because it uses Express, tRPC, Drizzle ORM, and the Manus runtime. The database migrations are SQL and TypeScript because they are executed through Drizzle.

The Python portion is the catalogue importer in `scripts/import_sqlite_to_mysql.py`. It can run independently in IDLE after installing `mysql-connector-python`.

## Run the original project

From the project root:

```bash
pnpm install
pnpm check
pnpm test
pnpm dev
```

## Run the Python script

```bash
pip install mysql-connector-python
python scripts/import_sqlite_to_mysql.py /path/to/SkillBridge_Core.db
```

The Python script expects a `DATABASE_URL` environment variable containing a MySQL connection URL.

# SkillBridge Full Project Source

This archive contains the complete SkillBridge application source: React frontend, Express/tRPC backend, MySQL/Drizzle schema and migrations, SAIL recommendation engine, Python SQLite-to-MySQL importer, tests, Dockerfile, and project configuration.

## Requirements

- Node.js 22 or newer
- pnpm 10 or newer
- Python 3.9 or newer for the catalogue importer
- MySQL or TiDB for the application database

## Install and run

```bash
pnpm install
pnpm check
pnpm test
pnpm dev
```

The application uses environment variables supplied by the deployment runtime. For a local setup, copy `.env.example` to `.env` and fill in the required values. Never commit real credentials.

## Database

The application schema is in `drizzle/schema.ts`; SQL migrations are in `drizzle/*.sql`. The Python utility in `scripts/import_sqlite_to_mysql.py` imports the supplied SkillBridge SQLite catalogue into MySQL. Install its dependency with:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python scripts/import_sqlite_to_mysql.py /path/to/SkillBridge_Core.db
```

## Main source areas

| Directory/file | Purpose |
|---|---|
| `client/` | React interface, pages, UI components, styling, and browser bootstrap. |
| `server/` | tRPC procedures, database helpers, SAIL engine, auth, and tests. |
| `shared/` | Shared constants and types. |
| `drizzle/` | MySQL schema, relations, and migrations. |
| `scripts/` | Python catalogue migration utility. |
| `Dockerfile` | Node plus Python deployment image. |
| `SKILLBRIDGE_HACKATHON_PITCH.md` | Implementation and hackathon presentation guide. |

## Important note

This is source code, not a standalone export of runtime secrets, database contents, OAuth credentials, or generated `node_modules`/`dist` files. Configure those separately in the target environment.

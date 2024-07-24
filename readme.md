# Tarefas

## TODO
- [x] Postgres
  - [x] Instalação
  - [x] Geração do schema
  - [X] População da base
  - [x] Query's
- [ ] Oracle
  - [x] Instalação
  - [x] Geração do schema - (testei e fiz os ajustes está gerando certo)
  - [x] População da base
  - [ ] Query's
- [ ] MongoDB
  - [x] Instalação
  - [x] Geração do schema (Normalizado)
  - [ ] Geração do schema (Denormalizado)
  - [ ] População da base (Normalizado)
  - [ ] População da base (Denormalizado)
  - [ ] Query's (Normalizado)
  - [ ] Query's (Denormalizado)
- [ ] Trabalho Escrito
  - [ ] ...

## Links

[Trabalho Escrito Docs](https://docs.google.com/document/d/1jeczO2rFpab2idOCfGTQBtOFoKSoB22enhS4uMtodfc/edit?usp=sharing)

## Script Uteis

Poem aqui login do banco, comandos uteis, etc

### Postgres

#### Login

```sql
PGPASSWORD="postgres" psql -U postgres -d postgres -h localhost
```

#### Dump

**Nota:** Gerar os dados na maquina local, gerar o dump e enviar para o servidor

```sql
pg_dump -h localhost -p 5432 -U postgres -b -v -f dump.sql -d task_5
```

#### Restore

```sql
psql -h 177.44.248.107 -U postgres -c "CREATE DATABASE task_5"
psql -h 177.44.248.107 -U postgres -d task_5 -f dump.sql
```

#### Tempos

**Nota:** Usar o comando a baixo antes de executar as query's

```sql
\timing
```

### Oracle

### Mongo

#### Login

```bash
# Start mongo
sudo systemctl start mongod

# Check mongo status
sudo systemctl status mongod

# Login
mongosh

# Stop mongo
sudo systemctl stop mongod
```

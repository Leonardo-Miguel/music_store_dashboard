# Chinook Store — Banco de Dados, Análise Exploratória e BI

Projeto baseado na base de exemplo **Chinook 1.4.5** (loja fictícia de músicas digitais), cobrindo criação e carga no **PostgreSQL**, análise exploratória em **Python/Jupyter** e um dashboard em **Power BI**.

Base Chinook: [lerocha/chinook-database](https://github.com/lerocha/chinook-database).

---

## Visão geral

| Item | Descrição |
|---|---|
| Banco | PostgreSQL (11 tabelas) |
| Análise | Jupyter Notebook com pandas e SQLAlchemy |
| Dashboard | Power BI (`Chinook_BI.pbix`) |
| Modelagem | ERD no pgAdmin |

O objetivo é analisar vendas por **artista, gênero, playlist, vendedor e país**, além da **receita por ano**.

## Visualização do dashboard

![Visualização do dashboard Chinook](Visualização%20do%20dashboard.png)

## Relatório de BI

### Opções de análise

1. **Estatísticas por Artista** — músicas, vendas e álbuns por artista.
2. **Estatísticas por Gênero** — músicas e vendas por gênero.
3. **Estatísticas por Playlist** — quantidade de músicas por playlist.
4. **Estatísticas por Vendedor** — vendas por vendedor.
5. **Estatísticas por País** — vendas por país.
6. **Receita por Ano** — evolução das vendas ao longo dos anos.

### Constatações

1. A maior parte das músicas e artistas é de **rock** (ou derivados, como metal, alternativo e punk), incluindo as mais vendidas.
2. Depois do rock, o gênero mais presente e vendido é o **latino**.
3. As vendas por funcionário são **bem distribuídas** entre os **3 vendedores**.
4. As maiores playlists são **Music**, **90's Music** e **TV Show**.
5. Os países com mais vendas são **EUA**, **Canadá**, **Reino Unido** e **Brasil**; a **Europa** tem o maior número de países consumidores.
6. As vendas caíram em **2025**, atingindo o patamar do primeiro ano avaliado, mas as diferenças ano a ano são baixas.

## Como usar

1. Crie um banco no PostgreSQL e execute `Chinook_PostgreSql.sql` no Query Tool do pgAdmin.
2. Valide a carga com `verificar_dados_chinook.sql`.
3. Para recarregar do zero: execute `reset_chinook.sql` e depois o script principal novamente.
4. No notebook, ajuste as credenciais do PostgreSQL e execute com **Run All**.
   - Dependências: `pandas`, `sqlalchemy`, `psycopg2-binary`.
5. Abra `Chinook_BI.pbix` no Power BI Desktop e atualize a conexão, se necessário.

## Contagens esperadas

`album` 347 · `artist` 275 · `customer` 59 · `employee` 8 · `genre` 25 · `invoice` 412 · `invoice_line` 2.240 · `media_type` 5 · `playlist` 18 · `playlist_track` 8.715 · `track` 3.503

## Tecnologias

PostgreSQL · pgAdmin 4 · SQL · Python · pandas · SQLAlchemy/psycopg2 · Jupyter Notebook · Power BI

## Arquivos

| Arquivo | Descrição |
|---|---|
| `Chinook_BI.pbix` | Dashboard no Power BI com estatísticas por artista, gênero, playlist, vendedor e país, receita por ano e filtros por artista/gênero/playlist. |
| `Chinook_BI_relatório.txt` | Documento de apoio do dashboard, com as opções de análise e as constatações obtidas. |
| `Chinook_ERD.pgerd` | Diagrama ERD do pgAdmin com tabelas, chaves e relacionamentos. |
| `Chinook_Exploratory_Analysis.ipynb` | Notebook que conecta ao banco `chinook` e analisa todas as tabelas: estrutura, contagens, nulos, valores únicos, amostras e integridade referencial. |
| `Chinook_PostgreSql.sql` | Script completo do Chinook 1.4.5: criação das tabelas, chaves, índices e carga dos dados. Adaptado para o Query Tool do pgAdmin. |
| `Criar banco através do arquivo.txt` | Guia rápido para executar o script SQL no pgAdmin. |
| `Metadata.txt` | Dicionário com a descrição das 11 tabelas. |
| `reset_chinook.sql` | Remove todas as tabelas com `CASCADE` para permitir recarregar o banco do zero. |
| `verificar_dados_chinook.sql` | Valida a quantidade de registros por tabela e procura chaves estrangeiras órfãs. |
| `Visualização do dashboard.png` | Captura de tela do dashboard do Power BI, exibida no início deste README. |

## Modelo de dados

Principais relacionamentos:

- `artist` → `album` → `track`
- `track` → `genre` e `media_type`
- `playlist` ↔ `track` (via `playlist_track`)
- `customer` → `invoice` → `invoice_line` → `track`
- `customer.support_rep_id` → `employee`; `employee.reports_to` → `employee`
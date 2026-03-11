# Global Student Portal Dependency Graph

This repository models the dependency graph of a multi-tenant Global Student Portal in Neo4j and computes component stability metrics based on *Clean Architecture*.

## What is included

- Neo4j setup via Docker Compose
- Mermaid dependency graph source
- Cypher migration scripts to create the component graph
- Cypher query to compute Fan-in, Fan-out, and Instability
- Query files for browsing the graph and metrics
- A Markdown table with the computed results

## Architecture Scope

The graph includes the following component types:

- Clients: `Web Portal`, `Mobile App`
- Entry point: `API Gateway`
- Core services: `Auth Service`, `University Management`, `Student Information`, `Course Management`, `Enrollment`, `Grading and Transcript`, `Finance`, `Notification`, `Document Service`, `Audit Log`
- Infrastructure: `SQL Database`, `Redis Cache`, `File Storage`
- External systems: `Payment Gateway`, `Email/SMS Provider`

## Repository Layout

```text
.
├── docker-compose.yml
├── dependency-graph.mmd
├── METRICS.md
├── migrations
│   ├── 001_seed_graph.cypher
│   └── 002_compute_metrics.cypher
└── queries
    ├── 01_show_graph.cypher
    └── 02_show_metrics.cypher
```

## Dependency Model

The model uses `(:Component)-[:DEPENDS_ON]->(:Component)` relationships.

Examples:

- `Web Portal -> API Gateway`
- `Enrollment -> Student Information`
- `Finance -> Payment Gateway`
- `Notification -> Email/SMS Provider`

## Metrics

The repository calculates:

- `Fan-in`: number of incoming dependencies
- `Fan-out`: number of outgoing dependencies
- `Instability (I)`: `Fan-out / (Fan-in + Fan-out)`

Interpretation:

- `I = 0` means the component is very stable
- `I = 1` means the component is very unstable

## How to run

### 1. Start Neo4j and run the migrations

```bash
docker compose up
```

This starts:

- `neo4j` on `http://localhost:7474`
- a one-shot `migrator` container that applies the Cypher scripts

### 2. Log in to Neo4j Browser

- URL: `http://localhost:7474`
- Username: `neo4j`
- Password: `password123`

### 3. Explore the graph

Run:

```cypher
MATCH (a:Component)-[r:DEPENDS_ON]->(b:Component)
RETURN a, r, b;
```

or open `queries/01_show_graph.cypher`.

### 4. Show metrics

Run:

```cypher
MATCH (c:Component)
RETURN
  c.name AS component,
  c.category AS category,
  c.fanIn AS fan_in,
  c.fanOut AS fan_out,
  c.instability AS instability
ORDER BY c.instability ASC, c.name ASC;
```

or open `queries/02_show_metrics.cypher`.

## Migration Details

`migrations/001_seed_graph.cypher`

- creates a uniqueness constraint on `Component.name`
- inserts all nodes
- inserts all dependency edges

`migrations/002_compute_metrics.cypher`

- computes incoming and outgoing dependency counts
- stores `fanIn`, `fanOut`, and `instability` on each node

## Notes

- This project is intentionally small and reproducible for coursework and demonstration.
- The metrics table is saved in `METRICS.md`.
- If you want to recompute the graph from scratch, remove the Neo4j volume and rerun Docker Compose.

# Stability Metrics

Instability is calculated using the definition from *Clean Architecture*:

`I = Fan-out / (Fan-in + Fan-out)`

| Component | Category | Fan-in | Fan-out | Instability |
|---|---|---:|---:|---:|
| SQL Database | infrastructure | 8 | 0 | 0.000 |
| Redis Cache | infrastructure | 3 | 0 | 0.000 |
| File Storage | infrastructure | 1 | 0 | 0.000 |
| Payment Gateway | external | 1 | 0 | 0.000 |
| Email/SMS Provider | external | 1 | 0 | 0.000 |
| Audit Log | service | 10 | 1 | 0.091 |
| Notification | service | 3 | 2 | 0.400 |
| Student Information | service | 4 | 3 | 0.429 |
| Course Management | service | 3 | 3 | 0.500 |
| Document Service | service | 2 | 2 | 0.500 |
| University Management | service | 1 | 2 | 0.667 |
| Auth Service | service | 1 | 3 | 0.750 |
| API Gateway | gateway | 2 | 10 | 0.833 |
| Enrollment | service | 1 | 5 | 0.833 |
| Finance | service | 1 | 5 | 0.833 |
| Grading and Transcript | service | 1 | 5 | 0.833 |
| Mobile App | client | 0 | 1 | 1.000 |
| Web Portal | client | 0 | 1 | 1.000 |

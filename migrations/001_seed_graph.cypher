CREATE CONSTRAINT component_name IF NOT EXISTS
FOR (c:Component)
REQUIRE c.name IS UNIQUE;

UNWIND [
  {name: 'Web Portal', category: 'client'},
  {name: 'Mobile App', category: 'client'},
  {name: 'API Gateway', category: 'gateway'},
  {name: 'Auth Service', category: 'service'},
  {name: 'University Management', category: 'service'},
  {name: 'Student Information', category: 'service'},
  {name: 'Course Management', category: 'service'},
  {name: 'Enrollment', category: 'service'},
  {name: 'Grading and Transcript', category: 'service'},
  {name: 'Finance', category: 'service'},
  {name: 'Notification', category: 'service'},
  {name: 'Document Service', category: 'service'},
  {name: 'Audit Log', category: 'service'},
  {name: 'SQL Database', category: 'infrastructure'},
  {name: 'Redis Cache', category: 'infrastructure'},
  {name: 'File Storage', category: 'infrastructure'},
  {name: 'Payment Gateway', category: 'external'},
  {name: 'Email/SMS Provider', category: 'external'}
] AS row
MERGE (c:Component {name: row.name})
SET c.category = row.category;

UNWIND [
  ['Web Portal', 'API Gateway'],
  ['Mobile App', 'API Gateway'],
  ['API Gateway', 'Auth Service'],
  ['API Gateway', 'University Management'],
  ['API Gateway', 'Student Information'],
  ['API Gateway', 'Course Management'],
  ['API Gateway', 'Enrollment'],
  ['API Gateway', 'Grading and Transcript'],
  ['API Gateway', 'Finance'],
  ['API Gateway', 'Notification'],
  ['API Gateway', 'Document Service'],
  ['API Gateway', 'Audit Log'],
  ['Auth Service', 'SQL Database'],
  ['Auth Service', 'Redis Cache'],
  ['Auth Service', 'Audit Log'],
  ['University Management', 'SQL Database'],
  ['University Management', 'Audit Log'],
  ['Student Information', 'SQL Database'],
  ['Student Information', 'Redis Cache'],
  ['Student Information', 'Audit Log'],
  ['Course Management', 'SQL Database'],
  ['Course Management', 'Redis Cache'],
  ['Course Management', 'Audit Log'],
  ['Enrollment', 'Student Information'],
  ['Enrollment', 'Course Management'],
  ['Enrollment', 'SQL Database'],
  ['Enrollment', 'Notification'],
  ['Enrollment', 'Audit Log'],
  ['Grading and Transcript', 'Student Information'],
  ['Grading and Transcript', 'Course Management'],
  ['Grading and Transcript', 'Document Service'],
  ['Grading and Transcript', 'SQL Database'],
  ['Grading and Transcript', 'Audit Log'],
  ['Finance', 'Student Information'],
  ['Finance', 'Payment Gateway'],
  ['Finance', 'Notification'],
  ['Finance', 'SQL Database'],
  ['Finance', 'Audit Log'],
  ['Notification', 'Email/SMS Provider'],
  ['Notification', 'Audit Log'],
  ['Document Service', 'File Storage'],
  ['Document Service', 'Audit Log'],
  ['Audit Log', 'SQL Database']
] AS dep
MATCH (a:Component {name: dep[0]})
MATCH (b:Component {name: dep[1]})
MERGE (a)-[:DEPENDS_ON]->(b);

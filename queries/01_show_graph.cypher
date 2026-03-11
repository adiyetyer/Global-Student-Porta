MATCH (a:Component)-[r:DEPENDS_ON]->(b:Component)
RETURN a, r, b;

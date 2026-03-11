MATCH (c:Component)
WITH c,
     COUNT { (c)<-[:DEPENDS_ON]-(:Component) } AS fanIn,
     COUNT { (c)-[:DEPENDS_ON]->(:Component) } AS fanOut
SET c.fanIn = fanIn,
    c.fanOut = fanOut,
    c.instability =
      CASE
        WHEN fanIn + fanOut = 0 THEN 0.0
        ELSE round(1000.0 * toFloat(fanOut) / (fanIn + fanOut)) / 1000.0
      END;

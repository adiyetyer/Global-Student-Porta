MATCH (c:Component)
RETURN
  c.name AS component,
  c.category AS category,
  c.fanIn AS fan_in,
  c.fanOut AS fan_out,
  c.instability AS instability
ORDER BY c.instability ASC, c.name ASC;

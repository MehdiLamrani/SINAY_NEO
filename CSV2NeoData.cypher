export FILEPATH=file:///'/Users/amiral/seascraper/CSV2NeoData.cypher

CREATE CONSTRAINT ON (s:SHIP) ASSERT s.id IS UNIQUE;
CREATE CONSTRAINT ON (o:Owner) ASSERT o.name IS UNIQUE;
CREATE CONSTRAINT ON (o:Operator) ASSERT o.name IS UNIQUE;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM {FILEPATH} AS line
WITH DISTINCT line

CREATE (complaint:Complaint { name: line.Name })
SET ship.category = line.Vessel Category,
    ship.flag = line.FLAG
    ship.country = line.'Construction Country'

MERGE (owner:Owner { name: UPPER(line.Owner) })
MERGE (operator:Operator { name: UPPER(line.Operator) })

CREATE (ship)-[:OWNED_BY]->(owner)
CREATE (ship)-[:OPERATED_BY]->(operator)

;

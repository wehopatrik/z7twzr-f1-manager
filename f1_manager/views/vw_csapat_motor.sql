CREATE OR REPLACE VIEW vw_csapat_motor AS
SELECT cs.csapat_nev AS csapat_neve, m.motorgyarto_nev AS motorgyarto_neve
FROM csapatok cs
JOIN motorgyartok m
ON cs.motorgyarto_id = m.motorgyarto_id;

SELECT * FROM vw_csapat_motor;

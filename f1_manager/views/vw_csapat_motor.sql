CREATE OR REPLACE VIEW vw_csapat_motor AS
SELECT cs.csapat_nev AS csapat_neve,
       m.motorgyarto_nev AS motorgyarto_neve
FROM csapat cs
JOIN motorgyarto m
ON cs.motorgyarto_id = m.motorgyarto_id;

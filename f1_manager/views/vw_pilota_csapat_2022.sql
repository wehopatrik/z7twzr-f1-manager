CREATE OR REPLACE VIEW vw_pilota_csapat_2022 AS
SELECT p22.pilota_id AS pilota_szama, po.szemely_nev AS pilota_neve, cs.csapat_nev AS csapat_neve
FROM csapatok cs
JOIN pilotak2022 p22 ON cs.csapat_id = p22.csapat_id
JOIN pilotak_osszes po ON po.szemely_id = p22.szemely_id
ORDER BY p22.pilota_id;

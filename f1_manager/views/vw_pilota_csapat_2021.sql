CREATE OR REPLACE VIEW vw_pilota_csapat_2021 AS
SELECT p21.pilota_id AS pilota_szama, po.szemely_nev AS pilota_neve, cs.csapat_nev AS csapat_neve
FROM csapatok cs
JOIN pilotak2021 p21 ON cs.csapat_id = p21.csapat_id
JOIN pilotak_osszes po ON po.szemely_id = p21.szemely_id
ORDER BY p21.pilota_id;

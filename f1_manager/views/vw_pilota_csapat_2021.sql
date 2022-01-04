CREATE OR REPLACE VIEW vw_pilota_csapat_2021 AS
SELECT pcs.pilota_szam AS pilota_szama,
       po.szemely_nev AS pilota_neve,
       cs.csapat_nev AS csapat_neve,
       nvl(pcs.meddig, to_date(SYSDATE)) AS meddig
FROM pilota_csapat pcs
JOIN csapat cs ON cs.csapat_id = pcs.csapat_id
JOIN pilota_osszes po ON po.szemely_id = pcs.szemely_id
WHERE (pcs.mettol BETWEEN to_date('1950-01-01', 'yyyy-mm-dd') AND to_date('2021-12-31', 'yyyy-mm-dd'))
AND (nvl(pcs.meddig, SYSDATE) BETWEEN to_date('2021-01-01', 'yyyy-mm-dd') AND SYSDATE)
ORDER BY pcs.pilota_szam;

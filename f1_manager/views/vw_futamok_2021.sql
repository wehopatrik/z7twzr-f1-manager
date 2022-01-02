CREATE OR REPLACE VIEW vw_futamok_2021 AS
SELECT f21.verseny_id AS futam_sorszama,
       fo.futam_nev AS futam_neve,
       fo.futam_orszag AS futam_orszaga,
       fo.futam_hely AS futam_helye,
       fo.palya_nev AS palya_neve,
       f21.palyahossz AS palya_hossza,
       f21.kor_szam AS korok_szama,
       po.szemely_nev AS nyertes_pilota_neve,
       cs.csapat_nev AS nyertes_csapat,
       f21.idopont AS futam_ideje
FROM futamok_osszes fo
JOIN futamok2021 f21 ON fo.futam_id = f21.futam_id
JOIN pilotak2021 p21 ON f21.nyertes_pilota_id = p21.pilota_id
JOIN pilotak_osszes po ON p21.szemely_id = po.szemely_id
JOIN csapatok cs ON p21.csapat_id = cs.csapat_id
ORDER BY f21.verseny_id;

SELECT * FROM vw_futamok_2021;

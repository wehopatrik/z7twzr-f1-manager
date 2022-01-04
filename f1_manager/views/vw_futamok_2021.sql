CREATE OR REPLACE VIEW vw_futamok_2021 AS
SELECT fe.hanyadik_futam AS futam_sorszama,
       fo.futam_nev AS futam_neve,
       fo.futam_orszag AS futam_orszaga,
       fo.futam_hely AS futam_helye,
       fo.palya_nev AS palya_neve,
       fe.palyahossz AS palya_hossza,
       fe.kor_szam AS korok_szama,
       po.szemely_nev AS nyertes_pilota_neve,
       cs.csapat_nev AS nyertes_csapat,
       fe.idopont AS futam_ideje
FROM futam_osszes fo
JOIN futam_ev fe ON fo.futam_id = fe.futam_id
JOIN pilota_osszes po ON fe.nyertes_szemely_id = po.szemely_id
JOIN pilota_csapat pcs ON po.szemely_id = pcs.szemely_id
JOIN csapat cs ON pcs.csapat_id = cs.csapat_id
WHERE extract(YEAR from fe.idopont) = 2021
ORDER BY fe.hanyadik_futam;

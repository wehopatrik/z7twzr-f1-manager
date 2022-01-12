CREATE OR REPLACE VIEW vw_futamok_2022 AS
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
FROM futam_ev fe
JOIN futam_osszes fo ON fe.futam_id = fo.futam_id
LEFT JOIN pilota_osszes po ON fe.nyertes_szemely_id = po.szemely_id
LEFT JOIN pilota_csapat pcs ON po.szemely_id = pcs.szemely_id
LEFT JOIN csapat cs ON pcs.csapat_id = cs.csapat_id
WHERE (extract(YEAR from fe.idopont) = 2022)
--AND (pcs.mettol BETWEEN to_date('1950-01-01', 'yyyy-mm-dd') AND to_date('2022-12-31', 'yyyy-mm-dd'))
--AND (nvl(pcs.meddig, to_date('2022-12-31', 'yyyy-mm-dd')) BETWEEN to_date('2022-01-01', 'yyyy-mm-dd') AND to_date('2022-12-31', 'yyyy-mm-dd'))
ORDER BY fe.idopont;

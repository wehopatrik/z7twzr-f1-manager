select pkg_motorgyarto.motorgyarto_adatok() from dual;

select pkg_csapat.csapat_adatok() from dual;

select pkg_pilota_osszes.pilota_osszes_adatok() from dual;

select pkg_pilota_csapat.pilota_csapat_adatok() from dual;

select pkg_futam_osszes.futam_osszes_adatok() from dual;

select pkg_futam_ev.futam_ev_adatok() from dual;


-- másik csomag tesztelése
select pkg_szezon_adatok.szezon_adatok(2021) from dual;

-- függvények tesztelése
select func_hany_kor_gumi(2021,10,3) from dual; -- ev, hanyadik_futam, milyen_gumi

select func_hanyszor_nyert(2021,33) from dual; -- ev, pilota_szam


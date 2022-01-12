-- 2022-ben a Hawaii futam magas sz�m� koronav�rus fert�z�tt miatt nem ker�l megrendez�sre
BEGIN
  pkg_futam_ev.torles_futam_ev(p_futam_ev_id => 46);
END;
/ 
-- Hiba miatt t�r�lj�k a futamot is az �sszes futamot nyilv�ntart� t�bl�b�l
BEGIN
  pkg_futam_osszes.torles_futam_osszes(p_futam_id => 28);
END;
/
-- 2022-ben m�gsem vesz r�szt egyik Wehy Racing Team pil�ta
BEGIN
  pkg_pilota_csapat.torles_pilota_csapat(p_pilota_csapat_id => 27);
END;
/
BEGIN
  pkg_pilota_csapat.torles_pilota_csapat(p_pilota_csapat_id => 28);
END;
/
-- A Wehy Racing Team pil�t�kat hiba miatt t�r�lni kell az �sszes pil�t�t nyilv�ntart� t�bl�b�l
BEGIN
  pkg_pilota_osszes.torles_pilota_osszes(p_szemely_id => 24);
END;
/
BEGIN
  pkg_pilota_osszes.torles_pilota_osszes(p_szemely_id => 25);
END;
/
-- Wehy Racing Team csapatot t�r�lni kell, mert m�gsem l�tezik a csapat
BEGIN
  pkg_csapat.torles_csapat(p_csapat_id => 11);
END;
/
-- Emiatt a Porsche motorgyart�t is t�r�lni kell, hiszen nem tudja kinek sz�ll�tani a motort,
-- �s csal�dotts�gb�l soha vissza sem sz�ll
BEGIN
  pkg_motorgyarto.torles_motorgyarto(p_motorgyarto_id => 5);
END;
/
COMMIT;

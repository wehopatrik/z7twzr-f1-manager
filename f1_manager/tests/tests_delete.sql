-- 2022-ben a Hawaii futam magas számú koronavírus fertõzött miatt nem kerül megrendezésre
BEGIN
  pkg_futam_ev.torles_futam_ev(p_futam_ev_id => 46);
END;
/ 
-- Hiba miatt töröljük a futamot is az összes futamot nyilvántartó táblából
BEGIN
  pkg_futam_osszes.torles_futam_osszes(p_futam_id => 28);
END;
/
-- 2022-ben mégsem vesz részt egyik Wehy Racing Team pilóta
BEGIN
  pkg_pilota_csapat.torles_pilota_csapat(p_pilota_csapat_id => 27);
END;
/
BEGIN
  pkg_pilota_csapat.torles_pilota_csapat(p_pilota_csapat_id => 28);
END;
/
-- A Wehy Racing Team pilótákat hiba miatt törölni kell az összes pilótát nyilvántartó táblából
BEGIN
  pkg_pilota_osszes.torles_pilota_osszes(p_szemely_id => 24);
END;
/
BEGIN
  pkg_pilota_osszes.torles_pilota_osszes(p_szemely_id => 25);
END;
/
-- Wehy Racing Team csapatot törölni kell, mert mégsem létezik a csapat
BEGIN
  pkg_csapat.torles_csapat(p_csapat_id => 11);
END;
/
-- Emiatt a Porsche motorgyartót is törölni kell, hiszen nem tudja kinek szállítani a motort,
-- és csalódottságból soha vissza sem száll
BEGIN
  pkg_motorgyarto.torles_motorgyarto(p_motorgyarto_id => 5);
END;
/
COMMIT;

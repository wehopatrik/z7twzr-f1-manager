-- Audi motorgyarto Porsch�ra
BEGIN
  pkg_motorgyarto.motorgyarto_modositas(p_motorgyarto_id => 5, p_motorgyarto_nev => 'Porsche');
END;
/
-- Weho Racing Team csapat Wehy Racing Team n�vre
BEGIN
  pkg_csapat.csapat_modositas(p_csapat_id      => 11,
                              p_csapat_nev     => 'Wehy Racing Team');
END;
/
-- Wehy Racing Team k�zpontj�nak helye P�csre Budapest helyett
BEGIN
  pkg_csapat.csapat_modositas(p_csapat_id      => 11,
                              p_kozpont_hely   => 'P�cs');
END;
/
-- S�ska J�ska sz�let�si d�tuma rosszul lett be�rva
BEGIN
  pkg_pilota_osszes.pilota_osszes_modositas(p_szemely_id  => 25,
                                            p_szul_datum  => DATE '1999-12-15');
END;
/
-- S�ska J�ska helyett 2023-ban �j pil�ta lesz a Wehy Racing Teamn�l, �gy v�get �r majd a szerz�d�se
BEGIN
  pkg_pilota_csapat.pilota_csapat_modositas(p_pilota_csapat_id => 28,
                                            p_meddig           => DATE '2022-12-31');
END;
/
-- Hawaii futamnak a p�lya nev�t megv�ltoztatt�k
BEGIN
  pkg_futam_osszes.futam_osszes_modositas(p_futam_id     => 28,
                                          p_palya_nev    => 'Hawaii Circuit');
END;
/
-- 2022-ben a Hawaii futam p�lya hossz�t is megv�ltoztatt�k �t�p�t�s miatt
BEGIN
  pkg_futam_ev.futam_ev_modositas(p_futam_ev_id            => 46,
                                  p_palyahossz             => 4.834);
END;
/ 
COMMIT;

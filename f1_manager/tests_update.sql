-- Audi motorgyarto Porschéra
BEGIN
  pkg_motorgyarto.motorgyarto_modositas(p_motorgyarto_id => 5, p_motorgyarto_nev => 'Porsche');
END;
/
-- Weho Racing Team csapat Wehy Racing Team névre
BEGIN
  pkg_csapat.csapat_modositas(p_csapat_id      => 11,
                              p_csapat_nev     => 'Wehy Racing Team');
END;
/
-- Wehy Racing Team központjának helye Pécsre Budapest helyett
BEGIN
  pkg_csapat.csapat_modositas(p_csapat_id      => 11,
                              p_kozpont_hely   => 'Pécs');
END;
/
-- Sóska Jóska születési dátuma rosszul lett beírva
BEGIN
  pkg_pilota_osszes.pilota_osszes_modositas(p_szemely_id  => 25,
                                            p_szul_datum  => DATE '1999-12-15');
END;
/
-- Sóska Jóska helyett 2023-ban új pilóta lesz a Wehy Racing Teamnél, így véget ér majd a szerzõdése
BEGIN
  pkg_pilota_csapat.pilota_csapat_modositas(p_pilota_csapat_id => 28,
                                            p_meddig           => DATE '2022-12-31');
END;
/
-- Hawaii futamnak a pálya nevét megváltoztatták
BEGIN
  pkg_futam_osszes.futam_osszes_modositas(p_futam_id     => 28,
                                          p_palya_nev    => 'Hawaii Circuit');
END;
/
-- 2022-ben a Hawaii futam pálya hosszát is megváltoztatták átépítés miatt
BEGIN
  pkg_futam_ev.futam_ev_modositas(p_futam_ev_id            => 46,
                                  p_palyahossz             => 4.834);
END;
/ 
COMMIT;

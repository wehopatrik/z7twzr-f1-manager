-- új motorgyártó
BEGIN
  pkg_motorgyarto.uj_motorgyarto(p_motorgyarto_nev => 'Audi');
END;
/
-- új csapat
BEGIN
  pkg_csapat.uj_csapat(p_csapat_nev     => 'Weho Racing Team',
                       p_motorgyarto_id => 5,
                       p_csatlakozas_ev => 2022,
                       p_kozpont_hely   => 'Budapest',
                       p_kozpont_orszag => 'Magyarország');
END;
/
-- új pilóták
BEGIN
  pkg_pilota_osszes.uj_pilota_osszes(p_szemely_nev => 'Patrik Wehovszky',
                                     p_szul_datum  => DATE '2000-08-05',
                                     p_szul_orszag => 'Magyarország',
                                     p_szul_hely   => 'Szekszárd',
                                     p_nemzetiseg  => 'magyar');
END;
/
BEGIN                                  
  pkg_pilota_osszes.uj_pilota_osszes(p_szemely_nev => 'Joska Soska',
                                     p_szul_datum  => DATE '1999-11-14',
                                     p_szul_orszag => 'Amerikai Egyesült Államok',
                                     p_szul_hely   => 'New York',
                                     p_nemzetiseg  => 'amerikai');
END;
/
-- új pilóták a csapatnak
BEGIN
  pkg_pilota_csapat.uj_pilota_csapat(p_szemely_id  => 24,
                                     p_csapat_id   => 11,
                                     p_pilota_szam => 15,
                                     p_mettol      => DATE '2022-01-01',
                                     p_meddig      => null);
END;
/
BEGIN
  pkg_pilota_csapat.uj_pilota_csapat(p_szemely_id  => 25,
                                     p_csapat_id   => 11,
                                     p_pilota_szam => 35,
                                     p_mettol      => DATE '2022-01-01',
                                     p_meddig      => null);
END;
/
-- új futam az összes eddigi futamok közé
BEGIN
  pkg_futam_osszes.uj_futam_osszes(p_futam_nev    => 'Hawaii Nagydíj',
                                   p_futam_orszag => 'Hawaii',
                                   p_futam_hely   => 'Pahoa',
                                   p_palya_nev    => 'Hawaii Pahoa Circuit');
END;
/
-- új futam 2022-es évre
BEGIN
  pkg_futam_ev.uj_futam_ev(p_futam_id               => 28,
                           p_hanyadik_futam         => 24,
                           p_palyahossz             => 4.612,
                           p_kor_szam               => null,
                           p_nyertes_szemely_id     => null,
                           p_leggyorsabb_szemely_id => null,
                           p_leggyorsabb_ido        => null,
                           p_idopont                => DATE '2022-12-04');
END;
/
COMMIT;

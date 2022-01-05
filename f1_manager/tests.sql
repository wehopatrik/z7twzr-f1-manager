-- �j motorgy�rt�
BEGIN
  pkg_motorgyarto.uj_motorgyarto(p_motorgyarto_nev => 'Audi');
END;

-- �j csapat
BEGIN
  pkg_csapat.uj_csapat(p_csapat_nev     => 'Weho Racing Team',
                       p_motorgyarto_id => 5,
                       p_csatlakozas_ev => 2022,
                       p_kozpont_hely   => 'Budapest',
                       p_kozpont_orszag => 'Magyarorsz�g');
END;

-- �j pil�t�k
BEGIN
  pkg_pilota_osszes.uj_pilota_osszes(p_szemely_nev => 'Patrik Wehovszky',
                                     p_szul_datum  => DATE '2000-08-05',
                                     p_szul_orszag => 'Magyarorsz�g',
                                     p_szul_hely   => 'Szeksz�rd',
                                     p_nemzetiseg  => 'magyar');
END;

BEGIN                                  
  pkg_pilota_osszes.uj_pilota_osszes(p_szemely_nev => 'Joska Soska',
                                     p_szul_datum  => DATE '1999-11-14',
                                     p_szul_orszag => 'Amerikai Egyes�lt �llamok',
                                     p_szul_hely   => 'New York',
                                     p_nemzetiseg  => 'amerikai');
END;

-- �j pil�t�k a csapatnak
BEGIN
  pkg_pilota_csapat.uj_pilota_csapat(p_szemely_id  => 24,
                                     p_csapat_id   => 11,
                                     p_pilota_szam => 15,
                                     p_mettol      => DATE '2022-01-01',
                                     p_meddig      => null);
END;

BEGIN
  pkg_pilota_csapat.uj_pilota_csapat(p_szemely_id  => 25,
                                     p_csapat_id   => 11,
                                     p_pilota_szam => 35,
                                     p_mettol      => DATE '2022-01-01',
                                     p_meddig      => null);
END;

COMMIT;

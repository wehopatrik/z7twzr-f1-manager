-- �j motorgy�rt�
BEGIN
  pkg_uj_elem.uj_motorgyarto(p_motorgyarto_nev => 'Audi');
END;

-- �j csapat
BEGIN
  pkg_uj_elem.uj_csapat(p_csapat_nev => 'Weho Racing Team',
                        p_motorgyarto_id => 5,
                        p_csatlakozas_ev => 2021,
                        p_kozpont_hely => 'Budapest',
                        p_kozpont_orszag => 'Magyarorsz�g');
END;

-- �j pil�ta a csapatnak
BEGIN
  pkg_uj_elem.uj_pilota(p_szemely_nev => 'Wehovszky Patrik M�rk',
                        p_szul_datum => 2000-08-15,
                        p_szul_orszag => 'Magyarorsz�g',
                        p_szul_hely => 'Szeksz�rd',
                        p_nemzetiseg => 'magyar');
END;

-- �j pil�ta a csapatnak
BEGIN
  pkg_uj_elem.uj_pilota(p_szemely_nev => 'S�ska J�ska',
                        p_szul_datum => DATE '1999-06-20',
                        p_szul_orszag => 'Magyarorsz�g',
                        p_szul_hely => 'P�cs',
                        p_nemzetiseg => 'magyar');
END;

-- 2021-es �vbe sorol�suk
BEGIN
  pkg_uj_elem.uj_pilota2021(p_pilota_id => 15,
                            p_szemely_id => 24,
                            p_csapat_id => 11);
END;

-- 2021-es �vbe sorol�suk
BEGIN
  pkg_uj_elem.uj_pilota2021(p_pilota_id => 45,
                            p_szemely_id => 25,
                            p_csapat_id => 11);
END;

COMMIT;

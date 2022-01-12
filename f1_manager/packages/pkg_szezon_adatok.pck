CREATE OR REPLACE PACKAGE pkg_szezon_adatok IS

  PROCEDURE szezon_adatok(p_szezon_ev IN NUMBER);

END pkg_szezon_adatok;
/
CREATE OR REPLACE PACKAGE BODY pkg_szezon_adatok IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_szezon_adatok';

  PROCEDURE szezon_adatok(p_szezon_ev IN NUMBER) IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'szezon_adatok';
    c_list ty_futam_adatok_l;
    
  BEGIN
    SELECT ty_futam_adatok(fo.futam_nev,                -- futam_nev
                           po1.szemely_nev,             -- nyertes_pilota
                           cs.csapat_nev,               -- nyertes_csapat
                           po2.szemely_nev              -- leggyorsabb_pilota
                          )
    BULK COLLECT
    INTO c_list
    FROM futam_ev fe
      LEFT JOIN pilota_osszes po1 ON po1.szemely_id = fe.nyertes_szemely_id
      LEFT JOIN pilota_osszes po2 ON po2.szemely_id = fe.leggyorsabb_szemely_id
      JOIN futam_osszes fo ON fo.futam_id = fe.futam_id
      JOIN pilota_csapat pcs ON pcs.szemely_id = po1.szemely_id
      JOIN csapat cs ON cs.csapat_id = pcs.csapat_id 
    WHERE (extract(YEAR FROM fe.idopont) = p_szezon_ev)
    AND (pcs.mettol BETWEEN to_date('1950-01-01', 'yyyy-mm-dd') AND to_date(p_szezon_ev || '-12-31', 'yyyy-mm-dd'))
    AND (nvl(pcs.meddig, to_date(p_szezon_ev || '-12-31', 'yyyy-mm-dd')) BETWEEN to_date(p_szezon_ev || '-01-01', 'yyyy-mm-dd') AND to_date(p_szezon_ev || '-12-31', 'yyyy-mm-dd'))
    ORDER BY fe.idopont;

    FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line(i || '. futam neve: ' || c_list(i).futam_nev || chr(10) ||
                           'Nyertes pilota: ' || c_list(i).nyertes_pilota || chr(10) ||
                           'Nyertes csapat: ' || c_list(i).nyertes_csapat || chr(10) ||
                           'Leggyorsabb pilota: ' || c_list(i).leggyorsabb_pilota || chr(10));
    END LOOP;
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END;

BEGIN
  null;
END pkg_szezon_adatok;
/

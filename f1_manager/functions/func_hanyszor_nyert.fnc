CREATE OR REPLACE FUNCTION func_hanyszor_nyert (p_szezon_ev IN NUMBER, p_pilota_szam IN NUMBER) RETURN NUMBER IS

  func_nev VARCHAR2(30) := 'func_hanyszor_nyert';
  v_szamlalo NUMBER;
  v_nyertes_pilota_neve VARCHAR2(30);

BEGIN
  v_szamlalo := 0;

  SELECT DISTINCT count(fe.nyertes_szemely_id), po.szemely_nev INTO v_szamlalo, v_nyertes_pilota_neve FROM pilota_osszes po
  JOIN futam_ev fe ON po.szemely_id = fe.nyertes_szemely_id
  JOIN pilota_csapat pcs ON pcs.szemely_id = po.szemely_id
  WHERE (pcs.pilota_szam LIKE p_pilota_szam) AND (extract(YEAR FROM fe.idopont) = p_szezon_ev)
  AND (pcs.mettol BETWEEN to_date('1950-01-01', 'yyyy-mm-dd') AND to_date(p_szezon_ev || '-12-31', 'yyyy-mm-dd')) -- 1950 - p_szezon_ev_eleje
  AND (nvl(pcs.meddig, SYSDATE) BETWEEN to_date(p_szezon_ev || '-01-01', 'yyyy-mm-dd') AND SYSDATE)               -- p_szezon_ev_vege - SYSDATE
  GROUP BY po.szemely_nev;
  
  -- ellenõrzésképpen
  dbms_output.put_line('Pilóta neve: ' || v_nyertes_pilota_neve || chr(10) ||
                       'Nyereségek száma: ' || v_szamlalo);

  RETURN v_szamlalo;

  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_pilota_szam = ' || p_pilota_szam,
                                 p_api         => func_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nem talalhato valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev,
                                 p_api         => func_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
      
END;
/

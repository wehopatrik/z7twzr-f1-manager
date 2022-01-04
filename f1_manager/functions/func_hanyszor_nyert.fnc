CREATE OR REPLACE FUNCTION func_hanyszor_nyert (p_szezon_ev IN NUMBER, p_pilota_szam IN NUMBER) RETURN ty_hanyszor_nyert_l IS

  func_nev VARCHAR2(30) := 'func_hanyszor_nyert';
  v_szamlalo NUMBER;
  c_list ty_hanyszor_nyert_l;

BEGIN
  v_szamlalo := 0;

  SELECT count(fe.nyertes_szemely_id) INTO v_szamlalo FROM pilota_osszes po
  JOIN futam_ev fe ON po.szemely_id = fe.nyertes_szemely_id
  JOIN pilota_csapat pcs ON pcs.szemely_id = po.szemely_id
  WHERE (pcs.pilota_szam LIKE p_pilota_szam) AND (extract(YEAR FROM fe.idopont) = p_szezon_ev)
  AND (pcs.mettol BETWEEN to_date('1950-01-01', 'yyyy-mm-dd') AND to_date(p_szezon_ev || '-12-31', 'yyyy-mm-dd'))
  AND (nvl(pcs.meddig, SYSDATE) BETWEEN to_date(p_szezon_ev || '-01-01', 'yyyy-mm-dd') AND SYSDATE);
  
  SELECT ty_hanyszor_nyert(po.szemely_nev,                -- nyertes_pilota
                           v_szamlalo   -- nyereseg_szama
                          )
    BULK COLLECT
    INTO c_list
    FROM pilota_osszes po
      JOIN futam_ev fe ON po.szemely_id = fe.nyertes_szemely_id
      JOIN futam_osszes fo ON fo.futam_id = fe.futam_id
      JOIN pilota_csapat pcs ON pcs.szemely_id = po.szemely_id
      JOIN csapat cs ON cs.csapat_id = pcs.csapat_id 
    WHERE (extract(YEAR FROM fe.idopont) = p_szezon_ev)
    AND (pcs.mettol BETWEEN to_date('1950-01-01', 'yyyy-mm-dd') AND to_date(p_szezon_ev || '-12-31', 'yyyy-mm-dd'))
    AND (nvl(pcs.meddig, SYSDATE) BETWEEN to_date(p_szezon_ev || '-01-01', 'yyyy-mm-dd') AND SYSDATE);

  FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Pilóta neve: ' || c_list(i).nyertes_pilota || chr(10) ||
                           'Nyereségek száma: ' || c_list(i).nyereseg_szama);
    END LOOP;

  RETURN c_list;

  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_pilota_szam = ' || p_pilota_szam,
                                   p_api         => func_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nem talalhato valamilyen adat.');
    RAISE pkg_kivetelek.exc_nincs_adat_hiba;
END;
/

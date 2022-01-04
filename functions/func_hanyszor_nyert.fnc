CREATE OR REPLACE FUNCTION func_hanyszor_nyert (p_szezon_ev IN NUMBER, p_pilota_id IN NUMBER) RETURN NUMBER IS
  proc_nev VARCHAR2(30) := 'func_hanyszor_nyert'; 
  
  v_szamlalo NUMBER;
  v_pilota_nev VARCHAR(40);
  
BEGIN
  v_szamlalo := 0;
  
  CASE p_szezon_ev
    WHEN 2021 THEN
      SELECT po.szemely_nev INTO v_pilota_nev FROM pilotak_osszes po JOIN pilotak2021 p21 ON p21.szemely_id = po.szemely_id WHERE p21.pilota_id LIKE p_pilota_id;
      SELECT count(f21.nyertes_pilota_id) INTO v_szamlalo FROM futamok2021 f21 WHERE f21.nyertes_pilota_id LIKE p_pilota_id;
    WHEN 2022 THEN
      SELECT po.szemely_nev INTO v_pilota_nev FROM pilotak2022 p22 JOIN pilotak_osszes po ON p22.szemely_id = po.szemely_id WHERE p22.pilota_id LIKE p_pilota_id;
      SELECT count(f22.nyertes_pilota_id) INTO v_szamlalo FROM futamok2022 f22 WHERE f22.nyertes_pilota_id LIKE p_pilota_id;
    ELSE
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_pilota_id = ' || p_pilota_id,
                                 p_api         => proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_ilyen_ev_hiba_code, 'Nincs ilyen ev.');
      RAISE pkg_kivetelek.exc_nincs_ilyen_ev_hiba;
  END CASE;
  

  dbms_output.put_line(v_pilota_nev || ' ennyiszer nyert futamot: ' || v_szamlalo || ' db');
  
  RETURN v_szamlalo;
  
  EXCEPTION WHEN no_data_found THEN
    pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_pilota_id = ' || p_pilota_id,
                                 p_api         => proc_nev);
    raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nem talalhato valamilyen adat.');
    RAISE pkg_kivetelek.exc_nincs_adat_hiba;
END;
/

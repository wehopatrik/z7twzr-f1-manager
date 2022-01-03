CREATE OR REPLACE FUNCTION func_hany_kor_gumi (p_szezon_ev IN NUMBER, p_futam_id IN NUMBER, p_gumi_tipus IN NUMBER) RETURN NUMBER IS
  proc_nev VARCHAR2(30) := 'func_hany_kor_gumi';  

  v_palya_hossza NUMBER;
  v_gumi_alap_km NUMBER;
  v_korok_adott_gumival NUMBER;
  
BEGIN
  CASE p_szezon_ev
    WHEN 2021 THEN
      SELECT f21.palyahossz INTO v_palya_hossza from futamok2021 f21 WHERE p_futam_id LIKE f21.verseny_id;
    WHEN 2022 THEN
      SELECT f22.palyahossz INTO v_palya_hossza from futamok2022 f22 WHERE p_futam_id LIKE f22.verseny_id;
    ELSE
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_futam_id = ' || p_futam_id || chr(10) ||
                                                  'p_gumi_tipus = ' || p_gumi_tipus,
                                 p_api         => proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_ilyen_ev_hiba_code, 'Nincs ilyen ev.');
      RAISE pkg_kivetelek.exc_nincs_ilyen_ev_hiba;
  END CASE;
  
  CASE p_gumi_tipus
    WHEN 1 THEN
      v_gumi_alap_km := 60;
      v_korok_adott_gumival := v_gumi_alap_km / v_palya_hossza;
    WHEN 2 THEN
      v_gumi_alap_km := 90;
      v_korok_adott_gumival := v_gumi_alap_km / v_palya_hossza;
    WHEN 3 THEN
      v_gumi_alap_km := 120;
      v_korok_adott_gumival := v_gumi_alap_km / v_palya_hossza;
    ELSE
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_futam_id = ' || p_futam_id || chr(10) ||
                                                  'p_gumi_tipus = ' || p_gumi_tipus,
                                 p_api         => proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_ilyen_gumi_code, 'Nincs ilyen gumitipus.');
      RAISE pkg_kivetelek.exc_nincs_ilyen_gumi;
  END CASE;
  
  dbms_output.put_line('Adott gumival birt korok szama: ' || trunc(v_korok_adott_gumival,3) || chr(10) || 'Alapbol a gumi ennyi km-t bir ki: ' || v_gumi_alap_km || ' km' || chr(10) || 'A palya hossza: ' || v_palya_hossza || ' km');
  
  RETURN v_korok_adott_gumival;
  
  EXCEPTION WHEN no_data_found THEN
    pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                               p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev || chr(10) || 'p_futam_id = ' || p_futam_id || chr(10) ||
                                                'p_gumi_tipus = ' || p_gumi_tipus,
                               p_api         => proc_nev);
    raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nem talalhato valamilyen adat.');
    RAISE pkg_kivetelek.exc_nincs_adat_hiba;
END;
/

CREATE OR REPLACE PROCEDURE futam_adatok(p_szezon_ev IN NUMBER, p_futam_id IN NUMBER) IS
  proc_nev VARCHAR(40) := 'func_hanyszor_nyert';
  
  v_futam_nev VARCHAR2(30);
  v_nyertes_pilota VARCHAR2(30);
  v_nyertes_csapat VARCHAR2(30);
  v_leggyorsabb_pilota VARCHAR2(30);

BEGIN
  CASE p_szezon_ev
    WHEN 2021 THEN
      SELECT fo.futam_nev INTO v_futam_nev FROM futamok2021 f21 JOIN futamok_osszes fo ON f21.futam_id = fo.futam_id WHERE f21.verseny_id LIKE p_futam_id;
      SELECT po.szemely_nev INTO v_nyertes_pilota FROM futamok2021 f21 JOIN pilotak2021 p21 ON f21.nyertes_pilota_id = p21.pilota_id  JOIN pilotak_osszes po ON p21.szemely_id = po.szemely_id WHERE f21.verseny_id LIKE p_futam_id;
      SELECT cs.csapat_nev INTO v_nyertes_csapat FROM futamok2021 f21 JOIN pilotak2021 p21 ON f21.nyertes_pilota_id = p21.pilota_id JOIN csapatok cs ON p21.csapat_id = cs.csapat_id WHERE f21.verseny_id LIKE p_futam_id;
      SELECT po.szemely_nev INTO v_leggyorsabb_pilota FROM futamok2021 f21 JOIN pilotak2021 p21 ON f21.leggyorsabb_pilota_id = p21.pilota_id JOIN pilotak_osszes po ON p21.szemely_id = po.szemely_id WHERE f21.verseny_id LIKE p_futam_id;
    WHEN 2022 THEN
      SELECT fo.futam_nev INTO v_futam_nev FROM futamok2022 f22 JOIN futamok_osszes fo ON f22.futam_id = fo.futam_id WHERE f22.verseny_id LIKE p_futam_id;
      SELECT po.szemely_nev INTO v_nyertes_pilota FROM futamok2022 f22 JOIN pilotak2022 p22 ON f22.nyertes_pilota_id = p22.pilota_id  JOIN pilotak_osszes po ON p22.szemely_id = po.szemely_nev WHERE f22.verseny_id LIKE p_futam_id;
      SELECT cs.csapat_nev INTO v_nyertes_csapat FROM futamok2022 f22 JOIN pilotak2022 p22 ON f22.nyertes_pilota_id = p22.pilota_id JOIN csapatok cs ON p22.csapat_id = cs.csapat_id WHERE f22.verseny_id LIKE p_futam_id;
      SELECT po.szemely_nev INTO v_leggyorsabb_pilota FROM futamok2022 f22 JOIN pilotak2022 p22 ON f22.leggyorsabb_pilota_id = p22.pilota_id JOIN pilotak_osszes po ON p22.szemely_id = po.szemely_nev WHERE f22.verseny_id LIKE p_futam_id;
    ELSE
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev ||
                                                  chr(10) || 'p_futam_id = ' ||
                                                  p_futam_id,
                                 p_api         => proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_ilyen_ev_hiba_code, 'Nincs ilyen ev.');
      RAISE pkg_kivetelek.exc_nincs_ilyen_ev_hiba;
  END CASE;

  dbms_output.put_line('Futam neve: ' || v_futam_nev || chr(10) || 'Nyertes pilota: ' || v_nyertes_pilota || chr(10) || 'Nyertes csapat: ' || v_nyertes_csapat || chr(10) || 'Leggyorsabb pilota: ' || v_leggyorsabb_pilota);

  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_szezon_ev = ' || p_szezon_ev ||
                                                  chr(10) || 'p_futam_id = ' ||
                                                  p_futam_id,
                                 p_api         => proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;

END;
/

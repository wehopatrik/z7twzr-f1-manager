CREATE OR REPLACE FUNCTION func_hanyszor_nyert (p_szezon_ev IN NUMBER, p_pilota_id IN NUMBER) RETURN NUMBER IS
  v_szamlalo NUMBER;
  v_pilota_nev VARCHAR(40);
  
  exc_nincs_adat EXCEPTION;
  PRAGMA EXCEPTION_INIT(exc_nincs_adat, -20000);
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
      raise_application_error(-20000, 'Nincs ilyen ev.');
      RAISE exc_nincs_adat;
  END CASE;
  

  dbms_output.put_line(v_pilota_nev || ' ennyiszer nyert futamot: ' || v_szamlalo || ' db');
  
  RETURN v_szamlalo;
  
  EXCEPTION WHEN no_data_found THEN
   raise_application_error(-20000, 'Nem talalhato valamilyen adat.');
   RAISE exc_nincs_adat;
END;
/

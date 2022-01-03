CREATE OR REPLACE FUNCTION func_hany_kor_gumi (p_szezon_ev IN NUMBER, p_futam_id IN NUMBER, p_gumi_tipus IN NUMBER) RETURN NUMBER IS
  v_palya_hossza NUMBER;
  v_gumi_alap_km NUMBER;
  v_korok_adott_gumival NUMBER;
  
  exc_nincs_adat EXCEPTION;
  PRAGMA EXCEPTION_INIT(exc_nincs_adat, -20000);
  exc_nincs_ev EXCEPTION;
  PRAGMA EXCEPTION_INIT(exc_nincs_ev, -20001);
  exc_nincs_gumi EXCEPTION;
  PRAGMA EXCEPTION_INIT(exc_nincs_gumi, -20002);
  
BEGIN
  CASE p_szezon_ev
    WHEN 2021 THEN
      SELECT f21.palyahossz INTO v_palya_hossza from futamok2021 f21 WHERE p_futam_id LIKE f21.verseny_id;
    WHEN 2022 THEN
      SELECT f22.palyahossz INTO v_palya_hossza from futamok2022 f22 WHERE p_futam_id LIKE f22.verseny_id;
    ELSE
      raise_application_error(-20001, 'Nem talalhato ilyen ev.');
      RAISE exc_nincs_ev;
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
      raise_application_error(-20002, 'Nem talalhato ilyen gumitipus.');
      RAISE exc_nincs_gumi;
  END CASE;
  
  dbms_output.put_line('Adott gumival birt korok szama: ' || trunc(v_korok_adott_gumival,3) || chr(10) || 'Alapbol a gumi ennyi km-t bir ki: ' || v_gumi_alap_km || ' km' || chr(10) || 'A palya hossza: ' || v_palya_hossza || ' km');
  
  RETURN v_korok_adott_gumival;
  
  EXCEPTION WHEN no_data_found THEN
   raise_application_error(-20000, 'Nem talalhato valamilyen adat.');
   RAISE exc_nincs_adat;
END;
/

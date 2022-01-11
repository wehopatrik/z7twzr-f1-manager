CREATE OR REPLACE PACKAGE pkg_motorgyarto IS

  PROCEDURE uj_motorgyarto(p_motorgyarto_nev IN VARCHAR2);

  PROCEDURE motorgyarto_modositas(p_motorgyarto_id  IN NUMBER
                                 ,p_motorgyarto_nev IN VARCHAR2 DEFAULT NULL);

  PROCEDURE motorgyarto_adatok(p_motorgyarto_id IN NUMBER);
    
END pkg_motorgyarto;
/
CREATE OR REPLACE PACKAGE BODY pkg_motorgyarto IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_motorgyarto';

  -- uj motorgyarto a motorgyarto tablaba
  PROCEDURE uj_motorgyarto(p_motorgyarto_nev IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_motorgyarto';
  BEGIN
    INSERT INTO motorgyarto (motorgyarto_nev) VALUES (p_motorgyarto_nev);
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_motorgyarto_nev = ' ||
                                                  p_motorgyarto_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_motorgyarto_nev = ' ||
                                                  p_motorgyarto_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_motorgyarto;

  -- modositas a motorgyarto tablaban
  PROCEDURE motorgyarto_modositas(p_motorgyarto_id  IN NUMBER
                                 ,p_motorgyarto_nev IN VARCHAR2 DEFAULT NULL) IS
  
    c_proc_nev CONSTANT VARCHAR(30) := 'motorgyarto_modositas';
    uj_motorgyarto_nev VARCHAR2(30);
    
  BEGIN
    uj_motorgyarto_nev := p_motorgyarto_nev;  
  
    IF p_motorgyarto_nev IS NULL THEN
      SELECT m.motorgyarto_nev INTO uj_motorgyarto_nev FROM motorgyarto m WHERE m.motorgyarto_id = p_motorgyarto_id;
    END IF;
  
    UPDATE motorgyarto m
       SET m.motorgyarto_nev = uj_motorgyarto_nev
     WHERE m.motorgyarto_id = p_motorgyarto_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_motorgyarto_id = ' ||
                                                  p_motorgyarto_id ||
                                                  chr(10) ||
                                                  'p_motorgyarto_nev = ' ||
                                                  p_motorgyarto_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_motorgyarto_id = ' ||
                                                  p_motorgyarto_id ||
                                                  chr(10) ||
                                                  'p_motorgyarto_nev = ' ||
                                                  p_motorgyarto_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END motorgyarto_modositas;
  
  -- motorgyarto tabla kiiratasa vagy egy motorgyarto kiiratasa
  PROCEDURE motorgyarto_adatok(p_motorgyarto_id IN NUMBER) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'motorgyarto_adatok';
    c_list ty_motorgyarto_l;
    
  BEGIN
    CASE
      WHEN p_motorgyarto_id IS NULL THEN
        SELECT ty_motorgyarto(m.motorgyarto_id,
                              m.motorgyarto_nev)
        BULK COLLECT
        INTO c_list
        FROM motorgyarto m;
      ELSE
        SELECT ty_motorgyarto(m.motorgyarto_id,
                              m.motorgyarto_nev)
        BULK COLLECT
        INTO c_list
        FROM motorgyarto m
        WHERE m.motorgyarto_id = p_motorgyarto_id;
    END CASE;

    FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Motorgyarto ID: ' || c_list(i).motorgyarto_id || chr(10) ||
                           'Motorgyarto nev: ' || c_list(i).motorgyarto_nev || chr(10));
    END LOOP;
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_motorgyarto_id = ' || p_motorgyarto_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_motorgyarto_id = ' || p_motorgyarto_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END motorgyarto_adatok;

END pkg_motorgyarto;
/

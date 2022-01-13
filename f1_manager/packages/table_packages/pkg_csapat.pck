CREATE OR REPLACE PACKAGE pkg_csapat IS

  PROCEDURE uj_csapat(p_csapat_nev     IN VARCHAR2
                     ,p_motorgyarto_id IN NUMBER
                     ,p_csatlakozas_ev IN NUMBER
                     ,p_kozpont_hely   IN VARCHAR2
                     ,p_kozpont_orszag IN VARCHAR2);

  PROCEDURE csapat_modositas(p_csapat_id      IN NUMBER
                            ,p_csapat_nev     IN VARCHAR2 DEFAULT NULL
                            ,p_motorgyarto_id IN NUMBER   DEFAULT NULL
                            ,p_csatlakozas_ev IN NUMBER   DEFAULT NULL
                            ,p_kozpont_hely   IN VARCHAR2 DEFAULT NULL
                            ,p_kozpont_orszag IN VARCHAR2 DEFAULT NULL);
  
  PROCEDURE torles_csapat(p_csapat_id IN NUMBER);
  
  FUNCTION csapat_adatok(p_csapat_id IN NUMBER DEFAULT NULL) RETURN ty_csapat_l;

END pkg_csapat;
/
CREATE OR REPLACE PACKAGE BODY pkg_csapat IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_csapat';

  -- uj csapat a csapat tablaba
  PROCEDURE uj_csapat(p_csapat_nev     IN VARCHAR2
                     ,p_motorgyarto_id IN NUMBER
                     ,p_csatlakozas_ev IN NUMBER
                     ,p_kozpont_hely   IN VARCHAR2
                     ,p_kozpont_orszag IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'uj_csapat';
  BEGIN
    INSERT INTO csapat
      (csapat_nev
      ,motorgyarto_id
      ,csatlakozas_ev
      ,kozpont_hely
      ,kozpont_orszag)
    VALUES
      (p_csapat_nev
      ,p_motorgyarto_id
      ,p_csatlakozas_ev
      ,p_kozpont_hely
      ,p_kozpont_orszag);
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_csapat_nev = ' ||
                                                  p_csapat_nev || chr(10) ||
                                                  'p_motorgyarto_id = ' ||
                                                  p_motorgyarto_id ||
                                                  chr(10) ||
                                                  'p_csatlakozas_ev = ' ||
                                                  p_csatlakozas_ev ||
                                                  chr(10) ||
                                                  'p_kozpont_hely = ' ||
                                                  p_kozpont_hely || chr(10) ||
                                                  'p_kozpont_orszag = ' ||
                                                  p_kozpont_orszag,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_csapat_nev = ' ||
                                                  p_csapat_nev || chr(10) ||
                                                  'p_motorgyarto_id = ' ||
                                                  p_motorgyarto_id ||
                                                  chr(10) ||
                                                  'p_csatlakozas_ev = ' ||
                                                  p_csatlakozas_ev ||
                                                  chr(10) ||
                                                  'p_kozpont_hely = ' ||
                                                  p_kozpont_hely || chr(10) ||
                                                  'p_kozpont_orszag = ' ||
                                                  p_kozpont_orszag,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_csapat;

  -- csapat modositas a csapat tablaban
  PROCEDURE csapat_modositas(p_csapat_id      IN NUMBER
                            ,p_csapat_nev     IN VARCHAR2 DEFAULT NULL
                            ,p_motorgyarto_id IN NUMBER   DEFAULT NULL
                            ,p_csatlakozas_ev IN NUMBER   DEFAULT NULL
                            ,p_kozpont_hely   IN VARCHAR2 DEFAULT NULL
                            ,p_kozpont_orszag IN VARCHAR2 DEFAULT NULL) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'csapat_modositas';
    
    v_csapat_nev VARCHAR2(40);
    v_motorgyarto_id NUMBER;
    v_csatlakozas_ev NUMBER;
    v_kozpont_hely VARCHAR2(40);
    v_kozpont_orszag VARCHAR2(40);
  
  BEGIN  
    SELECT nvl(p_csapat_nev, cs.csapat_nev), nvl(p_motorgyarto_id, cs.motorgyarto_id),
           nvl(p_csatlakozas_ev, cs.csatlakozas_ev), nvl(p_kozpont_hely, cs.kozpont_hely),
           nvl(p_kozpont_orszag, cs.kozpont_orszag)
    INTO v_csapat_nev, v_motorgyarto_id, v_csatlakozas_ev, v_kozpont_hely, v_kozpont_orszag
    FROM csapat cs WHERE cs.csapat_id = p_csapat_id;
  
    UPDATE csapat cs
       SET cs.csapat_nev     = v_csapat_nev
          ,cs.motorgyarto_id = v_motorgyarto_id
          ,cs.csatlakozas_ev = v_csatlakozas_ev
          ,cs.kozpont_hely   = v_kozpont_hely
          ,cs.kozpont_orszag = v_kozpont_orszag
     WHERE cs.csapat_id = p_csapat_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_csapat_id = ' ||
                                                  p_csapat_id || chr(10) ||
                                                  'p_csapat_nev = ' ||
                                                  p_csapat_nev || chr(10) ||
                                                  'p_motorgyarto_id = ' ||
                                                  p_motorgyarto_id ||
                                                  chr(10) ||
                                                  'p_csatlakozas_ev = ' ||
                                                  p_csatlakozas_ev ||
                                                  chr(10) ||
                                                  'p_kozpont_hely = ' ||
                                                  p_kozpont_hely || chr(10) ||
                                                  'p_kozpont_orszag = ' ||
                                                  p_kozpont_orszag,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_csapat_id = ' ||
                                                  p_csapat_id || chr(10) ||
                                                  'p_csapat_nev = ' ||
                                                  p_csapat_nev || chr(10) ||
                                                  'p_motorgyarto_id = ' ||
                                                  p_motorgyarto_id ||
                                                  chr(10) ||
                                                  'p_csatlakozas_ev = ' ||
                                                  p_csatlakozas_ev ||
                                                  chr(10) ||
                                                  'p_kozpont_hely = ' ||
                                                  p_kozpont_hely || chr(10) ||
                                                  'p_kozpont_orszag = ' ||
                                                  p_kozpont_orszag,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END csapat_modositas;
  
  -- csapat torles a csapat tablabol
  PROCEDURE torles_csapat(p_csapat_id IN NUMBER) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'torles_csapat';
  
  BEGIN
    DELETE FROM csapat cs WHERE cs.csapat_id LIKE p_csapat_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_csapat_id = ' ||
                                                  p_csapat_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_csapat_id = ' ||
                                                  p_csapat_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END torles_csapat;
  
  -- csapat tabla kiiratasa vagy egy csapat kiiratasa
  FUNCTION csapat_adatok(p_csapat_id IN NUMBER DEFAULT NULL) RETURN ty_csapat_l IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'csapat_adatok';
    c_list ty_csapat_l;
    
  BEGIN
    CASE
      WHEN p_csapat_id IS NULL THEN
        SELECT ty_csapat(cs.csapat_id,
                         cs.csapat_nev,
                         cs.motorgyarto_id,
                         cs.csatlakozas_ev,
                         cs.kozpont_hely,
                         cs.kozpont_orszag)
        BULK COLLECT
        INTO c_list
        FROM csapat cs;
      ELSE
        SELECT ty_csapat(cs.csapat_id,
                         cs.csapat_nev,
                         cs.motorgyarto_id,
                         cs.csatlakozas_ev,
                         cs.kozpont_hely,
                         cs.kozpont_orszag)
        BULK COLLECT
        INTO c_list
        FROM csapat cs
        WHERE cs.csapat_id = p_csapat_id;
    END CASE;

    /*FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Csapat ID: ' || c_list(i).csapat_id || chr(10) ||
                           'Csapat nev: ' || c_list(i).csapat_nev || chr(10) ||
                           'Motorgyarto ID: ' || c_list(i).motorgyarto_id || chr(10) ||
                           'Csatlakozasi ev: ' || c_list(i).csatlakozas_ev || chr(10) ||
                           'Kozpont hely: ' || c_list(i).kozpont_hely || chr(10) ||
                           'Kozpont orszag: ' || c_list(i).kozpont_orszag || chr(10));
    END LOOP;*/
    
    RETURN c_list;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_csapat_id = ' || p_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_csapat_id = ' || p_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END csapat_adatok;

END pkg_csapat;
/

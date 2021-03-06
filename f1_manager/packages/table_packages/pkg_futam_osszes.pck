CREATE OR REPLACE PACKAGE pkg_futam_osszes IS

  PROCEDURE uj_futam_osszes(p_futam_nev    IN VARCHAR2
                           ,p_futam_orszag IN VARCHAR2
                           ,p_futam_hely   IN VARCHAR2
                           ,p_palya_nev    IN VARCHAR2);

  PROCEDURE futam_osszes_modositas(p_futam_id     IN NUMBER
                                  ,p_futam_nev    IN VARCHAR2 DEFAULT NULL
                                  ,p_futam_orszag IN VARCHAR2 DEFAULT NULL
                                  ,p_futam_hely   IN VARCHAR2 DEFAULT NULL
                                  ,p_palya_nev    IN VARCHAR2 DEFAULT NULL);
                                  
  PROCEDURE torles_futam_osszes(p_futam_id IN NUMBER);
  
  FUNCTION futam_osszes_adatok(p_futam_id IN NUMBER DEFAULT NULL) RETURN ty_futam_osszes_l;

END pkg_futam_osszes;
/
CREATE OR REPLACE PACKAGE BODY pkg_futam_osszes IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_futam_osszes';

  -- uj futam a futam_osszes tablaba
  PROCEDURE uj_futam_osszes(p_futam_nev    IN VARCHAR2
                           ,p_futam_orszag IN VARCHAR2 
                           ,p_futam_hely   IN VARCHAR2
                           ,p_palya_nev    IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'uj_futam_osszes';
  BEGIN
    INSERT INTO futam_osszes
      (futam_nev
      ,futam_orszag
      ,futam_hely
      ,palya_nev)
    VALUES
      (p_futam_nev
      ,p_futam_orszag
      ,p_futam_hely
      ,p_palya_nev);
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_nev = ' ||
                                                  p_futam_nev || chr(10) ||
                                                  'p_futam_orszag = ' ||
                                                  p_futam_orszag || chr(10) ||
                                                  'p_futam_hely = ' ||
                                                  p_futam_hely || chr(10) ||
                                                  'p_palya_nev = ' ||
                                                  p_palya_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_nev = ' ||
                                                  p_futam_nev || chr(10) ||
                                                  'p_futam_orszag = ' ||
                                                  p_futam_orszag || chr(10) ||
                                                  'p_futam_hely = ' ||
                                                  p_futam_hely || chr(10) ||
                                                  'p_palya_nev = ' ||
                                                  p_palya_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_futam_osszes;

  -- futam modositas a futam_osszes tablaban
  PROCEDURE futam_osszes_modositas(p_futam_id     IN NUMBER
                                  ,p_futam_nev    IN VARCHAR2 DEFAULT NULL
                                  ,p_futam_orszag IN VARCHAR2 DEFAULT NULL
                                  ,p_futam_hely   IN VARCHAR2 DEFAULT NULL
                                  ,p_palya_nev    IN VARCHAR2 DEFAULT NULL) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'futam_osszes_modositas';
    v_futam_nev VARCHAR2(40);
    v_futam_orszag VARCHAR2(40);
    v_futam_hely VARCHAR2(40);
    v_palya_nev VARCHAR2(40);
    
  BEGIN
    SELECT nvl(p_futam_nev, fo.futam_nev), nvl(p_futam_orszag, fo.futam_orszag),
           nvl(p_futam_hely, fo.futam_hely), nvl(p_palya_nev, fo.palya_nev)
    INTO v_futam_nev, v_futam_orszag, v_futam_hely, v_palya_nev
    FROM futam_osszes fo WHERE fo.futam_id = p_futam_id;   
    
    UPDATE futam_osszes fo
       SET fo.futam_nev    = v_futam_nev
          ,fo.futam_orszag = v_futam_orszag
          ,fo.futam_hely   = v_futam_hely
          ,fo.palya_nev    = v_palya_nev
     WHERE fo.futam_id = p_futam_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_id = ' ||
                                                  p_futam_id || chr(10) ||
                                                  'p_futam_nev = ' ||
                                                  p_futam_nev || chr(10) ||
                                                  'p_futam_orszag = ' ||
                                                  p_futam_orszag || chr(10) ||
                                                  'p_futam_hely = ' ||
                                                  p_futam_hely || chr(10) ||
                                                  'p_palya_nev = ' ||
                                                  p_palya_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_id = ' ||
                                                  p_futam_id || chr(10) ||
                                                  'p_futam_nev = ' ||
                                                  p_futam_nev || chr(10) ||
                                                  'p_futam_orszag = ' ||
                                                  p_futam_orszag || chr(10) ||
                                                  'p_futam_hely = ' ||
                                                  p_futam_hely || chr(10) ||
                                                  'p_palya_nev = ' ||
                                                  p_palya_nev,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END futam_osszes_modositas;
  
  -- futam torles a futam_osszes tablabol
  PROCEDURE torles_futam_osszes(p_futam_id IN NUMBER) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'torles_futam_osszes';
  
  BEGIN
    DELETE FROM futam_osszes fo WHERE fo.futam_id LIKE p_futam_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_id = ' ||
                                                  p_futam_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_id = ' ||
                                                  p_futam_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END torles_futam_osszes;
  
  -- futam_osszes tabla kiiratasa vagy egy futam_osszes kiiratasa
  FUNCTION futam_osszes_adatok(p_futam_id IN NUMBER DEFAULT NULL) RETURN ty_futam_osszes_l IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'futam_osszes_adatok';
    c_list ty_futam_osszes_l;
    
  BEGIN
    CASE
      WHEN p_futam_id IS NULL THEN
        SELECT ty_futam_osszes(fo.futam_id,
                               fo.futam_nev,
                               fo.futam_orszag,
                               fo.futam_hely,
                               fo.palya_nev)
        BULK COLLECT
        INTO c_list
        FROM futam_osszes fo;
      ELSE
        SELECT ty_futam_osszes(fo.futam_id,
                               fo.futam_nev,
                               fo.futam_orszag,
                               fo.futam_hely,
                               fo.palya_nev)
        BULK COLLECT
        INTO c_list
        FROM futam_osszes fo
        WHERE fo.futam_id = p_futam_id;
    END CASE;

    /*FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Futam ID: ' || c_list(i).futam_id || chr(10) ||
                           'Futam nev: ' || c_list(i).futam_nev || chr(10) ||
                           'Futam orszag: ' || c_list(i).futam_orszag || chr(10) ||
                           'Futam hely: ' || c_list(i).futam_hely || chr(10) ||
                           'Palya nev: ' || c_list(i).palya_nev || chr(10));
    END LOOP;*/
    
    RETURN c_list;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_futam_id = ' || p_futam_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_futam_id = ' || p_futam_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END futam_osszes_adatok;

END pkg_futam_osszes;
/

CREATE OR REPLACE PACKAGE pkg_pilota_osszes IS

  PROCEDURE uj_pilota_osszes(p_szemely_nev IN VARCHAR2
                            ,p_szul_datum  IN DATE
                            ,p_szul_orszag IN VARCHAR2
                            ,p_szul_hely   IN VARCHAR2
                            ,p_nemzetiseg  IN VARCHAR2);

  PROCEDURE pilota_osszes_modositas(p_szemely_id  IN NUMBER
                                   ,p_szemely_nev IN VARCHAR2 DEFAULT NULL
                                   ,p_szul_datum  IN DATE DEFAULT NULL
                                   ,p_szul_orszag IN VARCHAR2 DEFAULT NULL
                                   ,p_szul_hely   IN VARCHAR2 DEFAULT NULL
                                   ,p_nemzetiseg  IN VARCHAR2 DEFAULT NULL);
                                   
  PROCEDURE pilota_osszes_adatok(p_szemely_id IN NUMBER);

END pkg_pilota_osszes;
/
CREATE OR REPLACE PACKAGE BODY pkg_pilota_osszes IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_pilota_osszes';

  -- uj pilota a pilota_osszes tablaba
  PROCEDURE uj_pilota_osszes(p_szemely_nev IN VARCHAR2
                            ,p_szul_datum  IN DATE
                            ,p_szul_orszag IN VARCHAR2
                            ,p_szul_hely   IN VARCHAR2
                            ,p_nemzetiseg  IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'uj_pilota_osszes';
  BEGIN
    INSERT INTO pilota_osszes
      (szemely_nev
      ,szul_datum
      ,szul_orszag
      ,szul_hely
      ,nemzetiseg)
    VALUES
      (p_szemely_nev
      ,p_szul_datum
      ,p_szul_orszag
      ,p_szul_hely
      ,p_nemzetiseg);
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szemely_nev = ' ||
                                                  p_szemely_nev || chr(10) ||
                                                  'p_szul_datum = ' ||
                                                  p_szul_datum || chr(10) ||
                                                  'p_szul_orszag = ' ||
                                                  p_szul_orszag || chr(10) ||
                                                  'p_szul_hely = ' ||
                                                  p_szul_hely || chr(10) ||
                                                  'p_nemzetiseg = ' ||
                                                  p_nemzetiseg,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szemely_nev = ' ||
                                                  p_szemely_nev || chr(10) ||
                                                  'p_szul_datum = ' ||
                                                  p_szul_datum || chr(10) ||
                                                  'p_szul_orszag = ' ||
                                                  p_szul_orszag || chr(10) ||
                                                  'p_szul_hely = ' ||
                                                  p_szul_hely || chr(10) ||
                                                  'p_nemzetiseg = ' ||
                                                  p_nemzetiseg,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_pilota_osszes;

  -- pilota modositas a pilota_osszes tablaban
  PROCEDURE pilota_osszes_modositas(p_szemely_id  IN NUMBER
                                   ,p_szemely_nev IN VARCHAR2 DEFAULT NULL
                                   ,p_szul_datum  IN DATE DEFAULT NULL
                                   ,p_szul_orszag IN VARCHAR2 DEFAULT NULL
                                   ,p_szul_hely   IN VARCHAR2 DEFAULT NULL
                                   ,p_nemzetiseg  IN VARCHAR2 DEFAULT NULL) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'pilota_osszes_modositas';
    uj_szemely_nev VARCHAR2(40);
    uj_szul_datum DATE;
    uj_szul_orszag VARCHAR2(40);
    uj_szul_hely VARCHAR2(40);
    uj_nemzetiseg VARCHAR2(40);
  
  BEGIN
    uj_szemely_nev := p_szemely_nev;
    uj_szul_datum := p_szul_datum;
    uj_szul_orszag := p_szul_orszag;
    uj_szul_hely := p_szul_hely;
    uj_nemzetiseg := p_nemzetiseg; 
  
    IF p_szemely_nev IS NULL THEN
      SELECT po.szemely_nev INTO uj_szemely_nev FROM pilota_osszes po WHERE po.szemely_id = p_szemely_id;
    END IF;
    IF p_szul_datum IS NULL THEN
      SELECT po.szul_datum INTO uj_szul_datum FROM pilota_osszes po WHERE po.szemely_id = p_szemely_id;
    END IF;
    IF p_szul_orszag IS NULL THEN
      SELECT po.szul_orszag INTO uj_szul_orszag FROM pilota_osszes po WHERE po.szemely_id = p_szemely_id;
    END IF;
    IF p_szul_hely IS NULL THEN
      SELECT po.szul_hely INTO uj_szul_hely FROM pilota_osszes po WHERE po.szemely_id = p_szemely_id;
    END IF;
    IF p_nemzetiseg IS NULL THEN
      SELECT po.nemzetiseg INTO uj_nemzetiseg FROM pilota_osszes po WHERE po.szemely_id = p_szemely_id;
    END IF;
  
    UPDATE pilota_osszes po
       SET po.szemely_nev = uj_szemely_nev
          ,po.szul_datum  = uj_szul_datum
          ,po.szul_orszag = uj_szul_orszag
          ,po.szul_hely   = uj_szul_hely
          ,po.nemzetiseg  = uj_nemzetiseg
     WHERE po.szemely_id = p_szemely_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szemely_id = ' ||
                                                  p_szemely_id || chr(10) ||
                                                  'p_szemely_nev = ' ||
                                                  p_szemely_nev || chr(10) ||
                                                  'p_szul_datum = ' ||
                                                  p_szul_datum || chr(10) ||
                                                  'p_szul_orszag = ' ||
                                                  p_szul_orszag || chr(10) ||
                                                  'p_szul_hely = ' ||
                                                  p_szul_hely || chr(10) ||
                                                  'p_nemzetiseg = ' ||
                                                  p_nemzetiseg,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szemely_id = ' ||
                                                  p_szemely_id || chr(10) ||
                                                  'p_szemely_nev = ' ||
                                                  p_szemely_nev || chr(10) ||
                                                  'p_szul_datum = ' ||
                                                  p_szul_datum || chr(10) ||
                                                  'p_szul_orszag = ' ||
                                                  p_szul_orszag || chr(10) ||
                                                  'p_szul_hely = ' ||
                                                  p_szul_hely || chr(10) ||
                                                  'p_nemzetiseg = ' ||
                                                  p_nemzetiseg,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END pilota_osszes_modositas;
  
   -- pilota_osszes tabla kiiratasa vagy egy pilota_osszes kiiratasa
  PROCEDURE pilota_osszes_adatok(p_szemely_id IN NUMBER) IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'pilota_osszes_adatok';
    c_list ty_pilota_osszes_l;
    
  BEGIN
    CASE
      WHEN p_szemely_id IS NULL THEN
        SELECT ty_pilota_osszes(po.szemely_id,
                                po.szemely_nev,
                                po.szul_datum,
                                po.szul_orszag,
                                po.szul_hely,
                                po.nemzetiseg)
        BULK COLLECT
        INTO c_list
        FROM pilota_osszes po;
      ELSE
        SELECT ty_pilota_osszes(po.szemely_id,
                                po.szemely_nev,
                                po.szul_datum,
                                po.szul_orszag,
                                po.szul_hely,
                                po.nemzetiseg)
        BULK COLLECT
        INTO c_list
        FROM pilota_osszes po
        WHERE po.szemely_id = p_szemely_id;
    END CASE;

    FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Szemely ID: ' || c_list(i).szemely_id || chr(10) ||
                           'Szemely nev: ' || c_list(i).szemely_nev || chr(10) ||
                           'Szuletesi datum: ' || c_list(i).szul_datum || chr(10) ||
                           'Szuletesi orsag: ' || c_list(i).szul_orszag || chr(10) ||
                           'Szuletesi hely: ' || c_list(i).szul_hely || chr(10) ||
                           'Nemzetiseg: ' || c_list(i).nemzetiseg || chr(10));
    END LOOP;
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_szemely_id = ' || p_szemely_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_szemely_id = ' || p_szemely_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END pilota_osszes_adatok;

END pkg_pilota_osszes;
/

CREATE OR REPLACE PACKAGE pkg_pilota_osszes IS

  PROCEDURE uj_pilota_osszes(p_szemely_nev IN VARCHAR2
                            ,p_szul_datum  IN DATE
                            ,p_szul_orszag IN VARCHAR2
                            ,p_szul_hely   IN VARCHAR2
                            ,p_nemzetiseg  IN VARCHAR2);

  PROCEDURE pilota_osszes_modositas(p_szemely_id  IN NUMBER
                                   ,p_szemely_nev IN VARCHAR2
                                   ,p_szul_datum  IN DATE
                                   ,p_szul_orszag IN VARCHAR2
                                   ,p_szul_hely   IN VARCHAR2
                                   ,p_nemzetiseg  IN VARCHAR2);

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
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_pilota_osszes';
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
                                   ,p_szemely_nev IN VARCHAR2
                                   ,p_szul_datum  IN DATE
                                   ,p_szul_orszag IN VARCHAR2
                                   ,p_szul_hely   IN VARCHAR2
                                   ,p_nemzetiseg  IN VARCHAR2) IS
  
    c_proc_nev CONSTANT VARCHAR(30) := 'pilota_osszes_modositas';
  
  BEGIN
    UPDATE pilota_osszes po
       SET po.szemely_nev = p_szemely_nev
          ,po.szul_datum  = p_szul_datum
          ,po.szul_orszag = p_szul_orszag
          ,po.szul_hely   = p_szul_hely
          ,po.nemzetiseg  = p_szul_hely
     WHERE po.szemely_id = p_szemely_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
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

END pkg_pilota_osszes;
/

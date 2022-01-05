CREATE OR REPLACE PACKAGE pkg_csapat IS

  PROCEDURE uj_csapat(p_csapat_nev     IN VARCHAR2
                     ,p_motorgyarto_id IN NUMBER
                     ,p_csatlakozas_ev IN NUMBER
                     ,p_kozpont_hely   IN VARCHAR2
                     ,p_kozpont_orszag IN VARCHAR2);

  PROCEDURE csapat_modositas(p_csapat_id      IN NUMBER
                            ,p_csapat_nev     IN VARCHAR2
                            ,p_motorgyarto_id IN NUMBER
                            ,p_csatlakozas_ev IN NUMBER
                            ,p_kozpont_hely   IN VARCHAR2
                            ,p_kozpont_orszag IN VARCHAR2);

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
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_csapat';
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
                            ,p_csapat_nev     IN VARCHAR2
                            ,p_motorgyarto_id IN NUMBER
                            ,p_csatlakozas_ev IN NUMBER
                            ,p_kozpont_hely   IN VARCHAR2
                            ,p_kozpont_orszag IN VARCHAR2) IS
  
    c_proc_nev CONSTANT VARCHAR(30) := 'csapat_modositas';
  
  BEGIN
    UPDATE csapat cs
       SET cs.csapat_nev     = p_csapat_nev
          ,cs.motorgyarto_id = p_motorgyarto_id
          ,cs.csatlakozas_ev = p_csatlakozas_ev
          ,cs.kozpont_hely   = p_kozpont_hely
          ,cs.kozpont_orszag = p_kozpont_orszag
     WHERE cs.csapat_id = p_csapat_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
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

END pkg_csapat;
/

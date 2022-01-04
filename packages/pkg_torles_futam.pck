CREATE OR REPLACE PACKAGE pkg_torles_futam IS

  PROCEDURE torles_futam2021(p_verseny_id IN NUMBER);
  
  PROCEDURE torles_futam2022(p_verseny_id IN NUMBER);

END pkg_torles_futam;
/
CREATE OR REPLACE PACKAGE BODY pkg_torles_futam IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_torles_futam';

  -- torles a futamok2021 tablabol
  PROCEDURE torles_futam2021(p_verseny_id IN NUMBER) IS
    
    c_proc_nev CONSTANT VARCHAR(30) := 'torles_futam2021';
    
  BEGIN
    DELETE FROM futamok2021 f21 WHERE f21.verseny_id LIKE p_verseny_id;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_verseny_id = ' || p_verseny_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
  END torles_futam2021;
  
  -- torles a futamok2022 tablabol
  PROCEDURE torles_futam2022(p_verseny_id IN NUMBER) IS
    
    c_proc_nev CONSTANT VARCHAR(30) := 'torles_futam2022';
    
  BEGIN
    DELETE FROM futamok2022 f22 WHERE f22.verseny_id LIKE p_verseny_id;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_verseny_id = ' || p_verseny_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
  END torles_futam2022;


END pkg_torles_futam;
/

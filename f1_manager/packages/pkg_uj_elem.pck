CREATE OR REPLACE PACKAGE pkg_uj_elem IS

  PROCEDURE uj_motorgyarto(p_motorgyarto_nev IN VARCHAR2);

  PROCEDURE uj_csapat(p_csapat_nev IN VARCHAR2,
                      p_motorgyarto_id IN NUMBER,
                      p_csatlakozas_ev IN NUMBER,
                      p_kozpont_hely IN VARCHAR2,
                      p_kozpont_orszag IN VARCHAR2);
                      
  PROCEDURE uj_pilota(p_szemely_nev IN VARCHAR2,
                      p_szul_datum IN DATE,
                      p_szul_orszag IN VARCHAR2,
                      p_szul_hely IN VARCHAR2,
                      p_nemzetiseg IN VARCHAR2);
                      
  PROCEDURE uj_pilota2021(p_pilota_id IN NUMBER,
                          p_szemely_id IN NUMBER,
                          p_csapat_id IN NUMBER);
                          
  PROCEDURE uj_pilota2022(p_pilota_id IN NUMBER,
                          p_szemely_id IN NUMBER,
                          p_csapat_id IN NUMBER);
                          
  PROCEDURE uj_futam(p_futam_nev IN VARCHAR2,
                     p_futam_orszag IN VARCHAR2,
                     p_futam_hely IN VARCHAR2,
                     p_palya_nev IN VARCHAR2);
                     
  PROCEDURE uj_futam2021(p_futam_id IN NUMBER,
                         p_palyahossz IN NUMBER,
                         p_kor_szam IN NUMBER,
                         p_nyertes_pilota_id IN NUMBER,
                         p_leggyorsabb_pilota_id IN NUMBER,
                         p_leggyorsabb_ido IN VARCHAR2,
                         p_idopont IN DATE);
                         
  PROCEDURE uj_futam2022(p_futam_id IN NUMBER,
                         p_palyahossz IN NUMBER,
                         p_kor_szam IN NUMBER,
                         p_nyertes_pilota_id IN NUMBER,
                         p_leggyorsabb_pilota_id IN NUMBER,
                         p_leggyorsabb_ido IN VARCHAR2,
                         p_idopont IN DATE);
  
END pkg_uj_elem;
/
CREATE OR REPLACE PACKAGE BODY pkg_uj_elem IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_uj_elem';

  -- uj motorgyarto a motorgyartok tablaba
  PROCEDURE uj_motorgyarto(p_motorgyarto_nev IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_motorgyarto';
  BEGIN
    INSERT INTO motorgyartok(motorgyarto_nev)
    VALUES(p_motorgyarto_nev);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_motorgyarto_nev = ' || p_motorgyarto_nev,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_motorgyarto_nev = ' || p_motorgyarto_nev,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_motorgyarto;
  
  -- uj csapat a csapatok tablaba
  PROCEDURE uj_csapat(p_csapat_nev IN VARCHAR2,
                      p_motorgyarto_id IN NUMBER,
                      p_csatlakozas_ev IN NUMBER,
                      p_kozpont_hely IN VARCHAR2,
                      p_kozpont_orszag IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_csapat';
  BEGIN
    INSERT INTO csapatok(csapat_nev,motorgyarto_id,csatlakozas_ev,kozpont_hely,kozpont_orszag)
    VALUES(p_csapat_nev,p_motorgyarto_id,p_csatlakozas_ev,p_kozpont_hely,p_kozpont_orszag);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_csapat_nev = ' || p_csapat_nev ||
                                                    chr(10) || 'p_motorgyarto_id = ' ||
                                                    p_motorgyarto_id ||
                                                    chr(10) || 'p_csatlakozas_ev = ' ||
                                                    p_csatlakozas_ev ||
                                                    chr(10) || 'p_kozpont_hely = ' ||
                                                    p_kozpont_hely ||
                                                    chr(10) || 'p_kozpont_orszag = ' ||
                                                    p_kozpont_orszag,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_csapat_nev = ' || p_csapat_nev ||
                                                    chr(10) || 'p_motorgyarto_id = ' ||
                                                    p_motorgyarto_id ||
                                                    chr(10) || 'p_csatlakozas_ev = ' ||
                                                    p_csatlakozas_ev ||
                                                    chr(10) || 'p_kozpont_hely = ' ||
                                                    p_kozpont_hely ||
                                                    chr(10) || 'p_kozpont_orszag = ' ||
                                                    p_kozpont_orszag,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_csapat;
  
  -- uj pilota a pilotak_osszes tablaba
  PROCEDURE uj_pilota(p_szemely_nev IN VARCHAR2,
                      p_szul_datum IN DATE,
                      p_szul_orszag IN VARCHAR2,
                      p_szul_hely IN VARCHAR2,
                      p_nemzetiseg IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_pilota';
  BEGIN
    INSERT INTO pilotak_osszes(szemely_nev,szul_datum,szul_orszag,szul_hely,nemzetiseg)
    VALUES(p_szemely_nev,p_szul_datum,p_szul_orszag,p_szul_hely,p_nemzetiseg);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_szemely_nev = ' || p_szemely_nev ||
                                                    chr(10) || 'p_szul_datum = ' ||
                                                    p_szul_datum ||
                                                    chr(10) || 'p_szul_orszag = ' ||
                                                    p_szul_orszag ||
                                                    chr(10) || 'p_szul_hely = ' ||
                                                    p_szul_hely ||
                                                    chr(10) || 'p_nemzetiseg = ' ||
                                                    p_nemzetiseg,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_szemely_nev = ' || p_szemely_nev ||
                                                    chr(10) || 'p_szul_datum = ' ||
                                                    p_szul_datum ||
                                                    chr(10) || 'p_szul_orszag = ' ||
                                                    p_szul_orszag ||
                                                    chr(10) || 'p_szul_hely = ' ||
                                                    p_szul_hely ||
                                                    chr(10) || 'p_nemzetiseg = ' ||
                                                    p_nemzetiseg,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_pilota;
  
  -- uj pilota2021 a pilotak2021 tablaba
  PROCEDURE uj_pilota2021(p_pilota_id IN NUMBER,
                          p_szemely_id IN NUMBER,
                          p_csapat_id IN NUMBER) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_pilota2021';
  BEGIN
    INSERT INTO pilotak2021(pilota_id,szemely_id,csapat_id)
    VALUES(p_pilota_id,p_szemely_id,p_csapat_id);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_pilota_id = ' || p_pilota_id ||
                                                    chr(10) || 'p_szemely_id = ' ||
                                                    p_szemely_id ||
                                                    chr(10) || 'p_csapat_id = ' ||
                                                    p_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;   
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_pilota_id = ' || p_pilota_id ||
                                                    chr(10) || 'p_szemely_id = ' ||
                                                    p_szemely_id ||
                                                    chr(10) || 'p_csapat_id = ' ||
                                                    p_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_pilota2021;
  
  -- uj pilota2022 a pilotak2022 tablaba
  PROCEDURE uj_pilota2022(p_pilota_id IN NUMBER,
                          p_szemely_id IN NUMBER,
                          p_csapat_id IN NUMBER) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_pilota2022';
  BEGIN
    INSERT INTO pilotak2022(pilota_id,szemely_id,csapat_id)
    VALUES(p_pilota_id,p_szemely_id,p_csapat_id);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_pilota_id = ' || p_pilota_id ||
                                                    chr(10) || 'p_szemely_id = ' ||
                                                    p_szemely_id ||
                                                    chr(10) || 'p_csapat_id = ' ||
                                                    p_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_pilota_id = ' || p_pilota_id ||
                                                    chr(10) || 'p_szemely_id = ' ||
                                                    p_szemely_id ||
                                                    chr(10) || 'p_csapat_id = ' ||
                                                    p_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_pilota2022;
  
  -- uj futam a futamok_osszes tablaba
  PROCEDURE uj_futam(p_futam_nev IN VARCHAR2,
                     p_futam_orszag IN VARCHAR2,
                     p_futam_hely IN VARCHAR2,
                     p_palya_nev IN VARCHAR2) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_futam';
  BEGIN
    INSERT INTO futamok_osszes(futam_nev,futam_orszag,futam_hely,palya_nev)
    VALUES(p_futam_nev,p_futam_orszag,p_futam_hely,p_palya_nev);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_futam_nev = ' || p_futam_nev ||
                                                    chr(10) || 'p_futam_orszag = ' ||
                                                    p_futam_orszag ||
                                                    chr(10) || 'p_futam_hely = ' ||
                                                    p_futam_hely ||
                                                    chr(10) || 'p_palya_nev = ' ||
                                                    p_palya_nev,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_futam_nev = ' || p_futam_nev ||
                                                    chr(10) || 'p_futam_orszag = ' ||
                                                    p_futam_orszag ||
                                                    chr(10) || 'p_futam_hely = ' ||
                                                    p_futam_hely ||
                                                    chr(10) || 'p_palya_nev = ' ||
                                                    p_palya_nev,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_futam;
  
  -- uj futam2021 a futamok2021 tablaba
  PROCEDURE uj_futam2021(p_futam_id IN NUMBER,
                         p_palyahossz IN NUMBER,
                         p_kor_szam IN NUMBER,
                         p_nyertes_pilota_id IN NUMBER,
                         p_leggyorsabb_pilota_id IN NUMBER,
                         p_leggyorsabb_ido IN VARCHAR2,
                         p_idopont IN DATE) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_futam2021';
  BEGIN
    INSERT INTO futamok2021(futam_id,palyahossz,kor_szam,nyertes_pilota_id,leggyorsabb_pilota_id,leggyorsabb_ido,idopont)
    VALUES(p_futam_id,p_palyahossz,p_kor_szam,p_nyertes_pilota_id,p_leggyorsabb_pilota_id,p_leggyorsabb_ido,p_idopont);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_futam_id = ' || p_futam_id ||
                                                    chr(10) || 'p_palyahossz = ' ||
                                                    p_palyahossz ||
                                                    chr(10) || 'p_kor_szam = ' ||
                                                    p_kor_szam ||
                                                    chr(10) || 'p_nyertes_pilota_id = ' ||
                                                    p_nyertes_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_pilota_id = ' ||
                                                    p_leggyorsabb_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_ido = ' ||
                                                    p_leggyorsabb_ido ||
                                                    chr(10) || 'p_idopont = ' ||
                                                    p_idopont,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_futam_id = ' || p_futam_id ||
                                                    chr(10) || 'p_palyahossz = ' ||
                                                    p_palyahossz ||
                                                    chr(10) || 'p_kor_szam = ' ||
                                                    p_kor_szam ||
                                                    chr(10) || 'p_nyertes_pilota_id = ' ||
                                                    p_nyertes_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_pilota_id = ' ||
                                                    p_leggyorsabb_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_ido = ' ||
                                                    p_leggyorsabb_ido ||
                                                    chr(10) || 'p_idopont = ' ||
                                                    p_idopont,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_futam2021;
  
  -- uj futam2022 a futamok2022 tablaba
  PROCEDURE uj_futam2022(p_futam_id IN NUMBER,
                         p_palyahossz IN NUMBER,
                         p_kor_szam IN NUMBER,
                         p_nyertes_pilota_id IN NUMBER,
                         p_leggyorsabb_pilota_id IN NUMBER,
                         p_leggyorsabb_ido IN VARCHAR2,
                         p_idopont IN DATE) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_futam2022';
  BEGIN
    INSERT INTO futamok2022(futam_id,palyahossz,kor_szam,nyertes_pilota_id,leggyorsabb_pilota_id,leggyorsabb_ido,idopont)
    VALUES(p_futam_id,p_palyahossz,p_kor_szam,p_nyertes_pilota_id,p_leggyorsabb_pilota_id,p_leggyorsabb_ido,p_idopont);
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_futam_id = ' || p_futam_id ||
                                                    chr(10) || 'p_palyahossz = ' ||
                                                    p_palyahossz ||
                                                    chr(10) || 'p_kor_szam = ' ||
                                                    p_kor_szam ||
                                                    chr(10) || 'p_nyertes_pilota_id = ' ||
                                                    p_nyertes_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_pilota_id = ' ||
                                                    p_leggyorsabb_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_ido = ' ||
                                                    p_leggyorsabb_ido ||
                                                    chr(10) || 'p_idopont = ' ||
                                                    p_idopont,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs valamilyen adat.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_futam_id = ' || p_futam_id ||
                                                    chr(10) || 'p_palyahossz = ' ||
                                                    p_palyahossz ||
                                                    chr(10) || 'p_kor_szam = ' ||
                                                    p_kor_szam ||
                                                    chr(10) || 'p_nyertes_pilota_id = ' ||
                                                    p_nyertes_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_pilota_id = ' ||
                                                    p_leggyorsabb_pilota_id ||
                                                    chr(10) || 'p_leggyorsabb_ido = ' ||
                                                    p_leggyorsabb_ido ||
                                                    chr(10) || 'p_idopont = ' ||
                                                    p_idopont,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Általános hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_futam2022;
  
  

END pkg_uj_elem;
/

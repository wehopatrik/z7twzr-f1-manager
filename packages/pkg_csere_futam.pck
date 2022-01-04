CREATE OR REPLACE PACKAGE pkg_csere_futam IS

  PROCEDURE futam_csere2021(p_verseny_id IN NUMBER,
                            p_futam_id IN NUMBER,
                            p_palyahossz IN NUMBER,
                            p_kor_szam IN NUMBER,
                            p_nyertes_pilota_id IN NUMBER,
                            p_leggyorsabb_pilota_id IN NUMBER,
                            p_leggyorsabb_ido IN VARCHAR2,
                            p_idopont IN DATE);
                            
  PROCEDURE futam_csere2022(p_verseny_id IN NUMBER,
                            p_futam_id IN NUMBER,
                            p_palyahossz IN NUMBER,
                            p_kor_szam IN NUMBER,
                            p_nyertes_pilota_id IN NUMBER,
                            p_leggyorsabb_pilota_id IN NUMBER,
                            p_leggyorsabb_ido IN VARCHAR2,
                            p_idopont IN DATE);

END pkg_csere_futam;
/
CREATE OR REPLACE PACKAGE BODY pkg_csere_futam IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_csere_futam';

  -- csere a futamok2021 tablaban
  PROCEDURE futam_csere2021(p_verseny_id IN NUMBER,
                            p_futam_id IN NUMBER,
                            p_palyahossz IN NUMBER,
                            p_kor_szam IN NUMBER,
                            p_nyertes_pilota_id IN NUMBER,
                            p_leggyorsabb_pilota_id IN NUMBER,
                            p_leggyorsabb_ido IN VARCHAR2,
                            p_idopont IN DATE) IS
                            
    c_proc_nev CONSTANT VARCHAR(30) := 'futam_csere2021';
    
  BEGIN
    UPDATE futamok2021 f21
       SET f21.futam_id = p_futam_id,
           f21.palyahossz = p_palyahossz,
           f21.kor_szam = p_kor_szam,
           f21.nyertes_pilota_id = p_nyertes_pilota_id,
           f21.leggyorsabb_pilota_id = p_leggyorsabb_pilota_id,
           f21.leggyorsabb_ido = p_leggyorsabb_ido,
           f21.idopont = p_idopont
     WHERE f21.verseny_id = p_verseny_id;
     
     EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_verseny_id = ' || p_verseny_id ||
                                                    chr(10) || 'p_futam_id = ' || p_futam_id ||
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
  END futam_csere2021;
  
  -- csere a futamok2022 tablaban
  PROCEDURE futam_csere2022(p_verseny_id IN NUMBER,
                            p_futam_id IN NUMBER,
                            p_palyahossz IN NUMBER,
                            p_kor_szam IN NUMBER,
                            p_nyertes_pilota_id IN NUMBER,
                            p_leggyorsabb_pilota_id IN NUMBER,
                            p_leggyorsabb_ido IN VARCHAR2,
                            p_idopont IN DATE) IS
                            
    c_proc_nev CONSTANT VARCHAR(30) := 'futam_csere2022';
                            
  BEGIN
    UPDATE futamok2022 f22
       SET f22.futam_id = p_futam_id,
           f22.palyahossz = p_palyahossz,
           f22.kor_szam = p_kor_szam,
           f22.nyertes_pilota_id = p_nyertes_pilota_id,
           f22.leggyorsabb_pilota_id = p_leggyorsabb_pilota_id,
           f22.leggyorsabb_ido = p_leggyorsabb_ido,
           f22.idopont = p_idopont
     WHERE f22.verseny_id = p_verseny_id;
     
     EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_ertek  => 'p_verseny_id = ' || p_verseny_id ||
                                                    chr(10) || 'p_futam_id = ' || p_futam_id ||
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
  END futam_csere2022;
  
END pkg_csere_futam;
/

CREATE OR REPLACE PACKAGE pkg_futam_ev IS

  PROCEDURE uj_futam_ev(p_futam_id               IN NUMBER
                       ,p_hanyadik_futam         IN NUMBER
                       ,p_palyahossz             IN NUMBER
                       ,p_kor_szam               IN NUMBER
                       ,p_nyertes_szemely_id     IN NUMBER
                       ,p_leggyorsabb_szemely_id IN NUMBER
                       ,p_leggyorsabb_ido        IN VARCHAR2
                       ,p_idopont                DATE);

  PROCEDURE futam_ev_modositas(p_futam_ev_id            IN NUMBER
                              ,p_futam_id               IN NUMBER
                              ,p_hanyadik_futam         IN NUMBER
                              ,p_palyahossz             IN NUMBER
                              ,p_kor_szam               IN NUMBER
                              ,p_nyertes_szemely_id     IN NUMBER
                              ,p_leggyorsabb_szemely_id IN NUMBER
                              ,p_leggyorsabb_ido        IN VARCHAR2
                              ,p_idopont                DATE);

  PROCEDURE torles_futam_ev(p_futam_ev_id IN NUMBER);

END pkg_futam_ev;
/
CREATE OR REPLACE PACKAGE BODY pkg_futam_ev IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_futam_ev';

  -- uj futam_ev a futam_ev tablaba
  PROCEDURE uj_futam_ev(p_futam_id               IN NUMBER
                       ,p_hanyadik_futam         IN NUMBER
                       ,p_palyahossz             IN NUMBER
                       ,p_kor_szam               IN NUMBER
                       ,p_nyertes_szemely_id     IN NUMBER
                       ,p_leggyorsabb_szemely_id IN NUMBER
                       ,p_leggyorsabb_ido        IN VARCHAR2
                       ,p_idopont                DATE) IS
    c_proc_nev CONSTANT VARCHAR(30) := 'uj_futam_ev';
  BEGIN
    INSERT INTO futam_ev
      (futam_id
      ,hanyadik_futam
      ,palyahossz
      ,kor_szam
      ,nyertes_szemely_id
      ,leggyorsabb_szemely_id
      ,leggyorsabb_ido
      ,idopont)
    VALUES
      (p_futam_id
      ,p_hanyadik_futam
      ,p_palyahossz
      ,p_kor_szam
      ,p_nyertes_szemely_id
      ,p_leggyorsabb_szemely_id
      ,p_leggyorsabb_ido
      ,p_idopont);
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_futam_id = ' ||
                                                  p_futam_id || chr(10) ||
                                                  'p_hanyadik_futam = ' ||
                                                  p_hanyadik_futam ||
                                                  chr(10) ||
                                                  'p_palyahossz = ' ||
                                                  p_palyahossz || chr(10) ||
                                                  'p_kor_szam = ' ||
                                                  p_kor_szam || chr(10) ||
                                                  'p_nyertes_szemely_id = ' ||
                                                  p_nyertes_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_szemely_id = ' ||
                                                  p_leggyorsabb_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_ido = ' ||
                                                  p_leggyorsabb_ido ||
                                                  chr(10) || 'p_idopont = ' ||
                                                  p_idopont,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_futam_id = ' ||
                                                  p_futam_id || chr(10) ||
                                                  'p_hanyadik_futam = ' ||
                                                  p_hanyadik_futam ||
                                                  chr(10) ||
                                                  'p_palyahossz = ' ||
                                                  p_palyahossz || chr(10) ||
                                                  'p_kor_szam = ' ||
                                                  p_kor_szam || chr(10) ||
                                                  'p_nyertes_szemely_id = ' ||
                                                  p_nyertes_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_szemely_id = ' ||
                                                  p_leggyorsabb_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_ido = ' ||
                                                  p_leggyorsabb_ido ||
                                                  chr(10) || 'p_idopont = ' ||
                                                  p_idopont,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_futam_ev;

  -- futam_ev modositas a futam_ev tablaban
  PROCEDURE futam_ev_modositas(p_futam_ev_id            IN NUMBER
                              ,p_futam_id               IN NUMBER
                              ,p_hanyadik_futam         IN NUMBER
                              ,p_palyahossz             IN NUMBER
                              ,p_kor_szam               IN NUMBER
                              ,p_nyertes_szemely_id     IN NUMBER
                              ,p_leggyorsabb_szemely_id IN NUMBER
                              ,p_leggyorsabb_ido        IN VARCHAR2
                              ,p_idopont                DATE) IS
  
    c_proc_nev CONSTANT VARCHAR(30) := 'futam_ev_modositas';
  
  BEGIN
    UPDATE futam_ev fe
       SET fe.futam_id               = p_futam_id
          ,fe.hanyadik_futam         = p_hanyadik_futam
          ,fe.palyahossz             = p_palyahossz
          ,fe.kor_szam               = p_kor_szam
          ,fe.nyertes_szemely_id     = p_nyertes_szemely_id
          ,fe.leggyorsabb_szemely_id = p_leggyorsabb_szemely_id
          ,fe.leggyorsabb_ido        = p_leggyorsabb_ido
          ,fe.idopont                = p_idopont
     WHERE fe.futam_ev_id = p_futam_ev_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_futam_ev_id = ' ||
                                                  p_futam_ev_id || chr(10) ||
                                                  'p_futam_id = ' ||
                                                  p_futam_id || chr(10) ||
                                                  'p_hanyadik_futam = ' ||
                                                  p_hanyadik_futam ||
                                                  chr(10) ||
                                                  'p_palyahossz = ' ||
                                                  p_palyahossz || chr(10) ||
                                                  'p_kor_szam = ' ||
                                                  p_kor_szam || chr(10) ||
                                                  'p_nyertes_szemely_id = ' ||
                                                  p_nyertes_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_szemely_id = ' ||
                                                  p_leggyorsabb_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_ido = ' ||
                                                  p_leggyorsabb_ido ||
                                                  chr(10) || 'p_idopont = ' ||
                                                  p_idopont,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_futam_ev_id = ' ||
                                                  p_futam_ev_id || chr(10) ||
                                                  'p_futam_id = ' ||
                                                  p_futam_id || chr(10) ||
                                                  'p_hanyadik_futam = ' ||
                                                  p_hanyadik_futam ||
                                                  chr(10) ||
                                                  'p_palyahossz = ' ||
                                                  p_palyahossz || chr(10) ||
                                                  'p_kor_szam = ' ||
                                                  p_kor_szam || chr(10) ||
                                                  'p_nyertes_szemely_id = ' ||
                                                  p_nyertes_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_szemely_id = ' ||
                                                  p_leggyorsabb_szemely_id ||
                                                  chr(10) ||
                                                  'p_leggyorsabb_ido = ' ||
                                                  p_leggyorsabb_ido ||
                                                  chr(10) || 'p_idopont = ' ||
                                                  p_idopont,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END futam_ev_modositas;

  -- futam_ev torles a futam_ev tablabol
  PROCEDURE torles_futam_ev(p_futam_ev_id IN NUMBER) IS
  
    c_proc_nev CONSTANT VARCHAR(30) := 'torles_futam_ev';
  
  BEGIN
    DELETE FROM futam_ev fe WHERE fe.futam_ev_id LIKE p_futam_ev_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_futam_ev_id = ' ||
                                                  p_futam_ev_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_ertek  => 'p_futam_ev_id = ' ||
                                                  p_futam_ev_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END torles_futam_ev;

END pkg_futam_ev;
/

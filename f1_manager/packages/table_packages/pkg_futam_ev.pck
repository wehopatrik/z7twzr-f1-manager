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
                              ,p_futam_id               IN NUMBER DEFAULT NULL
                              ,p_hanyadik_futam         IN NUMBER DEFAULT NULL
                              ,p_palyahossz             IN NUMBER DEFAULT NULL
                              ,p_kor_szam               IN NUMBER DEFAULT NULL
                              ,p_nyertes_szemely_id     IN NUMBER DEFAULT NULL
                              ,p_leggyorsabb_szemely_id IN NUMBER DEFAULT NULL
                              ,p_leggyorsabb_ido        IN VARCHAR2 DEFAULT NULL
                              ,p_idopont                DATE DEFAULT NULL);

  PROCEDURE torles_futam_ev(p_futam_ev_id IN NUMBER);
  
  FUNCTION futam_ev_adatok(p_futam_ev_id IN NUMBER DEFAULT NULL) RETURN ty_futam_ev_l;

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
    c_proc_nev CONSTANT VARCHAR2(30) := 'uj_futam_ev';
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
                                 p_hiba_okozat => SQLERRM,
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
                                 p_hiba_okozat => SQLERRM,
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
                              ,p_futam_id               IN NUMBER DEFAULT NULL
                              ,p_hanyadik_futam         IN NUMBER DEFAULT NULL
                              ,p_palyahossz             IN NUMBER DEFAULT NULL
                              ,p_kor_szam               IN NUMBER DEFAULT NULL
                              ,p_nyertes_szemely_id     IN NUMBER DEFAULT NULL
                              ,p_leggyorsabb_szemely_id IN NUMBER DEFAULT NULL
                              ,p_leggyorsabb_ido        IN VARCHAR2 DEFAULT NULL
                              ,p_idopont                DATE DEFAULT NULL) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'futam_ev_modositas';
    v_futam_id NUMBER;
    v_hanyadik_futam NUMBER;
    v_palyahossz NUMBER;
    v_kor_szam NUMBER;
    v_nyertes_szemely_id NUMBER;
    v_leggyorsabb_szemely_id NUMBER;
    v_leggyorsabb_ido VARCHAR2(10);
    v_idopont DATE;
  
  BEGIN   
    SELECT nvl(p_futam_id, fe.futam_id), nvl(p_hanyadik_futam, fe.hanyadik_futam),
           nvl(p_palyahossz, fe.palyahossz), nvl(p_kor_szam, fe.kor_szam),
           nvl(p_nyertes_szemely_id, fe.nyertes_szemely_id), nvl(p_leggyorsabb_szemely_id, fe.leggyorsabb_szemely_id),
           nvl(p_leggyorsabb_ido, fe.leggyorsabb_ido), nvl(p_idopont, fe.idopont)
    INTO v_futam_id, v_hanyadik_futam, v_palyahossz, v_kor_szam, v_nyertes_szemely_id, v_leggyorsabb_szemely_id,
         v_leggyorsabb_ido, v_idopont
    FROM futam_ev fe WHERE fe.futam_ev_id = p_futam_ev_id;
  
    UPDATE futam_ev fe
       SET fe.futam_id               = v_futam_id
          ,fe.hanyadik_futam         = v_hanyadik_futam
          ,fe.palyahossz             = v_palyahossz
          ,fe.kor_szam               = v_kor_szam
          ,fe.nyertes_szemely_id     = v_nyertes_szemely_id
          ,fe.leggyorsabb_szemely_id = v_leggyorsabb_szemely_id
          ,fe.leggyorsabb_ido        = v_leggyorsabb_ido
          ,fe.idopont                = v_idopont
     WHERE fe.futam_ev_id = p_futam_ev_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
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
                                 p_hiba_okozat => SQLERRM,
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
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'torles_futam_ev';
  
  BEGIN
    DELETE FROM futam_ev fe WHERE fe.futam_ev_id LIKE p_futam_ev_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_ev_id = ' ||
                                                  p_futam_ev_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_futam_ev_id = ' ||
                                                  p_futam_ev_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END torles_futam_ev;
  
  -- futam_ev tabla kiiratasa vagy egy futam_ev kiiratasa
  FUNCTION futam_ev_adatok(p_futam_ev_id IN NUMBER DEFAULT NULL) RETURN ty_futam_ev_l IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'futam_ev_adatok';
    c_list ty_futam_ev_l;
    
  BEGIN
    CASE
      WHEN p_futam_ev_id IS NULL THEN
        SELECT ty_futam_ev(fe.futam_ev_id,
                           fe.futam_id,
                           fe.hanyadik_futam,
                           fe.palyahossz,
                           fe.kor_szam,
                           fe.nyertes_szemely_id,
                           fe.leggyorsabb_szemely_id,
                           fe.leggyorsabb_ido,
                           fe.idopont)
        BULK COLLECT
        INTO c_list
        FROM futam_ev fe;
      ELSE
        SELECT ty_futam_ev(fe.futam_ev_id,
                           fe.futam_id,
                           fe.hanyadik_futam,
                           fe.palyahossz,
                           fe.kor_szam,
                           fe.nyertes_szemely_id,
                           fe.leggyorsabb_szemely_id,
                           fe.leggyorsabb_ido,
                           fe.idopont)
        BULK COLLECT
        INTO c_list
        FROM futam_ev fe
        WHERE fe.futam_ev_id = p_futam_ev_id;
    END CASE;

    /*FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Futam ev ID: ' || c_list(i).futam_ev_id || chr(10) ||
                           'Futam ID: ' || c_list(i).futam_id || chr(10) ||
                           'Hanyadik futam: ' || c_list(i).hanyadik_futam || chr(10) ||
                           'Palyahossz: ' || c_list(i).palyahossz || chr(10) ||
                           'Kor szam: ' || c_list(i).kor_szam || chr(10) ||
                           'Nyertes szemely: ' || c_list(i).nyertes_szemely_id || chr(10) ||
                           'Leggyorsabb szemely: ' || c_list(i).leggyorsabb_szemely_id || chr(10) ||
                           'Leggyorsabb ido: ' || c_list(i).leggyorsabb_ido || chr(10) ||
                           'Idopont: ' || c_list(i).idopont || chr(10));
    END LOOP;*/
    
    RETURN c_list;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_futam_ev_id = ' || p_futam_ev_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_futam_ev_id = ' || p_futam_ev_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END futam_ev_adatok;

END pkg_futam_ev;
/

CREATE OR REPLACE PACKAGE pkg_pilota_csapat IS

  PROCEDURE uj_pilota_csapat(p_szemely_id  IN NUMBER
                            ,p_csapat_id   IN NUMBER
                            ,p_pilota_szam IN NUMBER
                            ,p_mettol      IN DATE
                            ,p_meddig      IN DATE);

  PROCEDURE pilota_csapat_modositas(p_pilota_csapat_id IN NUMBER
                                   ,p_szemely_id       IN NUMBER DEFAULT NULL
                                   ,p_csapat_id        IN NUMBER DEFAULT NULL
                                   ,p_pilota_szam      IN NUMBER DEFAULT NULL
                                   ,p_mettol           IN DATE DEFAULT NULL
                                   ,p_meddig           IN DATE DEFAULT NULL);
                                   
  PROCEDURE torles_pilota_csapat(p_pilota_csapat_id IN NUMBER);
  
  FUNCTION pilota_csapat_adatok(p_pilota_csapat_id IN NUMBER DEFAULT NULL) RETURN ty_pilota_csapat_l;

END pkg_pilota_csapat;
/
CREATE OR REPLACE PACKAGE BODY pkg_pilota_csapat IS

  gc_pkg_nev CONSTANT VARCHAR2(30) := 'pkg_pilota_csapat';

  -- uj pilota_csapat osszerendeles a pilota_csapat tablaba
  PROCEDURE uj_pilota_csapat(p_szemely_id  IN NUMBER
                            ,p_csapat_id   IN NUMBER
                            ,p_pilota_szam IN NUMBER
                            ,p_mettol      IN DATE
                            ,p_meddig      IN DATE) IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'uj_pilota_csapat';
  BEGIN
    INSERT INTO pilota_csapat
      (szemely_id
      ,csapat_id
      ,pilota_szam
      ,mettol
      ,meddig)
    VALUES
      (p_szemely_id
      ,p_csapat_id
      ,p_pilota_szam
      ,p_mettol
      ,p_meddig);
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_szemely_id = ' ||
                                                  p_szemely_id || chr(10) ||
                                                  'p_csapat_id = ' ||
                                                  p_csapat_id || chr(10) ||
                                                  'p_pilota_szam = ' ||
                                                  p_pilota_szam || chr(10) ||
                                                  'p_mettol = ' || p_mettol ||
                                                  chr(10) || 'p_meddig = ' ||
                                                  p_meddig,
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
                                                  'p_csapat_id = ' ||
                                                  p_csapat_id || chr(10) ||
                                                  'p_pilota_szam = ' ||
                                                  p_pilota_szam || chr(10) ||
                                                  'p_mettol = ' || p_mettol ||
                                                  chr(10) || 'p_meddig = ' ||
                                                  p_meddig,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END uj_pilota_csapat;

  -- pilota_csapat modositas a pilota_osszes tablaban
  PROCEDURE pilota_csapat_modositas(p_pilota_csapat_id IN NUMBER
                                   ,p_szemely_id       IN NUMBER DEFAULT NULL
                                   ,p_csapat_id        IN NUMBER DEFAULT NULL
                                   ,p_pilota_szam      IN NUMBER DEFAULT NULL
                                   ,p_mettol           IN DATE DEFAULT NULL
                                   ,p_meddig           IN DATE DEFAULT NULL) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'pilota_csapat_modositas';
    uj_szemely_id NUMBER;
    uj_csapat_id NUMBER;
    uj_pilota_szam NUMBER;
    uj_mettol DATE;
    uj_meddig DATE;
    
  BEGIN
    uj_szemely_id := p_szemely_id;
    uj_csapat_id := p_csapat_id;
    uj_pilota_szam := p_pilota_szam;
    uj_mettol := p_mettol;
    uj_meddig := p_meddig;
    
    IF p_szemely_id IS NULL THEN
      SELECT pcs.szemely_id INTO uj_szemely_id FROM pilota_csapat pcs WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
    END IF;
    IF p_csapat_id IS NULL THEN
      SELECT pcs.csapat_id INTO uj_csapat_id FROM pilota_csapat pcs WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
    END IF;
    IF p_pilota_szam IS NULL THEN
      SELECT pcs.pilota_szam INTO uj_pilota_szam FROM pilota_csapat pcs WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
    END IF;
    IF p_mettol IS NULL THEN
      SELECT pcs.mettol INTO uj_mettol FROM pilota_csapat pcs WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
    END IF;
    IF p_meddig IS NULL THEN
      SELECT pcs.meddig INTO uj_meddig FROM pilota_csapat pcs WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
    END IF;
    
    UPDATE pilota_csapat pcs
       SET pcs.szemely_id  = uj_szemely_id
          ,pcs.csapat_id   = uj_csapat_id
          ,pcs.pilota_szam = uj_pilota_szam
          ,pcs.mettol      = uj_mettol
          ,pcs.meddig      = uj_meddig
     WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_pilota_csapat_id = ' ||
                                                  p_pilota_csapat_id ||
                                                  chr(10) ||
                                                  'p_szemely_id = ' ||
                                                  p_szemely_id || chr(10) ||
                                                  'p_csapat_id = ' ||
                                                  p_csapat_id || chr(10) ||
                                                  'p_pilota_szam = ' ||
                                                  p_pilota_szam || chr(10) ||
                                                  'p_mettol = ' || p_mettol ||
                                                  chr(10) || 'p_meddig = ' ||
                                                  p_meddig,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_pilota_csapat_id = ' ||
                                                  p_pilota_csapat_id ||
                                                  chr(10) ||
                                                  'p_szemely_id = ' ||
                                                  p_szemely_id || chr(10) ||
                                                  'p_csapat_id = ' ||
                                                  p_csapat_id || chr(10) ||
                                                  'p_pilota_szam = ' ||
                                                  p_pilota_szam || chr(10) ||
                                                  'p_mettol = ' || p_mettol ||
                                                  chr(10) || 'p_meddig = ' ||
                                                  p_meddig,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END pilota_csapat_modositas;
  
  -- pilota_csapat torles a pilota_csapat tablabol
  PROCEDURE torles_pilota_csapat(p_pilota_csapat_id IN NUMBER) IS
  
    c_proc_nev CONSTANT VARCHAR2(30) := 'torles_pilota_csapat';
  
  BEGIN
    DELETE FROM pilota_csapat pcs WHERE pcs.pilota_csapat_id LIKE p_pilota_csapat_id;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_pilota_csapat_id = ' ||
                                                  p_pilota_csapat_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code,
                              'Nincs valamilyen adat.');
      RAISE pkg_kivetelek.exc_nincs_adat_hiba;
    WHEN OTHERS THEN
      pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                 p_hiba_okozat => SQLERRM,
                                 p_hiba_ertek  => 'p_pilota_csapat_id = ' ||
                                                  p_pilota_csapat_id,
                                 p_api         => gc_pkg_nev || '.' ||
                                                  c_proc_nev);
      raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code,
                              'Altalanos hiba.');
      RAISE pkg_kivetelek.exc_altalanos_hiba;
  END torles_pilota_csapat;
  
  -- pilota_csapat tabla kiiratasa vagy egy pilota_csapat kiiratasa
  FUNCTION pilota_csapat_adatok(p_pilota_csapat_id IN NUMBER DEFAULT NULL) RETURN ty_pilota_csapat_l IS
    c_proc_nev CONSTANT VARCHAR2(30) := 'pilota_csapat_adatok';
    c_list ty_pilota_csapat_l;
    
  BEGIN
    CASE
      WHEN p_pilota_csapat_id IS NULL THEN
        SELECT ty_pilota_csapat(pcs.pilota_csapat_id,
                                pcs.szemely_id,
                                pcs.csapat_id,
                                pcs.pilota_szam,
                                pcs.mettol,
                                pcs.meddig)
        BULK COLLECT
        INTO c_list
        FROM pilota_csapat pcs;
      ELSE
        SELECT ty_pilota_csapat(pcs.pilota_csapat_id,
                                pcs.szemely_id,
                                pcs.csapat_id,
                                pcs.pilota_szam,
                                pcs.mettol,
                                pcs.meddig)
        BULK COLLECT
        INTO c_list
        FROM pilota_csapat pcs
        WHERE pcs.pilota_csapat_id = p_pilota_csapat_id;
    END CASE;

    /*FOR i IN 1 .. c_list.count
    LOOP
      dbms_output.put_line('Pilota csapat ID: ' || c_list(i).pilota_csapat_id || chr(10) ||
                           'Szemely nev: ' || c_list(i).szemely_id || chr(10) ||
                           'Csapat ID: ' || c_list(i).csapat_id || chr(10) ||
                           'Pilota szam: ' || c_list(i).pilota_szam || chr(10) ||
                           'Mettol: ' || c_list(i).mettol || chr(10) ||
                           'Meddig: ' || c_list(i).meddig || chr(10));
    END LOOP;*/
    
    RETURN c_list;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_pilota_csapat_id = ' || p_pilota_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_nincs_adat_hiba_code, 'Nincs adat az adott futamra.');
        RAISE pkg_kivetelek.exc_nincs_adat_hiba;
      WHEN OTHERS THEN
        pkg_hiba_log.proc_hiba_log(p_hiba_uzenet => dbms_utility.format_error_backtrace,
                                   p_hiba_okozat => SQLERRM,
                                   p_hiba_ertek  => 'p_pilota_csapat_id = ' || p_pilota_csapat_id,
                                   p_api         => gc_pkg_nev || '.' || c_proc_nev);
        raise_application_error(pkg_kivetelek.gc_altalanos_hiba_code, 'Altalanos hiba.');
        RAISE pkg_kivetelek.exc_altalanos_hiba;
  END pilota_csapat_adatok;

END pkg_pilota_csapat;
/

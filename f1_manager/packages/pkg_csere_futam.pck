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

  PROCEDURE futam_csere2021(p_verseny_id IN NUMBER,
                            p_futam_id IN NUMBER,
                            p_palyahossz IN NUMBER,
                            p_kor_szam IN NUMBER,
                            p_nyertes_pilota_id IN NUMBER,
                            p_leggyorsabb_pilota_id IN NUMBER,
                            p_leggyorsabb_ido IN VARCHAR2,
                            p_idopont IN DATE) IS
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
  END futam_csere2021;
  
  PROCEDURE futam_csere2022(p_verseny_id IN NUMBER,
                            p_futam_id IN NUMBER,
                            p_palyahossz IN NUMBER,
                            p_kor_szam IN NUMBER,
                            p_nyertes_pilota_id IN NUMBER,
                            p_leggyorsabb_pilota_id IN NUMBER,
                            p_leggyorsabb_ido IN VARCHAR2,
                            p_idopont IN DATE) IS
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
  END futam_csere2022;

END pkg_csere_futam;
/

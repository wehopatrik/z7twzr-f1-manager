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

  PROCEDURE uj_motorgyarto(p_motorgyarto_nev IN VARCHAR2) IS
  BEGIN
    INSERT INTO motorgyartok(motorgyarto_nev)
    VALUES(p_motorgyarto_nev);
  END uj_motorgyarto;
  
  PROCEDURE uj_csapat(p_csapat_nev IN VARCHAR2,
                      p_motorgyarto_id IN NUMBER,
                      p_csatlakozas_ev IN NUMBER,
                      p_kozpont_hely IN VARCHAR2,
                      p_kozpont_orszag IN VARCHAR2) IS
  BEGIN
    INSERT INTO csapatok(csapat_nev,motorgyarto_id,csatlakozas_ev,kozpont_hely,kozpont_orszag)
    VALUES(p_csapat_nev,p_motorgyarto_id,p_csatlakozas_ev,p_kozpont_hely,p_kozpont_orszag);
  END uj_csapat;
  
  PROCEDURE uj_pilota(p_szemely_nev IN VARCHAR2,
                      p_szul_datum IN DATE,
                      p_szul_orszag IN VARCHAR2,
                      p_szul_hely IN VARCHAR2,
                      p_nemzetiseg IN VARCHAR2) IS
  BEGIN
    INSERT INTO pilotak_osszes(szemely_nev,szul_datum,szul_orszag,szul_hely,nemzetiseg)
    VALUES(p_szemely_nev,p_szul_datum,p_szul_orszag,p_szul_hely,p_nemzetiseg);
  END uj_pilota;
  
  PROCEDURE uj_pilota2021(p_pilota_id IN NUMBER,
                          p_szemely_id IN NUMBER,
                          p_csapat_id IN NUMBER) IS
  BEGIN
    INSERT INTO pilotak2021(pilota_id,szemely_id,csapat_id)
    VALUES(p_pilota_id,p_szemely_id,p_csapat_id);
  END uj_pilota2021;
  
  PROCEDURE uj_pilota2022(p_pilota_id IN NUMBER,
                          p_szemely_id IN NUMBER,
                          p_csapat_id IN NUMBER) IS
  BEGIN
    INSERT INTO pilotak2022(pilota_id,szemely_id,csapat_id)
    VALUES(p_pilota_id,p_szemely_id,p_csapat_id);
  END uj_pilota2022;
  
  PROCEDURE uj_futam(p_futam_nev IN VARCHAR2,
                     p_futam_orszag IN VARCHAR2,
                     p_futam_hely IN VARCHAR2,
                     p_palya_nev IN VARCHAR2) IS
  BEGIN
    INSERT INTO futamok_osszes(futam_nev,futam_orszag,futam_hely,palya_nev)
    VALUES(p_futam_nev,p_futam_orszag,p_futam_hely,p_palya_nev);
  END uj_futam;
  
  PROCEDURE uj_futam2021(p_futam_id IN NUMBER,
                         p_palyahossz IN NUMBER,
                         p_kor_szam IN NUMBER,
                         p_nyertes_pilota_id IN NUMBER,
                         p_leggyorsabb_pilota_id IN NUMBER,
                         p_leggyorsabb_ido IN VARCHAR2,
                         p_idopont IN DATE) IS
  BEGIN
    INSERT INTO futamok2021(futam_id,palyahossz,kor_szam,nyertes_pilota_id,leggyorsabb_pilota_id,leggyorsabb_ido,idopont)
    VALUES(p_futam_id,p_palyahossz,p_kor_szam,p_nyertes_pilota_id,p_leggyorsabb_pilota_id,p_leggyorsabb_ido,p_idopont);
  END uj_futam2021;
  
  PROCEDURE uj_futam2022(p_futam_id IN NUMBER,
                         p_palyahossz IN NUMBER,
                         p_kor_szam IN NUMBER,
                         p_nyertes_pilota_id IN NUMBER,
                         p_leggyorsabb_pilota_id IN NUMBER,
                         p_leggyorsabb_ido IN VARCHAR2,
                         p_idopont IN DATE) IS
  BEGIN
    INSERT INTO futamok2022(futam_id,palyahossz,kor_szam,nyertes_pilota_id,leggyorsabb_pilota_id,leggyorsabb_ido,idopont)
    VALUES(p_futam_id,p_palyahossz,p_kor_szam,p_nyertes_pilota_id,p_leggyorsabb_pilota_id,p_leggyorsabb_ido,p_idopont);
  END uj_futam2022;
  
  

END pkg_uj_elem;
/

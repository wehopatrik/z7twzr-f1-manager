CREATE TABLE futamok2022(
  verseny_id                      NUMBER         NOT NULL
 ,futam_id                        NUMBER         NOT NULL
 ,palyahossz                      NUMBER
 ,kor_szam                        NUMBER
 ,nyertes_pilota_id               NUMBER
 ,leggyorsabb_pilota_id           NUMBER
 ,leggyorsabb_ido                 VARCHAR(10)
 ,idopont                         DATE
 ,utolso_modositas                DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozas                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,DML_FLAG                        VARCHAR(1)
 ,VERSION                         NUMBER
) 
TABLESPACE users;

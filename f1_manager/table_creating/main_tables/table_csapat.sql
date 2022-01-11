CREATE TABLE csapat(
  csapat_id                       NUMBER         NOT NULL
 ,csapat_nev                      VARCHAR2(40)   NOT NULL
 ,motorgyarto_id                  NUMBER
 ,csatlakozas_ev                  NUMBER
 ,kozpont_hely                    VARCHAR2(40)
 ,kozpont_orszag                  VARCHAR2(40)
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
) 
TABLESPACE users;

CREATE TABLE csapatok(
  csapat_id                       NUMBER         NOT NULL
 ,csapat_nev                      VARCHAR(40)    NOT NULL
 ,motorgyarto_id                  NUMBER
 ,csatlakozas_ev                  NUMBER
 ,kozpont_hely                    VARCHAR(40)
 ,kozpont_orszag                  VARCHAR(40)
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,dml_flag                        VARCHAR(1)
 ,version                         NUMBER
) 
TABLESPACE users;

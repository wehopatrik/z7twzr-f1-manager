CREATE TABLE csapatok(
  csapat_id                       NUMBER         NOT NULL
 ,csapat_nev                      VARCHAR(40)    NOT NULL
 ,motorgyarto_id                  NUMBER         NOT NULL
 ,csatlakozas_ev                  NUMBER
 ,kozpont_hely                    VARCHAR(40)
 ,kozpont_orszag                  VARCHAR(40)
 ,utolso_modositas                DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozas                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,DML_FLAG                        VARCHAR(1)
 ,VERSION                         NUMBER
) 
TABLESPACE users;

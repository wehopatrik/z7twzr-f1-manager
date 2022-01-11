CREATE TABLE csapat_h(
  csapat_id                       NUMBER
 ,csapat_nev                      VARCHAR2(40)
 ,motorgyarto_id                  NUMBER
 ,csatlakozas_ev                  NUMBER
 ,kozpont_hely                    VARCHAR2(40)
 ,kozpont_orszag                  VARCHAR2(40)
 ,modositva                       DATE
 ,letrehozva                      DATE
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
);

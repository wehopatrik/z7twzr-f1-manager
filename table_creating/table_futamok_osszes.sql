CREATE TABLE futamok_osszes(
  futam_id                        NUMBER         NOT NULL
 ,futam_nev                       VARCHAR(40)    NOT NULL
 ,futam_orszag                    VARCHAR(40)
 ,futam_hely                      VARCHAR(40)
 ,palya_nev                       VARCHAR(40)
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,dml_flag                        VARCHAR(1)
 ,version                         NUMBER
) 
TABLESPACE users;

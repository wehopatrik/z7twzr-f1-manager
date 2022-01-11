CREATE TABLE futam_osszes(
  futam_id                        NUMBER         NOT NULL
 ,futam_nev                       VARCHAR2(40)   NOT NULL
 ,futam_orszag                    VARCHAR2(40)
 ,futam_hely                      VARCHAR2(40)
 ,palya_nev                       VARCHAR2(40)
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
) 
TABLESPACE users;

CREATE TABLE futamok_osszes(
  futam_id                        NUMBER         NOT NULL
 ,futam_nev                       VARCHAR(40)    NOT NULL
 ,futam_orszag                    VARCHAR(40)
 ,futam_hely                      VARCHAR(40)
 ,palya_nev                       VARCHAR(40)
 ,utolso_modositas                DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozas                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,DML_FLAG                        VARCHAR(1)
 ,VERSION                         NUMBER
) 
TABLESPACE users;

CREATE TABLE pilotak_osszes(
  szemely_id                      NUMBER         NOT NULL
 ,szemely_nev                     VARCHAR(40)    NOT NULL
 ,szul_datum                      DATE
 ,szul_orszag                     VARCHAR(40)
 ,szul_hely                       VARCHAR(40)
 ,nemzetiseg                      VARCHAR(40)
 ,utolso_modositas                DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozas                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,DML_FLAG                        VARCHAR(1)
 ,VERSION                         NUMBER
) 
TABLESPACE users;










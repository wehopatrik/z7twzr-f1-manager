CREATE TABLE pilota_osszes(
  szemely_id                      NUMBER         NOT NULL
 ,szemely_nev                     VARCHAR(40)    NOT NULL
 ,szul_datum                      DATE
 ,szul_orszag                     VARCHAR(40)
 ,szul_hely                       VARCHAR(40)
 ,nemzetiseg                      VARCHAR(40)
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,dml_flag                        VARCHAR(1)
 ,version                         NUMBER
) 
TABLESPACE users;










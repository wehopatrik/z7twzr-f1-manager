CREATE TABLE pilota_osszes(
  szemely_id                      NUMBER         NOT NULL
 ,szemely_nev                     VARCHAR2(40)   NOT NULL
 ,szul_datum                      DATE
 ,szul_orszag                     VARCHAR2(40)
 ,szul_hely                       VARCHAR2(40)
 ,nemzetiseg                      VARCHAR2(40)
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
) 
TABLESPACE users;










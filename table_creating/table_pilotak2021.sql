CREATE TABLE pilotak2021(
  pilota_id                       NUMBER         NOT NULL
 ,szemely_id                      NUMBER         NOT NULL
 ,csapat_id                       NUMBER         NOT NULL
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,dml_flag                        VARCHAR(1)
 ,version                         NUMBER
) 
TABLESPACE users;
  

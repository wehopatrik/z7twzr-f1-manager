CREATE TABLE pilota_csapat(
  pilota_csapat_id                NUMBER         NOT NULL
 ,szemely_id                      NUMBER         NOT NULL
 ,csapat_id                       NUMBER         NOT NULL
 ,pilota_szam                     NUMBER         NOT NULL
 ,mettol                          DATE           NOT NULL
 ,meddig                          DATE
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
) 
TABLESPACE users;
  

CREATE TABLE motorgyarto(
  motorgyarto_id                  NUMBER         NOT NULL
 ,motorgyarto_nev                 VARCHAR(30)    NOT NULL
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,dml_flag                        VARCHAR(1)
 ,version                         NUMBER
) 
TABLESPACE users;

CREATE TABLE motorgyarto(
  motorgyarto_id                  NUMBER         NOT NULL
 ,motorgyarto_nev                 VARCHAR2(30)   NOT NULL
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
) 
TABLESPACE users;

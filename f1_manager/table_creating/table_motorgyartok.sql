CREATE TABLE motorgyartok(
  motorgyarto_id                  NUMBER         NOT NULL
 ,motorgyarto_nev                 VARCHAR(30)    NOT NULL
 ,utolso_modositas                DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozas                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,DML_FLAG                        VARCHAR(1)
 ,VERSION                         NUMBER
) 
TABLESPACE users;

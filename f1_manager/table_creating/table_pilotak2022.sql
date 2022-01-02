CREATE TABLE pilotak2022(
  pilota_id                       NUMBER         NOT NULL
 ,szemely_id                      NUMBER         NOT NULL
 ,csapat_id                       NUMBER         NOT NULL
 ,utolso_modositas                DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozas                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,DML_FLAG                        VARCHAR(1)
 ,VERSION                         NUMBER
) 
TABLESPACE users;

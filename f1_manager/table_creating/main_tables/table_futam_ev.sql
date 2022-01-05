CREATE TABLE futam_ev(
  futam_ev_id                     NUMBER         NOT NULL
 ,futam_id                        NUMBER         NOT NULL
 ,hanyadik_futam                  NUMBER         NOT NULL
 ,palyahossz                      NUMBER
 ,kor_szam                        NUMBER
 ,nyertes_szemely_id              NUMBER
 ,leggyorsabb_szemely_id          NUMBER
 ,leggyorsabb_ido                 VARCHAR(10)
 ,idopont                         DATE
 ,modositva                       DATE           DEFAULT SYSDATE NOT NULL
 ,letrehozva                      DATE           DEFAULT SYSDATE NOT NULL
 ,mod_felhasznalo                 VARCHAR(50)
 ,dml_flag                        VARCHAR(1)
 ,version                         NUMBER
) 
TABLESPACE users;

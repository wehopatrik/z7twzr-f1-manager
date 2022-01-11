CREATE TABLE futam_ev_h(
  futam_ev_id                     NUMBER
 ,futam_id                        NUMBER
 ,hanyadik_futam                  NUMBER
 ,palyahossz                      NUMBER
 ,kor_szam                        NUMBER
 ,nyertes_szemely_id              NUMBER
 ,leggyorsabb_szemely_id          NUMBER
 ,leggyorsabb_ido                 VARCHAR2(10)
 ,idopont                         DATE
 ,modositva                       DATE
 ,letrehozva                      DATE
 ,mod_felhasznalo                 VARCHAR2(50)
 ,dml_flag                        VARCHAR2(1)
 ,version                         NUMBER
);

CREATE TABLE hiba_log(
  hiba_id        NUMBER
 ,hiba_ido       DATE DEFAULT SYSDATE
 ,hiba_uzenet    VARCHAR2(4000)
 ,hiba_okozat    VARCHAR2(4000)
 ,hiba_ertek     VARCHAR2(4000)
 ,api            VARCHAR2(100)
);

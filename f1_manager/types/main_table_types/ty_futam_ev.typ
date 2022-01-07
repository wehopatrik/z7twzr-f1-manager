CREATE OR REPLACE TYPE ty_futam_ev AS OBJECT
(
  futam_ev_id            NUMBER,
  futam_id               NUMBER,
  hanyadik_futam         NUMBER,
  palyahossz             NUMBER,
  kor_szam               NUMBER,
  nyertes_szemely_id     NUMBER,
  leggyorsabb_szemely_id NUMBER,
  leggyorsabb_ido        VARCHAR(10),
  idopont                DATE,

  CONSTRUCTOR FUNCTION ty_futam_ev RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_futam_ev(futam_ev_id VARCHAR2)
    RETURN SELF AS RESULT
)
/

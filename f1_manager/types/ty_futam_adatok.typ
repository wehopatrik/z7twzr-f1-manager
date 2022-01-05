CREATE OR REPLACE TYPE ty_futam_adatok AS OBJECT
(
    futam_nev VARCHAR2(30),
    nyertes_pilota VARCHAR2(30),
    nyertes_csapat VARCHAR2(30),
    leggyorsabb_pilota VARCHAR2(30),

  CONSTRUCTOR FUNCTION ty_futam_adatok RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_futam_adatok(futam_nev VARCHAR2)
  RETURN SELF AS RESULT
)
/

CREATE OR REPLACE TYPE ty_hanyszor_nyert AS OBJECT
(
    nyertes_pilota VARCHAR2(30),
    nyereseg_szama NUMBER,

  CONSTRUCTOR FUNCTION ty_hanyszor_nyert RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_hanyszor_nyert(nyertes_pilota VARCHAR2)
  RETURN SELF AS RESULT
)
/

CREATE OR REPLACE TYPE ty_pilota_csapat AS OBJECT
(
  pilota_csapat_id NUMBER,
  szemely_id       NUMBER,
  csapat_id        NUMBER,
  pilota_szam      NUMBER,
  mettol           DATE,
  meddig           DATE,
  
  CONSTRUCTOR FUNCTION ty_pilota_csapat RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_pilota_csapat(pilota_csapat_id VARCHAR2)
    RETURN SELF AS RESULT
)
/

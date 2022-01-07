CREATE OR REPLACE TYPE ty_pilota_osszes AS OBJECT
(
  szemely_id  NUMBER,
  szemely_nev VARCHAR(40),
  szul_datum  DATE,
  szul_orszag VARCHAR(40),
  szul_hely   VARCHAR(40),
  nemzetiseg  VARCHAR(40),
  
  CONSTRUCTOR FUNCTION ty_pilota_osszes RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_pilota_osszes(szemely_id VARCHAR2)
    RETURN SELF AS RESULT
)
/

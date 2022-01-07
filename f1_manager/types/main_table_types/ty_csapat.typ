CREATE OR REPLACE TYPE ty_csapat AS OBJECT
(
  csapat_id      NUMBER,
  csapat_nev     VARCHAR(40),
  motorgyarto_id NUMBER,
  csatlakozas_ev NUMBER,
  kozpont_hely   VARCHAR(40),
  kozpont_orszag VARCHAR(40),
  
  CONSTRUCTOR FUNCTION ty_csapat RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_csapat(csapat_id VARCHAR2) RETURN SELF AS RESULT
)
/

CREATE OR REPLACE TYPE ty_motorgyarto AS OBJECT
(
  motorgyarto_id  NUMBER,
  motorgyarto_nev VARCHAR(30),

  CONSTRUCTOR FUNCTION ty_motorgyarto RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_motorgyarto(motorgyarto_id VARCHAR2)
    RETURN SELF AS RESULT
)
/

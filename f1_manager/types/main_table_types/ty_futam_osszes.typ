CREATE OR REPLACE TYPE ty_futam_osszes AS OBJECT
(
  futam_id     NUMBER,
  futam_nev    VARCHAR2(40),
  futam_orszag VARCHAR2(40),
  futam_hely   VARCHAR2(40),
  palya_nev    VARCHAR2(40),

  CONSTRUCTOR FUNCTION ty_futam_osszes RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION ty_futam_osszes(futam_id VARCHAR2)
    RETURN SELF AS RESULT
)
/

CREATE OR REPLACE TRIGGER futamok_osszes_seq_trg
  BEFORE INSERT ON futamok_osszes
  FOR EACH ROW
BEGIN
  IF :new.futam_id IS NULL
  THEN
    :new.futam_id := futamok_osszes_seq.nextval;
  END IF;
END;
/

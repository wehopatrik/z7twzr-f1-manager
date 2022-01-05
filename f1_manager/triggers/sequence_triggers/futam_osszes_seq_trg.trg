CREATE OR REPLACE TRIGGER futam_osszes_seq_trg
  BEFORE INSERT OR UPDATE ON futam_osszes
  FOR EACH ROW
BEGIN
  IF :new.futam_id IS NULL
  THEN
    :new.futam_id := futam_osszes_seq.nextval;
  END IF;
END;
/

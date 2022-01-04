CREATE OR REPLACE TRIGGER pilota_osszes_seq_trg
  BEFORE INSERT OR UPDATE ON pilota_osszes
  FOR EACH ROW
BEGIN
  IF :new.szemely_id IS NULL
  THEN
    :new.szemely_id := pilota_osszes_seq.nextval;
  END IF;
END;
/

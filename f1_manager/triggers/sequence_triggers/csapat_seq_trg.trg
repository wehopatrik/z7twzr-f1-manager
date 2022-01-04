CREATE OR REPLACE TRIGGER csapat_seq_trg
  BEFORE INSERT OR UPDATE ON csapat
  FOR EACH ROW
BEGIN
  IF :new.csapat_id IS NULL
  THEN
    :new.csapat_id := csapat_seq.nextval;
  END IF;
END;
/

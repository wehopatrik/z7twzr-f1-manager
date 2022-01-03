CREATE OR REPLACE TRIGGER csapatok_seq_trg
  BEFORE INSERT OR UPDATE ON csapatok
  FOR EACH ROW
BEGIN
  IF :new.csapat_id IS NULL
  THEN
    :new.csapat_id := csapatok_seq.nextval;
  END IF;
END;
/

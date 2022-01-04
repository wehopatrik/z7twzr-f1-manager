CREATE OR REPLACE TRIGGER motorgyarto_seq_trg
  BEFORE INSERT OR UPDATE ON motorgyarto
  FOR EACH ROW
BEGIN
  IF :new.motorgyarto_id IS NULL
  THEN
    :new.motorgyarto_id := motorgyarto_seq.nextval;
  END IF;
END;
/

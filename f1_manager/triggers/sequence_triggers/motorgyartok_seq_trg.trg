CREATE OR REPLACE TRIGGER motorgyartok_seq_trg
  BEFORE INSERT OR UPDATE ON motorgyartok
  FOR EACH ROW
BEGIN
  IF :new.motorgyarto_id IS NULL
  THEN
    :new.motorgyarto_id := motorgyartok_seq.nextval;
  END IF;
END;
/

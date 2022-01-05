CREATE OR REPLACE TRIGGER pilota_csapat_seq_trg
  BEFORE INSERT OR UPDATE ON pilota_csapat
  FOR EACH ROW
BEGIN
  IF :new.pilota_csapat_id IS NULL
  THEN
    :new.pilota_csapat_id := pilota_csapat_seq.nextval;
  END IF;
END;
/

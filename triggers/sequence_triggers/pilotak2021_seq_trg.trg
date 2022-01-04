CREATE OR REPLACE TRIGGER pilotak2021_seq_trg
  BEFORE INSERT OR UPDATE ON pilotak2021
  FOR EACH ROW
BEGIN
  IF :new.pilota_id IS NULL
  THEN
    :new.pilota_id := pilotak2021_seq.nextval;
  END IF;
END;
/

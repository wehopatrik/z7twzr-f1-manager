CREATE OR REPLACE TRIGGER pilotak2022_seq_trg
  BEFORE INSERT OR UPDATE ON pilotak2022
  FOR EACH ROW
BEGIN
  IF :new.pilota_id IS NULL
  THEN
    :new.pilota_id := pilotak2022_seq.nextval;
  END IF;
END;
/

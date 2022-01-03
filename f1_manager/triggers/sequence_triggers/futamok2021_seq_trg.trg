CREATE OR REPLACE TRIGGER futamok2021_seq_trg
  BEFORE INSERT OR UPDATE ON futamok2021
  FOR EACH ROW
BEGIN
  IF :new.verseny_id IS NULL
  THEN
    :new.verseny_id := futamok2021_seq.nextval;
  END IF;
END;
/

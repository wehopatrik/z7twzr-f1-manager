CREATE OR REPLACE TRIGGER futamok2022_seq_trg
  BEFORE INSERT OR UPDATE ON futamok2022
  FOR EACH ROW
BEGIN
  IF :new.verseny_id IS NULL
  THEN
    :new.verseny_id := futamok2022_seq.nextval;
  END IF;
END;
/

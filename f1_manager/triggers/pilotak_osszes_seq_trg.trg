CREATE OR REPLACE TRIGGER pilotak_osszes_seq_trg
  BEFORE INSERT ON pilotak_osszes
  FOR EACH ROW
BEGIN
  IF :new.szemely_id IS NULL
  THEN
    :new.szemely_id := pilotak_osszes_seq.nextval;
  END IF;
END;
/

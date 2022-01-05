CREATE OR REPLACE TRIGGER futam_ev_seq_trg
  BEFORE INSERT OR UPDATE ON futam_ev
  FOR EACH ROW
BEGIN
  IF :new.futam_ev_id IS NULL
  THEN
    :new.futam_ev_id := futam_ev_seq.nextval;
  END IF;
END;
/

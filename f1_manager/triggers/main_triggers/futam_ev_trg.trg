CREATE OR REPLACE TRIGGER futam_ev_trg
  BEFORE INSERT OR UPDATE ON futam_ev
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.futam_ev_id IS NULL
    THEN
      :new.futam_ev_id := futam_ev_seq.nextval;
    END IF;
    :new.letrehozva := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
  ELSE
    IF nvl(:new.dml_flag, 'U') <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
    :new.version := :old.version + 1;
  END IF;
  
  :new.modositva := SYSDATE;
  :new.mod_felhasznalo := sys_context('USERENV', 'OS_USER');
END;
/

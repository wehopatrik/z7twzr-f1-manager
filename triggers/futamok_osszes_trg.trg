CREATE OR REPLACE TRIGGER futamok_osszes_trg
  BEFORE INSERT OR UPDATE ON futamok_osszes
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.futam_id IS NULL
    THEN
      :new.futam_id := futamok_osszes_seq.nextval;
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

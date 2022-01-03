CREATE OR REPLACE TRIGGER pilotak2022_trg
  BEFORE INSERT OR UPDATE ON pilotak2022
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.pilota_id IS NULL
    THEN
      :new.pilota_id := pilotak2022_seq.nextval;
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

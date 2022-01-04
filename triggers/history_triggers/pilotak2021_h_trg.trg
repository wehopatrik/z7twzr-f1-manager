CREATE OR REPLACE TRIGGER pilotak2021_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON pilotak2021
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      pilotak2021_h.mod_felhasznalo%TYPE;
  v_mod_ido              pilotak2021_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO pilotak2021_h(pilota_id,szemely_id,csapat_id,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.pilota_id
      ,:old.szemely_id
      ,:old.csapat_id
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO pilotak2021_h(pilota_id,szemely_id,csapat_id,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.pilota_id
      ,:new.szemely_id
      ,:new.csapat_id
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

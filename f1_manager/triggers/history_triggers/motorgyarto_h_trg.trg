CREATE OR REPLACE TRIGGER motorgyarto_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON motorgyarto
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      motorgyarto_h.mod_felhasznalo%TYPE;
  v_mod_ido              motorgyarto_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO motorgyarto_h(motorgyarto_id,motorgyarto_nev,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.motorgyarto_id
      ,:old.motorgyarto_nev
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO motorgyarto_h(motorgyarto_id,motorgyarto_nev,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.motorgyarto_id
      ,:new.motorgyarto_nev
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

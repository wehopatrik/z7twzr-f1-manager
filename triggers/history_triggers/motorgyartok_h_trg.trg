CREATE OR REPLACE TRIGGER motorgyartok_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON motorgyartok
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      motorgyartok_h.mod_felhasznalo%TYPE;
  v_mod_ido              motorgyartok_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO motorgyartok_h(motorgyarto_id,motorgyarto_nev,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.motorgyarto_id
      ,:old.motorgyarto_nev
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO motorgyartok_h(motorgyarto_id,motorgyarto_nev,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
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

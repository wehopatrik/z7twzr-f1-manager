CREATE OR REPLACE TRIGGER pilota_csapat_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON pilota_csapat
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      pilota_csapat_h.mod_felhasznalo%TYPE;
  v_mod_ido              pilota_csapat_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO pilota_csapat_h(pilota_csapat_id,szemely_id,csapat_id,pilota_szam,mettol,meddig,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.pilota_csapat_id
      ,:old.szemely_id
      ,:old.csapat_id
      ,:old.pilota_szam
      ,:old.mettol
      ,:old.meddig
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO pilota_csapat_h(pilota_csapat_id,szemely_id,csapat_id,pilota_szam,mettol,meddig,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.pilota_csapat_id
      ,:new.szemely_id
      ,:new.csapat_id
      ,:new.pilota_szam
      ,:new.mettol
      ,:new.meddig
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

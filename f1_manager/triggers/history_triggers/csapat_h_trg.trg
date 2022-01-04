CREATE OR REPLACE TRIGGER csapat_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON csapat
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      csapat_h.mod_felhasznalo%TYPE;
  v_mod_ido              csapat_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO csapat_h(csapat_id,csapat_nev,motorgyarto_id,csatlakozas_ev,kozpont_hely,kozpont_orszag,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.csapat_id
      ,:old.csapat_nev
      ,:old.motorgyarto_id
      ,:old.csatlakozas_ev
      ,:old.kozpont_hely
      ,:old.kozpont_orszag
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO csapat_h(csapat_id,csapat_nev,motorgyarto_id,csatlakozas_ev,kozpont_hely,kozpont_orszag,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.csapat_id
      ,:new.csapat_nev
      ,:new.motorgyarto_id
      ,:new.csatlakozas_ev
      ,:new.kozpont_hely
      ,:new.kozpont_orszag
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

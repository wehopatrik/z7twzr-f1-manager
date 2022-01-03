CREATE OR REPLACE TRIGGER futamok_osszes_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON futamok_osszes
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      futamok_osszes_h.mod_felhasznalo%TYPE;
  v_mod_ido              futamok_osszes_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO futamok_osszes_h(futam_id,futam_nev,futam_orszag,futam_hely,palya_nev,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.futam_id
      ,:old.futam_nev
      ,:old.futam_orszag
      ,:old.futam_hely
      ,:old.palya_nev
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO futamok_osszes_h(futam_id,futam_nev,futam_orszag,futam_hely,palya_nev,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.futam_id
      ,:new.futam_nev
      ,:new.futam_orszag
      ,:new.futam_hely
      ,:new.palya_nev
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

CREATE OR REPLACE TRIGGER pilota_osszes_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON pilota_osszes
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      pilota_osszes_h.mod_felhasznalo%TYPE;
  v_mod_ido              pilota_osszes_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO pilota_osszes_h(szemely_id,szemely_nev,szul_datum,szul_orszag,szul_hely,nemzetiseg,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.szemely_id
      ,:old.szemely_nev
      ,:old.szul_datum
      ,:old.szul_orszag
      ,:old.szul_hely
      ,:old.nemzetiseg
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO pilota_osszes_h(szemely_id,szemely_nev,szul_datum,szul_orszag,szul_hely,nemzetiseg,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.szemely_id
      ,:new.szemely_nev
      ,:new.szul_datum
      ,:new.szul_orszag
      ,:new.szul_hely
      ,:new.nemzetiseg
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

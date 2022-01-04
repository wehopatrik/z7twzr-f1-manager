CREATE OR REPLACE TRIGGER futam_ev_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON futam_ev
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      futam_ev_h.mod_felhasznalo%TYPE;
  v_mod_ido              futam_ev_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO futam_ev_h(futam_ev_id,futam_id,hanyadik_futam,palyahossz,kor_szam,nyertes_szemely_id,leggyorsabb_szemely_id,leggyorsabb_ido,idopont,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.futam_ev_id
      ,:old.futam_id
      ,:old.hanyadik_futam
      ,:old.palyahossz
      ,:old.kor_szam
      ,:old.nyertes_szemely_id
      ,:old.leggyorsabb_szemely_id
      ,:old.leggyorsabb_ido
      ,:old.idopont
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO futam_ev_h(futam_ev_id,futam_id,hanyadik_futam,palyahossz,kor_szam,nyertes_szemely_id,leggyorsabb_szemely_id,leggyorsabb_ido,idopont,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.futam_ev_id
      ,:new.futam_id
      ,:new.hanyadik_futam
      ,:new.palyahossz
      ,:new.kor_szam
      ,:new.nyertes_szemely_id
      ,:new.leggyorsabb_szemely_id
      ,:new.leggyorsabb_ido
      ,:new.idopont
      ,:new.modositva
      ,:new.letrehozva
      ,:new.mod_felhasznalo
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

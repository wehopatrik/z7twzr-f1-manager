CREATE OR REPLACE TRIGGER futamok2022_h_trg
  AFTER INSERT OR UPDATE OR DELETE ON futamok2022
  FOR EACH ROW
DECLARE
  v_mod_felhasznalo      futamok2022_h.mod_felhasznalo%TYPE;
  v_mod_ido              futamok2022_h.modositva%TYPE;
BEGIN
  v_mod_felhasznalo := sys_context('USERENV', 'OS_USER');
  v_mod_ido := SYSDATE;

  IF deleting
  THEN
    INSERT INTO futamok2022_h(verseny_id,futam_id,palyahossz,kor_szam,nyertes_pilota_id,leggyorsabb_pilota_id,leggyorsabb_ido,idopont,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:old.verseny_id
      ,:old.futam_id
      ,:old.palyahossz
      ,:old.kor_szam
      ,:old.nyertes_pilota_id
      ,:old.leggyorsabb_pilota_id
      ,:old.leggyorsabb_ido
      ,:old.idopont
      ,v_mod_ido
      ,:old.letrehozva
      ,v_mod_felhasznalo
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO futamok2022_h(verseny_id,futam_id,palyahossz,kor_szam,nyertes_pilota_id,leggyorsabb_pilota_id,leggyorsabb_ido,idopont,modositva,letrehozva,mod_felhasznalo,dml_flag,version)
    VALUES
      (:new.verseny_id
      ,:new.futam_id
      ,:new.palyahossz
      ,:new.kor_szam
      ,:new.nyertes_pilota_id
      ,:new.leggyorsabb_pilota_id
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

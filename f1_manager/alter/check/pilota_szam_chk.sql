-- pilota_csapat(pilota_szam) csak 1-99-ig lehet 
ALTER TABLE pilota_csapat
  ADD CONSTRAINT pilota_szam_chk CHECK (pilota_szam BETWEEN 1 AND 99);

-- pilota_csapat(csapat_id) --> csapat(csapat_id)
ALTER TABLE pilota_csapat
  ADD CONSTRAINT pilota_csapat_fk1 FOREIGN KEY (csapat_id) REFERENCES csapat(csapat_id);

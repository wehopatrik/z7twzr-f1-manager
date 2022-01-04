-- pilota_csapat(szemely_id) --> pilota_osszes(szemely_id)
ALTER TABLE pilota_csapat
  ADD CONSTRAINT pilota_csapat_fk2 FOREIGN KEY (szemely_id) REFERENCES pilota_osszes(szemely_id);

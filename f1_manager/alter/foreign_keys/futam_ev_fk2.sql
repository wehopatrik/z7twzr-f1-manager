-- futam_ev(leggyorsabb_szemely_id) --> pilota_osszes(szemely_id)
ALTER TABLE futam_ev
  ADD CONSTRAINT futam_ev_fk2 FOREIGN KEY (leggyorsabb_szemely_id) REFERENCES pilota_osszes(szemely_id);

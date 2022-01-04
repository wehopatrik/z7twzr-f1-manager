-- futam_ev(nyertes_szemely_id) --> pilota_osszes(szemely_id)
ALTER TABLE futam_ev
  ADD CONSTRAINT futam_ev_fk1 FOREIGN KEY (nyertes_szemely_id) REFERENCES pilota_osszes(szemely_id);

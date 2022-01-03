-- pilotak2021(pilota_nev) --> pilotak_osszes(pilota_id)
ALTER TABLE pilotak2021
  ADD CONSTRAINT pilota_ossz_2021_fk FOREIGN KEY (szemely_id) REFERENCES pilotak_osszes(szemely_id);

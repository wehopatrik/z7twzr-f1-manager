-- pilotak2022(pilota_nev) --> pilotak_osszes(pilota_id)
ALTER TABLE pilotak2022
  ADD CONSTRAINT pilota_ossz_2022_fk FOREIGN KEY (szemely_id) REFERENCES pilotak_osszes(szemely_id);

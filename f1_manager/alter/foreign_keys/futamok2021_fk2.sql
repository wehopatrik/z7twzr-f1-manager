-- futamok2021(leggyorsabb_pilota_id) --> pilotak2021(pilota_id)
ALTER TABLE futamok2021
  ADD CONSTRAINT leggyorsabb_pilota_id_2021_fk FOREIGN KEY (leggyorsabb_pilota_id) REFERENCES pilotak2021(pilota_id);

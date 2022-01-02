-- futamok2022(leggyorsabb_pilota_id) --> pilotak2022(pilota_id)
ALTER TABLE futamok2022
  ADD CONSTRAINT leggyorsabb_pilota_id_2022_fk FOREIGN KEY (leggyorsabb_pilota_id) REFERENCES pilotak2022(pilota_id);

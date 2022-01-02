-- futamok2022(nyertes_pilota_id) --> pilotak2022(pilota_id)
ALTER TABLE futamok2022
  ADD CONSTRAINT nyertes_pilota_id_2022_fk FOREIGN KEY (nyertes_pilota_id) REFERENCES pilotak2022(pilota_id);

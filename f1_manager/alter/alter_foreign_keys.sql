-- 1) csapatok(motorgyarto_id) --> motorgyartok(motorgyarto_id)
ALTER TABLE csapatok
  ADD CONSTRAINT motorgyarto_fk FOREIGN KEY (motorgyarto_id) REFERENCES motorgyartok(motorgyarto_id);

-- 2) pilotak2021(csapat_id) --> csapatok(csapat_id)
ALTER TABLE pilotak2021
  ADD CONSTRAINT csapat_id_2021_fk FOREIGN KEY (csapat_id) REFERENCES csapatok(csapat_id);
  
-- 3) pilotak2022(csapat_id) --> csapatok(csapat_id)
ALTER TABLE pilotak2022
  ADD CONSTRAINT csapat_id_2022_fk FOREIGN KEY (csapat_id) REFERENCES csapatok(csapat_id);

-- 4) futamok2021(nyertes_pilota_id) --> pilotak2021(pilota_id)
ALTER TABLE futamok2021
  ADD CONSTRAINT nyertes_pilota_id_2021_fk FOREIGN KEY (nyertes_pilota_id) REFERENCES pilotak2021(pilota_id);
  
-- 5) futamok2021(leggyorsabb_pilota_id) --> pilotak2021(pilota_id)
ALTER TABLE futamok2021
  ADD CONSTRAINT leggyorsabb_pilota_id_2021_fk FOREIGN KEY (leggyorsabb_pilota_id) REFERENCES pilotak2021(pilota_id);
  
-- 6) futamok2022(nyertes_pilota_id) --> pilotak2022(pilota_id)
ALTER TABLE futamok2022
  ADD CONSTRAINT nyertes_pilota_id_2022_fk FOREIGN KEY (nyertes_pilota_id) REFERENCES pilotak2022(pilota_id);
  
-- 7) futamok2022(leggyorsabb_pilota_id) --> pilotak2022(pilota_id)
ALTER TABLE futamok2022
  ADD CONSTRAINT leggyorsabb_pilota_id_2022_fk FOREIGN KEY (leggyorsabb_pilota_id) REFERENCES pilotak2022(pilota_id);

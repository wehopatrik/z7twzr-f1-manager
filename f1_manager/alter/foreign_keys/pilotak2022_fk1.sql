-- pilotak2022(csapat_id) --> csapatok(csapat_id)
ALTER TABLE pilotak2022
  ADD CONSTRAINT csapat_id_2022_fk FOREIGN KEY (csapat_id) REFERENCES csapatok(csapat_id);

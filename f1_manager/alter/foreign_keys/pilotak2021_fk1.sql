-- pilotak2021(csapat_id) --> csapatok(csapat_id)
ALTER TABLE pilotak2021
  ADD CONSTRAINT csapat_id_2021_fk FOREIGN KEY (csapat_id) REFERENCES csapatok(csapat_id);

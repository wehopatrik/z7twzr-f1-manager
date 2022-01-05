-- csapat(motorgyarto_id) --> motorgyarto(motorgyarto_id)
ALTER TABLE csapat
  ADD CONSTRAINT motorgyarto_fk FOREIGN KEY (motorgyarto_id) REFERENCES motorgyarto(motorgyarto_id);

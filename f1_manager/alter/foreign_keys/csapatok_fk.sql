-- csapatok(motorgyarto_id) --> motorgyartok(motorgyarto_id)
ALTER TABLE csapatok
  ADD CONSTRAINT motorgyarto_fk FOREIGN KEY (motorgyarto_id) REFERENCES motorgyartok(motorgyarto_id);

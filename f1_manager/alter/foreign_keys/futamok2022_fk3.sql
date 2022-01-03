-- futamok2022(futam_id) --> futamok_osszes(futam_id)  
ALTER TABLE futamok2022
  ADD CONSTRAINT futam_id_2022_fk FOREIGN KEY (futam_id) REFERENCES futamok_osszes(futam_id);

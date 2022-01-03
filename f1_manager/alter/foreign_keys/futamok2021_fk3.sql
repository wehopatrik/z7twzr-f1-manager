-- futamok2021(futam_id) --> futamok_osszes(futam_id)  
ALTER TABLE futamok2021
  ADD CONSTRAINT futam_id_2021_fk FOREIGN KEY (futam_id) REFERENCES futamok_osszes(futam_id);

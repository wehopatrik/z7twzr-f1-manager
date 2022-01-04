-- futam_ev(futam_id) --> futam_osszes(futam_id)  
ALTER TABLE futam_ev
  ADD CONSTRAINT futam_ev_fk3 FOREIGN KEY (futam_id) REFERENCES futam_osszes(futam_id);

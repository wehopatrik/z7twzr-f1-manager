CREATE OR REPLACE PACKAGE pkg_hiba_log IS

  PROCEDURE proc_hiba_log(p_hiba_uzenet   VARCHAR2
                         ,p_hiba_ertek    VARCHAR2
                         ,p_api           VARCHAR2);

END pkg_hiba_log;
/
CREATE OR REPLACE PACKAGE BODY pkg_hiba_log IS

  PROCEDURE proc_hiba_log(p_hiba_uzenet   VARCHAR2
                         ,p_hiba_ertek    VARCHAR2
                         ,p_api           VARCHAR2) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  
  BEGIN
    INSERT INTO hiba_log
      (hiba_id
      ,hiba_uzenet
      ,hiba_ertek
      ,api)
    VALUES
      (hiba_log_seq.nextval
      ,p_hiba_uzenet
      ,p_hiba_ertek
      ,p_api);
      
    COMMIT;
    
  END proc_hiba_log;
  
END pkg_hiba_log;
/

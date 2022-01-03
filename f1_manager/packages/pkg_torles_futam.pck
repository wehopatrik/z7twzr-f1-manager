CREATE OR REPLACE PACKAGE pkg_torles_futam IS

  PROCEDURE torles_futam2021(p_verseny_id IN NUMBER);
  
  PROCEDURE torles_futam2022(p_verseny_id IN NUMBER);

END pkg_torles_futam;
/
CREATE OR REPLACE PACKAGE BODY pkg_torles_futam IS

  PROCEDURE torles_futam2021(p_verseny_id IN NUMBER) IS
  BEGIN
    DELETE FROM futamok2021 f21 WHERE f21.verseny_id LIKE p_verseny_id;
  END torles_futam2021;
  
  PROCEDURE torles_futam2022(p_verseny_id IN NUMBER) IS
  BEGIN
    DELETE FROM futamok2022 f22 WHERE f22.verseny_id LIKE p_verseny_id;
  END torles_futam2022;


END pkg_torles_futam;
/

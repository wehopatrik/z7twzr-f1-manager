CREATE OR REPLACE PACKAGE pkg_kivetelek IS

  exc_nincs_adat_hiba EXCEPTION;
  gc_nincs_adat_hiba_code CONSTANT NUMBER := -20000;
  PRAGMA EXCEPTION_INIT(exc_nincs_adat_hiba, -20000);
  
  exc_nincs_ilyen_ev_hiba EXCEPTION;
  gc_nincs_ilyen_ev_hiba_code CONSTANT NUMBER := -20001;
  PRAGMA EXCEPTION_INIT(exc_nincs_ilyen_ev_hiba, -20001);
  
  exc_nincs_ilyen_pilota EXCEPTION;
  gc_nincs_ilyen_pilota_code CONSTANT NUMBER := -20002;
  PRAGMA EXCEPTION_INIT(exc_nincs_ilyen_pilota, -20002);
  
  exc_nincs_ilyen_gumi EXCEPTION;
  gc_nincs_ilyen_gumi_code CONSTANT NUMBER := -20003;
  PRAGMA EXCEPTION_INIT(exc_nincs_ilyen_gumi, -20003);
     
  exc_altalanos_hiba EXCEPTION;
  gc_altalanos_hiba_code CONSTANT NUMBER := -20100;
  PRAGMA EXCEPTION_INIT(exc_altalanos_hiba, -20100);
  
END pkg_kivetelek;
/
CREATE OR REPLACE PACKAGE BODY pkg_kivetelek IS
BEGIN
  NULL;
END pkg_kivetelek;
/

DECLARE
  CURSOR cur IS
    SELECT 'alter system kill session ''' || sid || ',' || serial# || '''' AS command
      FROM v$session
     WHERE username = 'F1_MANAGER';
BEGIN
  FOR c IN cur
  LOOP
    EXECUTE IMMEDIATE c.command;
  END LOOP;
END;
/

DECLARE cnt NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO cnt
    FROM dba_users t
   WHERE t.username = 'F1_MANAGER';
  IF cnt = 1
  THEN
    EXECUTE IMMEDIATE 'DROP USER f1_manager CASCADE';
  END IF;
END;
/

CREATE USER f1_manager identified BY "12345678" DEFAULT tablespace users quota unlimited ON users;

grant CREATE session TO f1_manager;
grant CREATE TABLE TO f1_manager;
grant CREATE view TO f1_manager;
grant CREATE sequence TO f1_manager;
grant CREATE PROCEDURE TO f1_manager;
grant CREATE TRIGGER TO f1_manager;

ALTER session SET current_schema = f1_manager;

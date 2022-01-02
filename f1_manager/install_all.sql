PROMPT Installing DB...

-- Esetleg install logolás

-- Szekvenciák létrehozása
@./sequences/csapatok_seq.sql
@./sequences/motorgyartok_seq.sql
@./sequences/pilotak_osszes_seq.sql
@./sequences/futamok_osszes_seq.sql

-- Táblák létrehozása
@./table_creating/table_motorgyartok.sql
@./table_creating/table_csapatok.sql
@./table_creating/table_pilotak_osszes.sql
@./table_creating/table_pilotak2021.sql
@./table_creating/table_pilotak2022.sql
@./table_creating/table_futamok_osszes.sql
@./table_creating/table_futamok2021.sql
@./table_creating/table_futamok2022.sql

-- Elsõdleges kulcsok
@./alter/primary_keys/motorgyartok_pk.sql
@./alter/primary_keys/csapatok_pk.sql
@./alter/primary_keys/pilotak_osszes_pk.sql
@./alter/primary_keys/pilotak2021_pk.sql
@./alter/primary_keys/pilotak2022_pk.sql
@./alter/primary_keys/futamok_osszes_pk.sql
@./alter/primary_keys/futamok2021_pk.sql
@./alter/primary_keys/futamok2022_pk.sql

-- Típusok installálása

-- Packages

-- Nézetek
-- @./views/vw_csapat_motor.sql
-- @./views/vw_pilota_csapat_2021.sql
-- @./views/vw_pilota_csapat_2022.sql
-- @./views/vw_futamok_2021.sql
-- @./views/vw_futamok_2022.sql



-- Séma újrafordítása
BEGIN
  dbms_utility.compile_schema(schema => 'F1_MANAGER');
END;
/

-- Tábla feltöltések
@./table_loading/insert_into_motorgyartok.sql
@./table_loading/insert_into_csapatok.sql
@./table_loading/insert_into_pilotak_osszes.sql
@./table_loading/insert_into_pilotak2021.sql
@./table_loading/insert_into_pilotak2022.sql
@./table_loading/insert_into_futamok_osszes.sql
@./table_loading/insert_into_futamok2021.sql
@./table_loading/insert_into_futamok2022.sql

-- Külsõ kulcsok
@./alter/foreign_keys/csapatok_fk.sql
@./alter/foreign_keys/futamok2021_fk1.sql
@./alter/foreign_keys/futamok2021_fk2.sql
@./alter/foreign_keys/futamok2021_fk3.sql
@./alter/foreign_keys/futamok2022_fk1.sql
@./alter/foreign_keys/futamok2022_fk2.sql
@./alter/foreign_keys/futamok2022_fk3.sql
@./alter/foreign_keys/pilotak2021_fk1.sql
@./alter/foreign_keys/pilotak2021_fk2.sql
@./alter/foreign_keys/pilotak2022_fk1.sql
@./alter/foreign_keys/pilotak2022_fk2.sql

-- Triggerek
@./triggers/csapatok_seq_trg.trg
@./triggers/motorgyartok_seq_trg.trg
@./triggers/pilotak_osszes_seq_trg.trg
@./triggers/futamok_osszes_seq_trg.trg

PROMPT Done.

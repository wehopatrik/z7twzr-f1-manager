PROMPT Installing DB...

-- Szekvenciák létrehozása
@./sequences/table_id_sequences/motorgyarto_seq.sql
@./sequences/table_id_sequences/csapat_seq.sql
@./sequences/table_id_sequences/pilota_osszes_seq.sql
@./sequences/table_id_sequences/pilota_csapat_seq.sql
@./sequences/table_id_sequences/futam_osszes_seq.sql
@./sequences/table_id_sequences/futam_ev_seq.sql
@./sequences/error_sequence/hiba_log_seq.sql

-- Táblák létrehozása
@./table_creating/main_tables/table_motorgyarto.sql
@./table_creating/main_tables/table_csapat.sql
@./table_creating/main_tables/table_pilota_osszes.sql
@./table_creating/main_tables/table_pilota_csapat.sql
@./table_creating/main_tables/table_futam_osszes.sql
@./table_creating/main_tables/table_futam_ev.sql
@./table_creating/history_tables/table_motorgyarto_h.sql
@./table_creating/history_tables/table_csapat_h.sql
@./table_creating/history_tables/table_pilota_osszes_h.sql
@./table_creating/history_tables/table_pilota_csapat_h.sql
@./table_creating/history_tables/table_futam_osszes_h.sql
@./table_creating/history_tables/table_futam_ev_h.sql
@./table_creating/error_table/table_hiba_log.sql

-- Elsõdleges kulcsok
@./alter/primary_keys/motorgyarto_pk.sql
@./alter/primary_keys/csapat_pk.sql
@./alter/primary_keys/pilota_osszes_pk.sql
@./alter/primary_keys/pilota_csapat_pk.sql
@./alter/primary_keys/futam_osszes_pk.sql
@./alter/primary_keys/futam_ev_pk.sql

-- Típusok installálása
@./types/ty_futam_adatok.typ
@./types/ty_futam_adatok_l.tps
@./types/ty_hanyszor_nyert.typ
@./types/ty_hanyszor_nyert_l.tps

-- Packagek
@./packages/pkg_hiba_log.pck
@./packages/pkg_kivetelek.pck
/*@./packages/pkg_futam_adatok.pck
@./packages/pkg_uj_elem.pck
@./packages/pkg_torles_futam.pck
@./packages/pkg_csere_futam.pck*/

-- Függvények
@./functions/func_hany_kor_gumi.fnc
@./functions/func_hanyszor_nyert.fnc

-- Nézetek
@./views/vw_csapat_motor.sql
@./views/vw_futamok_2021.sql
@./views/vw_pilota_csapat_2021.sql
@./views/vw_pilota_csapat_2022.sql


-- Séma újrafordítása
BEGIN
  dbms_utility.compile_schema(schema => 'F1_MANAGER');
END;
/

-- Triggerek
@./triggers/sequence_triggers/csapat_seq_trg.trg
@./triggers/sequence_triggers/motorgyarto_seq_trg.trg
@./triggers/sequence_triggers/pilota_osszes_seq_trg.trg
@./triggers/sequence_triggers/pilota_csapat_seq_trg.trg
@./triggers/sequence_triggers/futam_osszes_seq_trg.trg
@./triggers/sequence_triggers/futam_ev_seq_trg.trg
@./triggers/main_triggers/motorgyarto_trg.trg
@./triggers/main_triggers/csapat_trg.trg
@./triggers/main_triggers/pilota_osszes_trg.trg
@./triggers/main_triggers/pilota_csapat_trg.trg
@./triggers/main_triggers/futam_osszes_trg.trg
@./triggers/main_triggers/futam_ev_trg.trg
@./triggers/history_triggers/motorgyarto_h_trg.trg
@./triggers/history_triggers/csapat_h_trg.trg
@./triggers/history_triggers/pilota_osszes_h_trg.trg
@./triggers/history_triggers/pilota_csapat_h_trg.trg
@./triggers/history_triggers/futam_osszes_h_trg.trg
@./triggers/history_triggers/futam_ev_h_trg.trg

-- Tábla feltöltések
@./table_loading/insert_into_motorgyarto.sql
@./table_loading/insert_into_csapat.sql
@./table_loading/insert_into_pilota_osszes.sql
@./table_loading/insert_into_pilota_csapat.sql
@./table_loading/insert_into_futam_osszes.sql
@./table_loading/insert_into_futam_ev.sql

-- Külsõ kulcsok
@./alter/foreign_keys/csapat_fk.sql
@./alter/foreign_keys/futam_ev_fk1.sql
@./alter/foreign_keys/futam_ev_fk2.sql
@./alter/foreign_keys/futam_ev_fk3.sql
@./alter/foreign_keys/pilota_csapat_fk1.sql
@./alter/foreign_keys/pilota_csapat_fk2.sql

PROMPT Done.

PROMPT Installing DB...

SET serveroutput ON
spool .\telepites.log

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

-- Külsõ kulcsok
@./alter/foreign_keys/csapat_fk.sql
@./alter/foreign_keys/futam_ev_fk1.sql
@./alter/foreign_keys/futam_ev_fk2.sql
@./alter/foreign_keys/futam_ev_fk3.sql
@./alter/foreign_keys/pilota_csapat_fk1.sql
@./alter/foreign_keys/pilota_csapat_fk2.sql

-- Ellenõrzö megszorítás
@./alter/check/pilota_szam_chk.sql

-- Típusok installálása
@./types/ty_futam_adatok.typ
@./types/ty_futam_adatok_l.tps
@./types/main_table_types/ty_motorgyarto.typ
@./types/main_table_types/ty_motorgyarto_l.tps
@./types/main_table_types/ty_csapat.typ
@./types/main_table_types/ty_csapat_l.tps
@./types/main_table_types/ty_pilota_csapat.typ
@./types/main_table_types/ty_pilota_csapat_l.tps
@./types/main_table_types/ty_pilota_osszes.typ
@./types/main_table_types/ty_pilota_osszes_l.tps
@./types/main_table_types/ty_futam_ev.typ
@./types/main_table_types/ty_futam_ev_l.tps
@./types/main_table_types/ty_futam_osszes.typ
@./types/main_table_types/ty_futam_osszes_l.tps

-- Packagek
@./packages/pkg_hiba_log.pck
@./packages/pkg_kivetelek.pck
@./packages/pkg_szezon_adatok.pck
@./packages/table_packages/pkg_motorgyarto.pck
@./packages/table_packages/pkg_csapat.pck
@./packages/table_packages/pkg_pilota_osszes.pck
@./packages/table_packages/pkg_pilota_csapat.pck
@./packages/table_packages/pkg_futam_osszes.pck
@./packages/table_packages/pkg_futam_ev.pck

-- Függvények
@./functions/func_hany_kor_gumi.fnc
@./functions/func_hanyszor_nyert.fnc

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

-- Nézetek
@./views/vw_csapat_motor.sql
@./views/vw_futamok_2021.sql
@./views/vw_futamok_2022.sql
@./views/vw_pilota_csapat_2021.sql
@./views/vw_pilota_csapat_2022.sql

-- Tábla feltöltések
@./table_loading/insert_into_motorgyarto.sql
@./table_loading/insert_into_csapat.sql
@./table_loading/insert_into_pilota_osszes.sql
@./table_loading/insert_into_pilota_csapat.sql
@./table_loading/insert_into_futam_osszes.sql
@./table_loading/insert_into_futam_ev.sql

-- Séma újrafordítása
BEGIN
  dbms_utility.compile_schema(schema => 'F1_MANAGER');
END;
/

spool off

PROMPT Done.

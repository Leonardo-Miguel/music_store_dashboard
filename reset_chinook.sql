-- ============================================================================
--  reset_chinook.sql
--  Remove TODAS as tabelas do Chinook (com CASCADE) para permitir recarregar
--  o script do zero. Use no Query Tool do pgAdmin, conectado ao banco "chinook".
--
--  ATENÇÃO: isso apaga os dados dessas 11 tabelas.
-- ============================================================================

DROP TABLE IF EXISTS playlist_track CASCADE;
DROP TABLE IF EXISTS invoice_line   CASCADE;
DROP TABLE IF EXISTS invoice        CASCADE;
DROP TABLE IF EXISTS track          CASCADE;
DROP TABLE IF EXISTS album          CASCADE;
DROP TABLE IF EXISTS artist         CASCADE;
DROP TABLE IF EXISTS customer       CASCADE;
DROP TABLE IF EXISTS employee       CASCADE;
DROP TABLE IF EXISTS genre          CASCADE;
DROP TABLE IF EXISTS media_type     CASCADE;
DROP TABLE IF EXISTS playlist       CASCADE;

-- Confirma que não sobrou nenhuma tabela do Chinook:
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

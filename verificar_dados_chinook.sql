-- ============================================================================
--  Verificação das contagens de dados do banco Chinook
--  Execute no Query Tool do pgAdmin, conectado ao banco "chinook".
--  Resultado esperado: todas as linhas com status = 'OK'.
-- ============================================================================

WITH esperado(tabela, qtd) AS (
    VALUES
        ('album', 347),
        ('artist', 275),
        ('customer', 59),
        ('employee', 8),
        ('genre', 25),
        ('invoice', 412),
        ('invoice_line', 2240),
        ('media_type', 5),
        ('playlist', 18),
        ('playlist_track', 8715),
        ('track', 3503)
),
real AS (
              SELECT 'album'          AS t, COUNT(*) AS n FROM album
    UNION ALL SELECT 'artist',            COUNT(*) FROM artist
    UNION ALL SELECT 'customer',          COUNT(*) FROM customer
    UNION ALL SELECT 'employee',          COUNT(*) FROM employee
    UNION ALL SELECT 'genre',             COUNT(*) FROM genre
    UNION ALL SELECT 'invoice',           COUNT(*) FROM invoice
    UNION ALL SELECT 'invoice_line',      COUNT(*) FROM invoice_line
    UNION ALL SELECT 'media_type',        COUNT(*) FROM media_type
    UNION ALL SELECT 'playlist',          COUNT(*) FROM playlist
    UNION ALL SELECT 'playlist_track',    COUNT(*) FROM playlist_track
    UNION ALL SELECT 'track',             COUNT(*) FROM track
)
SELECT
    e.tabela,
    e.qtd                                   AS esperado,
    r.n                                     AS no_banco,
    e.qtd - r.n                             AS faltando,
    CASE
        WHEN r.n = e.qtd THEN 'OK'
        WHEN r.n = 0     THEN 'VAZIA'
        ELSE 'PARCIAL'
    END                                     AS status
FROM esperado e
JOIN real r ON r.t = e.tabela
ORDER BY e.tabela;


-- ============================================================================
--  Extra: chaves estrangeiras "órfãs" (deve retornar 0 em todas)
-- ============================================================================
SELECT 'album.artist_id -> artist'                   AS relacionamento, COUNT(*) AS orfaos
    FROM album c LEFT JOIN artist p ON c.artist_id = p.artist_id
    WHERE c.artist_id IS NOT NULL AND p.artist_id IS NULL
UNION ALL
SELECT 'track.album_id -> album', COUNT(*)
    FROM track c LEFT JOIN album p ON c.album_id = p.album_id
    WHERE c.album_id IS NOT NULL AND p.album_id IS NULL
UNION ALL
SELECT 'track.genre_id -> genre', COUNT(*)
    FROM track c LEFT JOIN genre p ON c.genre_id = p.genre_id
    WHERE c.genre_id IS NOT NULL AND p.genre_id IS NULL
UNION ALL
SELECT 'track.media_type_id -> media_type', COUNT(*)
    FROM track c LEFT JOIN media_type p ON c.media_type_id = p.media_type_id
    WHERE c.media_type_id IS NOT NULL AND p.media_type_id IS NULL
UNION ALL
SELECT 'customer.support_rep_id -> employee', COUNT(*)
    FROM customer c LEFT JOIN employee p ON c.support_rep_id = p.employee_id
    WHERE c.support_rep_id IS NOT NULL AND p.employee_id IS NULL
UNION ALL
SELECT 'invoice.customer_id -> customer', COUNT(*)
    FROM invoice c LEFT JOIN customer p ON c.customer_id = p.customer_id
    WHERE c.customer_id IS NOT NULL AND p.customer_id IS NULL
UNION ALL
SELECT 'invoice_line.invoice_id -> invoice', COUNT(*)
    FROM invoice_line c LEFT JOIN invoice p ON c.invoice_id = p.invoice_id
    WHERE c.invoice_id IS NOT NULL AND p.invoice_id IS NULL
UNION ALL
SELECT 'invoice_line.track_id -> track', COUNT(*)
    FROM invoice_line c LEFT JOIN track p ON c.track_id = p.track_id
    WHERE c.track_id IS NOT NULL AND p.track_id IS NULL
UNION ALL
SELECT 'playlist_track.playlist_id -> playlist', COUNT(*)
    FROM playlist_track c LEFT JOIN playlist p ON c.playlist_id = p.playlist_id
    WHERE c.playlist_id IS NOT NULL AND p.playlist_id IS NULL
UNION ALL
SELECT 'playlist_track.track_id -> track', COUNT(*)
    FROM playlist_track c LEFT JOIN track p ON c.track_id = p.track_id
    WHERE c.track_id IS NOT NULL AND p.track_id IS NULL;

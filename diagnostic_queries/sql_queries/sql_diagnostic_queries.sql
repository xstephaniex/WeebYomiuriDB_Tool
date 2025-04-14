-- GET TABLES DATA
-- SELECT * FROM tags;
-- SELECT * FROM genre;
-- SELECT * FROM anime_manga_type;
-- SELECT * FROM anime_manga_status;
SELECT * FROM anime_language_options;

-- TEST QUERY PERFORMANCE

-- EXPLAIN ANALYZE SELECT * FROM tags;

--TEST ENUM TYPES

-- SELECT enum_range(NULL::premiered_season_year_enum);
-- SELECT enumlabel FROM pg_enum
-- JOIN pg_type ON pg_enum.enumtypid = pg_type.oid
-- WHERE pg_type.typname = 'anime_manga_type_enum';


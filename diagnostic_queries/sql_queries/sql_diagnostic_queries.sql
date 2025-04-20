-- GET TABLES DATA
-- SELECT * FROM tags;
-- SELECT * FROM genre;
-- SELECT * FROM anime_manga_type;
-- SELECT * FROM anime_manga_status;
-- SELECT * FROM anime_language_options;
-- SELECT * FROM genre;
-- SELECT * FROM admin;
-- SELECT * FROM premiered_season_year;
-- SELECT * FROM anime;
-- SELECT * FROM language_option;
-- SELECT * FROM manga;
SELECT * FROM anime_manga_origin_country


-- RESET INDEX TO 0 AFTER DELETING ENTRIES

-- DELETE FROM manga;

-- SELECT setval(pg_get_serial_sequence('manga', 'mangaid')
--             , COALESCE(max(mangaid) + 1, 1)
--             , false)
-- FROM manga;

-- TEST QUERY PERFORMANCE

-- EXPLAIN ANALYZE SELECT * FROM tags;

-- TEST ENUM TYPES

-- SELECT enum_range(NULL::premiered_season_year_enum);
-- SELECT enumlabel FROM pg_enum
-- JOIN pg_type ON pg_enum.enumtypid = pg_type.oid
-- WHERE pg_type.typname = 'anime_manga_type_enum';

-- TEST QUERY PERFORMANCE

-- EXPLAIN ANALYZE SELECT * FROM tags;

-- TEST ENUM TYPES

-- SELECT enum_range(NULL::premiered_season_year_enum);
-- SELECT enumlabel FROM pg_enum
-- JOIN pg_type ON pg_enum.enumtypid = pg_type.oid
-- WHERE pg_type.typname = 'anime_manga_type_enum';

-- INSERT TWO LETTER CODES ORIGIN COUNTRY

-- INSERT INTO  anime_manga_origin_country(country_code) VALUES('AF')

-- INSERT INTO  anime_manga_origin_country(country_code) VALUES ('AL'), ('DZ'), ('AS'), 
-- ('AD'), ('AO'), ('AI'), ('AQ'), ('AG'), ('AR'), ('AM'),
-- ('AW'), ('AU'), ('AT'), ('AZ'), ('BS'), ('BH'), ('BD'), ('BB'), ('BY'), ('BE'),
-- ('BZ'), ('BJ'), ('BM'), ('BT'), ('BO'), ('BQ'), ('BA'), ('BW'), ('BV'), ('BR'),
-- ('IO'), ('BN'), ('BG'), ('BF'), ('BI'), ('KH'), ('CM'), ('CA'), ('CV'), ('KY'),
-- ('CF'), ('TD'), ('CL'), ('CN'), ('CX'), ('CC'), ('CO'), ('KM'), ('CG'), ('CD'),
-- ('CK'), ('CR'), ('HR'), ('CU'), ('CW'), ('CY'), ('CZ'), ('CI'), ('DK'), ('DJ'),
-- ('DM'), ('DO'), ('EC'), ('EG'), ('SV'), ('GQ'), ('ER'), ('EE'), ('SZ'), ('ET'),
-- ('FK'), ('FO'), ('FJ'), ('FI'), ('FR'), ('GF'), ('PF'), ('TF'), ('GA'), ('GM'),
-- ('GE'), ('DE'), ('GH'), ('GI'), ('GR'), ('GL'), ('GD'), ('GP'), ('GU'), ('GT'),
-- ('GG'), ('GN'), ('GW'), ('GY'), ('HT'), ('HM'), ('VA'), ('HN'), ('HK'), ('HU'),
-- ('IS'), ('IN'), ('ID'), ('IR'), ('IQ'), ('IE'), ('IM'), ('IL'), ('IT'), ('JM'),
-- ('JP'), ('JE'), ('JO'), ('KZ'), ('KE'), ('KI'), ('KP'), ('KR'), ('KW'), ('KG'),
-- ('LA'), ('LV'), ('LB'), ('LS'), ('LR'), ('LY'), ('LI'), ('LT'), ('LU'), ('MO'),
-- ('MK'), ('MG'), ('MW'), ('MY'), ('MV'), ('ML'), ('MT'), ('MH'), ('MQ'), ('MR'),
-- ('MU'), ('YT'), ('MX'), ('FM'), ('MD'), ('MC'), ('MN'), ('ME'), ('MS'), ('MA'),
-- ('MZ'), ('MM'), ('NA'), ('NR'), ('NP'), ('NL'), ('NC'), ('NZ'), ('NI'), ('NE'),
-- ('NG'), ('NU'), ('NF'), ('MP'), ('NO'), ('OM'), ('PK'), ('PW'), ('PS'), ('PA'),
-- ('PG'), ('PY'), ('PE'), ('PH'), ('PN'), ('PL'), ('PT'), ('PR'), ('QA'), ('RO'),
-- ('RU'), ('RW'), ('RE'), ('BL'), ('SH'), ('KN'), ('LC'), ('MF'), ('PM'), ('VC'),
-- ('WS'), ('SM'), ('ST'), ('SA'), ('SN'), ('RS'), ('SC'), ('SL'), ('SG'), ('SX'),
-- ('SK'), ('SI'), ('SB'), ('SO'), ('ZA'), ('GS'), ('SS'), ('ES'), ('LK'), ('SD'),
-- ('SR'), ('SJ'), ('SE'), ('CH'), ('SY'), ('TW'), ('TJ'), ('TZ'), ('TH'), ('TL'),
-- ('TG'), ('TK'), ('TO'), ('TT'), ('TN'), ('TR'), ('TM'), ('TC'), ('TV'), ('UG'),
-- ('UA'), ('AE'), ('GB'), ('US'), ('UM'), ('UY'), ('UZ'), ('VU'), ('VE'), ('VN'),
-- ('VG'), ('VI'), ('WF'), ('EH'), ('YE'), ('ZM'), ('ZW'), ('AX')


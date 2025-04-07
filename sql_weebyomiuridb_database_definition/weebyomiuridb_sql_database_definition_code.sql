CREATE TABLE tags (
    tagID SERIAL PRIMARY KEY,
    tag_name VARCHAR(40) NOT NULL
);

CREATE TABLE manga_tag (
    mangatagID SERIAL PRIMARY KEY,   -- Unique identifier for the manga_tag entry
    mangaID INT NOT NULL,    -- Foreign key reference to the manga
    tagID INT NOT NULL,      -- Foreign key reference to the tag
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE,  -- Reference to manga table
    FOREIGN KEY (tagID) REFERENCES tags(tagID) ON DELETE CASCADE  -- Reference to tags table
);

CREATE TABLE genre (
    genreID SERIAL PRIMARY KEY,
    genre_name VARCHAR(40) NOT NULL
);


-- confused the tag table with genre so had to alter characters
ALTER TABLE tags
    ALTER COLUMN tag_name TYPE VARCHAR(100);

CREATE TABLE character (
    characterID SERIAL PRIMARY KEY,
    character_name VARCHAR(100) NOT NULL,
    character_genre CHAR(1) NOT NULL,
    role VARCHAR(50),
    character_synopsis TEXT,
    personality VARCHAR(255),
    character_image VARCHAR(255)
    CONSTRAINT CHK_GENDER  CHECK ((character_genre = 'F') OR (character_genre = 'M'))
);

CREATE TABLE voice_actor (
    voiceactorID SERIAL PRIMARY KEY,
    characterID INT NOT NULL,
    voice_actor_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (characterID) REFERENCES character(characterID) ON DELETE CASCADE
);

-- create the ENUM type for anime or manga type labels
CREATE TYPE anime_manga_type_enum AS ENUM (
    'Artbook', 'Art Work','Doujinshi', 'Drama CD', 'Filipino', 'Indonesian', 'Manga', 'Manhwa', 'Manhua',
    'Novel', 'Front Page', 'Fan Art', 'OEL', 'Thai', 'Vietnamese', 'Malaysian', 'Nordic', 'French', 'Spanish', 'TV',
    'Movie', 'OVA', 'Special', 'ONA', 'music', 'CM', 'PV', 'AMV', 'TV Special'
);

CREATE TABLE anime_manga_type (
    animemangatypeID SERIAL PRIMARY KEY,
    type_label anime_manga_type_enum NOT NULL
);

-- create the ENUM type for anime manga status

CREATE TYPE animemangastatus AS ENUM (
    'COMPLETED','ONGOING','UPCOMING','UNKNOWN','HIATUS','CANCELLED','POSTPONED','CURRENTLY AIRING','SEASONAL'
);

-- change name for consistency

ALTER TYPE animemangastatus RENAME TO anime_manga_status_enum;

CREATE TABLE animemangastatus_table (
    animemangastatusID SERIAL PRIMARY KEY,  -- Automatically generates unique IDs
    status_label anime_manga_status_enum NOT NULL        -- Enum type column
);

ALTER TABLE animemangastatus_table RENAME TO anime_manga_status;
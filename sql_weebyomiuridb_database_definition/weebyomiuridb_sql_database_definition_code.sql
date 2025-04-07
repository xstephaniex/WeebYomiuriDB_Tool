CREATE TABLE tags (
    tagID SERIAL PRIMARY KEY,
    tag_name VARCHAR(40) NOT NULL
);

CREATE TABLE manga_tag (
    mangatagID SERIAL PRIMARY KEY,  
    mangaID INT NOT NULL,    
    tagID INT NOT NULL,    
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE, 
    FOREIGN KEY (tagID) REFERENCES tags(tagID) ON DELETE CASCADE 
);

CREATE TABLE genre (
    genreID SERIAL PRIMARY KEY,
    genre_name VARCHAR(40) NOT NULL
);


--confused the tag table with genre so had to alter characters
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

--create the ENUM type for anime or manga type labels
CREATE TYPE anime_manga_type_enum AS ENUM (
    'Artbook', 'Art Work','Doujinshi', 'Drama CD', 'Filipino', 'Indonesian', 'Manga', 'Manhwa', 'Manhua',
    'Novel', 'Front Page', 'Fan Art', 'OEL', 'Thai', 'Vietnamese', 'Malaysian', 'Nordic', 'French', 'Spanish', 'TV',
    'Movie', 'OVA', 'Special', 'ONA', 'music', 'CM', 'PV', 'AMV', 'TV Special'
);

CREATE TABLE anime_manga_type (
    animemangatypeID SERIAL PRIMARY KEY,
    type_label anime_manga_type_enum NOT NULL
);

--create the ENUM type for anime manga status
CREATE TYPE animemangastatus AS ENUM (
    'COMPLETED','ONGOING','UPCOMING','UNKNOWN','HIATUS','CANCELLED','POSTPONED','CURRENTLY AIRING','SEASONAL'
);

--change name for consistency
ALTER TYPE animemangastatus RENAME TO anime_manga_status_enum;

CREATE TABLE animemangastatus_table (
    animemangastatusID SERIAL PRIMARY KEY, 
    status_label anime_manga_status_enum NOT NULL   
);

ALTER TABLE animemangastatus_table RENAME TO anime_manga_status;

CREATE TABLE anime_manga_origin_country (
    animemangaorigincountryID SERIAL PRIMARY KEY, 
    --2-letter country code (ISO 3166-1 standard)
    country_code CHAR(2) NOT NULL          
);

CREATE TABLE anime_language_options (
    languageoptionsID SERIAL PRIMARY KEY,
    --language option label (e.g., "Japanese", "English", etc.)   
    language_label VARCHAR(100) NOT NULL     
);

--need to rename the PK constraint so it's consistent to diagram
ALTER TABLE anime_language_options RENAME COLUMN languageoptionsid TO animelanguageoptionsID;

CREATE TYPE premiered_season_year_enum AS ENUM (
    'WINTER','SPRING','SUMMER','FALL'
);

CREATE TABLE premiered_season_year (
    premieredseasonyearID SERIAL PRIMARY KEY,  
    season premiered_season_year_enum NOT NULL,       
    year INT NOT NULL                  
);

CREATE TABLE anime (
    animeID SERIAL PRIMARY KEY,                       
    english_title VARCHAR(150),                       
    japanese_title VARCHAR(150),                      
    anime_synopsis TEXT,                                                        
    broadcast_date_time VARCHAR(150),                     
    release_date DATE,                               
    end_date DATE,                                     
    related_anime VARCHAR(100)[3],                     
    seasons INT,                                      
    episodes INT,                                      
    sources_anime_analysis VARCHAR(255),                       
    sources_anime_stream_services VARCHAR(255),              
    anime_image VARCHAR(255),                         
    animemangatypeID INT,                              
    animemangastatusID INT,                            
    animelanguageoptionsID INT,                        
    animemangaorigincountryID INT,
    premieredseasonyearID INT,                     
    FOREIGN KEY (animemangatypeID) REFERENCES anime_manga_type(animemangatypeID) ON DELETE CASCADE,  
    FOREIGN KEY (animemangastatusID) REFERENCES anime_manga_status(animemangastatusID) ON DELETE CASCADE,  
    FOREIGN KEY (animelanguageoptionsID) REFERENCES anime_language_options(animelanguageoptionsID) ON DELETE CASCADE, 
    FOREIGN KEY (animemangaorigincountryID) REFERENCES anime_manga_origin_country(animemangaorigincountryID) ON DELETE CASCADE,
    FOREIGN KEY (premieredseasonyearID) REFERENCES premiered_season_year(premieredseasonyearID) ON DELETE CASCADE 
);
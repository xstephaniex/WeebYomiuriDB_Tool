--WeebYOMIURIDB--
--DEVELOPER: VARGAS VILLARINI STEPHANIE--

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

-------- NEED TO FIX --- 'WEBCOMICS' 'REBOOT' 'REMAKE' 'SPECIALS' 'ANTHOLOGY'

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

-- Need to fix constraint should be on delete set null
ALTER TABLE anime
ALTER COLUMN animemangatypeID DROP NOT NULL,
ALTER COLUMN animemangastatusID DROP NOT NULL,
ALTER COLUMN animelanguageoptionsID DROP NOT NULL,
ALTER COLUMN animemangaorigincountryID DROP NOT NULL,
ALTER COLUMN premieredseasonyearID DROP NOT NULL;

ALTER TABLE anime DROP CONSTRAINT anime_animemangatypeID_fkey;
ALTER TABLE anime DROP CONSTRAINT anime_animemangastatusID_fkey;
ALTER TABLE anime DROP CONSTRAINT anime_animelanguageoptionsID_fkey;
ALTER TABLE anime DROP CONSTRAINT anime_animemangaorigincountryID_fkey;
ALTER TABLE anime DROP CONSTRAINT anime_premieredseasonyearID_fkey;

ALTER TABLE anime
ADD FOREIGN KEY (animemangatypeID) REFERENCES anime_manga_type(animemangatypeID) ON DELETE SET NULL;
ALTER TABLE anime
ADD FOREIGN KEY (animemangastatusID) REFERENCES anime_manga_status(animemangastatusID) ON DELETE SET NULL;
ALTER TABLE anime
ADD FOREIGN KEY (animelanguageoptionsID) REFERENCES anime_language_options(animelanguageoptionsID) ON DELETE SET NULL;
ALTER TABLE anime
ADD FOREIGN KEY (animemangaorigincountryID) REFERENCES anime_manga_origin_country(animemangaorigincountryID) ON DELETE SET NULL;
ALTER TABLE anime
ADD FOREIGN KEY (premieredseasonyearID) REFERENCES premiered_season_year(premieredseasonyearID) ON DELETE SET NULL;

CREATE TABLE season (
    seasonID SERIAL PRIMARY KEY,
    animeID INTEGER NOT NULL,
    season_name VARCHAR(100) NOT NULL,
    number_of_episodes INTEGER,

    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE
);

CREATE TABLE episode (
    episodeID SERIAL PRIMARY KEY,
    seasonID INTEGER NOT NULL,
    arc_name VARCHAR(100),  
    episode_number INTEGER NOT NULL,
    episode_title VARCHAR(255) NOT NULL,
    episode_synopsis TEXT,
    duration INTERVAL,
    airing DATE,

    FOREIGN KEY (seasonID) REFERENCES season(seasonID) ON DELETE CASCADE
);

CREATE TABLE weebyomiuri_user (
    userID SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    security_token TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE release_schedule (
    releaseScheduleID SERIAL PRIMARY KEY,
    release_type VARCHAR(100) NOT NULL
);

CREATE TABLE user_watchlist (
    userwatchlistID SERIAL PRIMARY KEY,
    userID INTEGER NOT NULL,
    animeID INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,

    FOREIGN KEY (userID) REFERENCES weebyomiuri_user(userID) ON DELETE CASCADE,
    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE
);

CREATE TABLE admin (
    adminID SERIAL PRIMARY KEY,
    admin_level VARCHAR(50) NOT NULL,
    permissions TEXT[] NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE manga (
    mangaID SERIAL PRIMARY KEY,
    english_title VARCHAR(150),
    japanese_title VARCHAR(150),
    manga_synopsis TEXT,
    volumes INTEGER,
    publish_start_date DATE,
    publish_end_date DATE,
    serialized BOOLEAN,
    manga_image VARCHAR(255),
    sources_manga_analysis VARCHAR(255),
    sources_manga_read VARCHAR(255),
    releasescheduleID INT,
    animemangatypeID INT,
    animemangastatusID INT,
    animemangaorigincountryID INT,
    FOREIGN KEY (releasescheduleID)REFERENCES release_schedule(releaseScheduleID) ON DELETE SET NULL,
    FOREIGN KEY (animemangatypeID)REFERENCES  anime_manga_type(animemangatypeID) ON DELETE SET NULL,
    FOREIGN KEY (animemangastatusID) REFERENCES anime_manga_status(animemangastatusID) ON DELETE SET NULL,
    FOREIGN KEY (animemangaorigincountryID) REFERENCES anime_manga_origin_country(animemangaorigincountryID) ON DELETE SET NULL
);

CREATE TABLE user_readlist (
    readlistID SERIAL PRIMARY KEY,
    userID INTEGER NOT NULL,
    mangaID INTEGER NOT NULL,
    status_label VARCHAR(50) NOT NULL,
    FOREIGN KEY (userID) REFERENCES weebyomiuri_user(userID) ON DELETE CASCADE,
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE
);

CREATE TABLE anime_manga_association (
    animeID INTEGER NOT NULL,
    mangaID INTEGER NOT NULL,
    relationship_type VARCHAR(100) NOT NULL,

    PRIMARY KEY (animeID, mangaID),
    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE,
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE
);

CREATE TABLE database_activity_logs (
    activityLogsID SERIAL PRIMARY KEY,
    adminID INTEGER NOT NULL,
    operation_type VARCHAR(20) NOT NULL CHECK (operation_type IN ('add', 'update', 'delete')),
    entity_type VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (adminID) REFERENCES admin(adminID) ON DELETE SET NULL
);

CREATE TABLE anime_tag (
    animeID INTEGER NOT NULL,
    tagID INTEGER NOT NULL,

    PRIMARY KEY (animeID, tagID),

    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE,
    FOREIGN KEY (tagID) REFERENCES tags(tagID) ON DELETE CASCADE
);

CREATE TABLE manga_tags (
    mangaID INTEGER NOT NULL,
    tagID INTEGER NOT NULL,

    PRIMARY KEY (mangaID, tagID),

    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE,
    FOREIGN KEY (tagID) REFERENCES tags(tagID) ON DELETE CASCADE
);

CREATE TABLE anime_genre (
    animeID INTEGER NOT NULL,
    genreID INTEGER NOT NULL,

    PRIMARY KEY (animeID, genreID),

    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE,
    FOREIGN KEY (genreID) REFERENCES genre(genreID) ON DELETE CASCADE
);

CREATE TABLE manga_genre (
    mangaID INTEGER NOT NULL,
    genreID INTEGER NOT NULL,

    PRIMARY KEY (mangaID, genreID),

    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE,
    FOREIGN KEY (genreID) REFERENCES genre(genreID) ON DELETE CASCADE
);

CREATE TABLE anime_character (
    animeID INTEGER NOT NULL,
    characterID INTEGER NOT NULL,

    PRIMARY KEY (animeID, characterID),

    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE,
    FOREIGN KEY (characterID) REFERENCES character(characterID) ON DELETE CASCADE
);

CREATE TABLE manga_character (
    mangaID INTEGER NOT NULL,
    characterID INTEGER NOT NULL,

    PRIMARY KEY (mangaID, characterID),

    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE,
    FOREIGN KEY (characterID) REFERENCES character(characterID) ON DELETE CASCADE
);

CREATE TABLE anime_contributor_type (
    animecontributortypeID SERIAL PRIMARY KEY,
    animeID INTEGER NOT NULL,
    anime_contributor_name VARCHAR(100) NOT NULL,
    type_label VARCHAR(50) NOT NULL,
    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE SET NULL
);

CREATE TABLE manga_contributor_type (
    mangacontributortypeID SERIAL PRIMARY KEY,
    mangaID INTEGER NOT NULL,
    manga_contributor_name VARCHAR(100) NOT NULL,
    type_label VARCHAR(50) NOT NULL,
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE SET NULL
);

CREATE TABLE chapter (
    chapterID SERIAL PRIMARY KEY,
    mangaID INTEGER NOT NULL,
    volume_number INTEGER,
    chapter_number INTEGER NOT NULL,
    chapter_title VARCHAR(255),
    chapter_synopsis TEXT,

    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE
);

CREATE TABLE song_type (
    songtypeID SERIAL PRIMARY KEY,
    type_label VARCHAR(50) NOT NULL,
    version_label VARCHAR(50)
);

CREATE TABLE song (
    songID SERIAL PRIMARY KEY,
    animeID INT,
    songtypeID INT,
    song_name VARCHAR(150) NOT NULL,
    song_number INTEGER,
    song_duration INTERVAL,
    performer_composer VARCHAR(150),
    has_lyrics BOOLEAN DEFAULT FALSE,
    song_source_url VARCHAR(255),

    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE SET NULL,
    FOREIGN KEY (songtypeID) REFERENCES song_type(songtypeID) ON DELETE SET NULL
);

CREATE TABLE anime_rating_review (
    animeratingID SERIAL PRIMARY KEY,
    userID INTEGER NOT NULL,
    animeID INTEGER NOT NULL,
    rating_score INTEGER NOT NULL CHECK (rating_score BETWEEN 0 AND 10),
    rating_date DATE DEFAULT CURRENT_DATE,
    review TEXT,


    FOREIGN KEY (userID) REFERENCES weebyomiuri_user(userID) ON DELETE CASCADE,
    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE
);

CREATE TABLE manga_rating_review (
    mangaratingID SERIAL PRIMARY KEY,
    userID INTEGER NOT NULL,
    mangaID INTEGER NOT NULL,
    rating_score INTEGER NOT NULL CHECK (rating_score BETWEEN 0 AND 10),
    rating_date DATE DEFAULT CURRENT_DATE,
    review TEXT,


    FOREIGN KEY (userID) REFERENCES weebyomiuri_user(userID) ON DELETE CASCADE,
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE
);

CREATE TABLE anime_revision_history_table (
    animerevisionhistorytableID SERIAL PRIMARY KEY,
    userID INTEGER NOT NULL,
    animeID INTEGER NOT NULL,
    updated_field VARCHAR(100) NOT NULL,
    change_description VARCHAR(255),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_value VARCHAR(255),
    new_value VARCHAR(255),

    FOREIGN KEY (userID) REFERENCES weebyomiuri_user(userID) ON DELETE CASCADE,
    FOREIGN KEY (animeID) REFERENCES anime(animeID) ON DELETE CASCADE

);


CREATE TABLE manga_revision_history_table (
    mangarevisionhistorytableID SERIAL PRIMARY KEY,
    userID INTEGER NOT NULL,
    mangaID INTEGER NOT NULL,
    updated_field VARCHAR(100) NOT NULL,
    change_description VARCHAR(255),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_value VARCHAR(255),
    new_value VARCHAR(255),

    FOREIGN KEY (userID) REFERENCES weebyomiuri_user(userID) ON DELETE CASCADE,
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID) ON DELETE CASCADE

);
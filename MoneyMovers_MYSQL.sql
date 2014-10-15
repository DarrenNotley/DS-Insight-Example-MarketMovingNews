#use darrendb2;
#DATASIFT ENRICHMENT TABLE DEFINITIONS
#Demographics
CREATE TABLE demographic (
  interaction_id VARCHAR(64) PRIMARY KEY,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL,
  first_language VARCHAR(64) DEFAULT NULL
  gender VARCHAR(64) DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX demographic_interaction_id_idx ON demographic (interaction_id);
CREATE INDEX demographic_interaction_type_idx ON demographic (interaction_type);
CREATE INDEX demographic_created_at_idx ON demographic (created_at);

#Interaction
CREATE TABLE IF NOT EXISTS interaction (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL,
  created_at_unix INTEGER NOT NULL,
  username VARCHAR(255) DEFAULT NULL,
  is_retweet SMALLINT DEFAULT NULL,
  twitter_lang VARCHAR(50) DEFAULT NULL,
  content TEXT DEFAULT NULL,
  first_tag VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (interaction_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
#COLLATE = utf8_general_ci;
COLLATE = utf8_bin;
CREATE INDEX interaction_interaction_type_idx ON interaction (interaction_type);
CREATE INDEX interaction_created_at_idx ON interaction (created_at);

CREATE TABLE IF NOT EXISTS raw (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  subscription_id VARCHAR(64) NOT NULL,
  csdl_hash VARCHAR(64) NOT NULL,
  csdl_hash_type VARCHAR(50) NOT NULL,
  created_at timestamp NOT NULL,
  data TEXT NOT NULL,
  PRIMARY KEY (interaction_id, subscription_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX raw_interaction_id_idx ON raw (interaction_id);
CREATE INDEX raw_interaction_type_idx ON raw (interaction_type);
CREATE INDEX raw_created_at_idx ON raw (created_at);

CREATE TABLE IF NOT EXISTS hashtags (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL,
  hashtag VARCHAR(255) NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX hashtags_interaction_id_idx ON hashtags (interaction_id);
CREATE INDEX hashtags_interaction_type_idx ON hashtags (interaction_type);
CREATE INDEX hashtags_created_at_idx ON hashtags (created_at);

CREATE TABLE IF NOT EXISTS mentions (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL,
  mention VARCHAR(255) NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX mentions_interaction_id_idx ON mentions (interaction_id);
CREATE INDEX mentions_interaction_type_idx ON mentions (interaction_type);
CREATE INDEX mentions_created_at_idx ON mentions (created_at);

#Klout
CREATE TABLE IF NOT EXISTS klout (
  interaction_id VARCHAR(64) PRIMARY KEY,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME DEFAULT NULL,
  amplification INTEGER DEFAULT NULL,
  class TEXT DEFAULT NULL,
  network DECIMAL DEFAULT NULL,
  score DECIMAL DEFAULT NULL,
  slope DECIMAL DEFAULT NULL,
  true_reach INTEGER DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX klout_interaction_id_idx ON klout (interaction_id);
CREATE INDEX klout_interaction_type_idx ON klout (interaction_type);
CREATE INDEX klout_created_at_idx ON klout (created_at);


#Language 
CREATE TABLE IF NOT EXISTS language (
  interaction_id VARCHAR(64) PRIMARY KEY,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME DEFAULT NULL,
  language VARCHAR(5) DEFAULT NULL,
  confidence DECIMAL DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX language_interaction_id_idx ON language (interaction_id);
CREATE INDEX language_interaction_type_idx ON language (interaction_type);
CREATE INDEX language_created_at_idx ON language (created_at);
CREATE INDEX language_language_idx ON language (language);


#Links 
CREATE TABLE IF NOT EXISTS links (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT NULL,
  url VARCHAR(255) DEFAULT NULL,
  title VARCHAR(255) DEFAULT NULL,
  domain VARCHAR(255) DEFAULT NULL,
  normalized_url VARCHAR(255) DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX links_interaction_id_idx ON links (interaction_id);
CREATE INDEX links_interaction_type_idx ON links (interaction_type);
CREATE INDEX links_created_at_idx ON links (created_at);


CREATE TABLE IF NOT EXISTS links_meta (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT NULL,
  charset VARCHAR(50) DEFAULT NULL,
  content_type VARCHAR(50) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  language VARCHAR(50) DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX links_meta_interaction_id_idx ON links_meta (interaction_id);
CREATE INDEX links_meta_interaction_type_idx ON links_meta (interaction_type);
CREATE INDEX links_meta_created_at_idx ON links_meta (created_at);

#Salience 
CREATE TABLE IF NOT EXISTS salience_content_entities (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME NOT NULL,
  name TEXT DEFAULT NULL,
  entity_type TEXT DEFAULT NULL,
  label FLOAT DEFAULT NULL,
  about FLOAT DEFAULT NULL,
  sentiment FLOAT DEFAULT NULL,
  confidence FLOAT DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX salience_content_entities_interaction_id_idx ON salience_content_entities (interaction_id);
CREATE INDEX salience_content_entities_interaction_type_idx ON salience_content_entities (interaction_type);
CREATE INDEX salience_content_entities_created_at_idx ON salience_content_entities (created_at);

CREATE TABLE IF NOT EXISTS salience_content_topics (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT NULL,
  name TEXT DEFAULT NULL,
  hits FLOAT DEFAULT NULL,
  score FLOAT DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX salience_content_topics_interaction_id_idx ON salience_content_topics (interaction_id);
CREATE INDEX salience_content_topics_interaction_type_idx ON salience_content_topics (interaction_type);
CREATE INDEX salience_content_topics_created_at_idx ON salience_content_topics (created_at);


#Subscription 
CREATE TABLE subscription (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  interaction_created_at datetime NOT NULL,
  subscription_id VARCHAR(64) NOT NULL,
  subscription_hash VARCHAR(64) NOT NULL,
  subscription_hash_type VARCHAR(64) NOT NULL,
  subscription_inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (interaction_id, subscription_id),
  INDEX subscription_interaction_created_at_idx (interaction_created_at),
  INDEX subscription_subscription_id_idx (subscription_id),
  INDEX subscription_subscription_hash_idx (subscription_hash),
  INDEX subscription_subscription_hash_type_idx (subscription_hash_type)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

#Tags 
CREATE TABLE tag_labels (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  namespace VARCHAR(255) NOT NULL,
  label VARCHAR(255) NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX tag_labels_interaction_id_idx ON hashtags (interaction_id);
CREATE INDEX tag_labels_interaction_type_idx ON hashtags (interaction_type);
CREATE INDEX tag_labels_created_at_idx ON hashtags (created_at);

CREATE TABLE tag_scores (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  namespace VARCHAR(255) NOT NULL,
  score FLOAT NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX tag_scores_interaction_id_idx ON tag_scores (interaction_id);
CREATE INDEX tag_scores_interaction_type_idx ON tag_scores (interaction_type);
CREATE INDEX tag_scores_created_at_idx ON tag_scores (created_at);

#DDATA SOURCE TABLE DEFINITIONS
#Facebook 

CREATE TABLE facebook (
  interaction_id VARCHAR(64) PRIMARY KEY,
  created_at DATETIME NOT NULL,
  application VARCHAR(255) DEFAULT NULL,
  author_avatar VARCHAR(255) DEFAULT NULL,
  author_link VARCHAR(255) DEFAULT NULL,
  author_name VARCHAR(64) DEFAULT NULL,
  author_id VARCHAR(64) DEFAULT NULL,
  caption VARCHAR(255) DEFAULT NULL,
  icon VARCHAR(255) DEFAULT NULL,
  post_id VARCHAR(64) DEFAULT NULL,
  post_type VARCHAR(64) DEFAULT NULL,
  likes_count INT DEFAULT NULL,
  link VARCHAR(255) DEFAULT NULL,
  message VARCHAR(255) DEFAULT NULL,
  name VARCHAR(64) DEFAULT NULL,
  picture VARCHAR(255) DEFAULT NULL,
  source VARCHAR(64) DEFAULT NULL,
  story VARCHAR(255) DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX facebook_created_at_idx ON facebook (created_at);


#Twitter 
CREATE TABLE twitter (
  interaction_id VARCHAR(64) PRIMARY KEY,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  author_username VARCHAR(64) DEFAULT NULL,
  author_language VARCHAR(64) DEFAULT NULL,
  source VARCHAR(64) DEFAULT NULL,
  interaction_link VARCHAR(255) DEFAULT NULL,
  user_followers_count INT DEFAULT NULL,
  retweet_user_followers_count INT DEFAULT NULL,
  user_description TEXT DEFAULT NULL,
  retweet_user_description TEXT DEFAULT NULL,
  user_timezone VARCHAR(64) DEFAULT NULL,
  retweet_user_timezone VARCHAR(64) DEFAULT NULL,
  user_location VARCHAR(64) DEFAULT NULL,
  retweet_user_location VARCHAR(64) DEFAULT NULL,
  twitter_place_country VARCHAR(64) DEFAULT NULL,
  user_verified INT DEFAULT NULL,
  retweet_user_verified INT DEFAULT NULL,
  twitter_id VARCHAR(64) DEFAULT NULL,
  geo_latitude DOUBLE DEFAULT NULL,
  geo_longitude DOUBLE DEFAULT NULL,
  content TEXT DEFAULT NULL,
  twitter_lang VARCHAR(64) DEFAULT NULL,
  retweet_twitter_lang VARCHAR(64) DEFAULT NULL,
  is_retweet INTEGER DEFAULT NULL,
  twitter_retweeted_id VARCHAR(64) DEFAULT NULL,
  retweeted_author_screen_name VARCHAR(64) DEFAULT NULL,
  retweet_count INT DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX twitter_interaction_type_idx ON twitter (interaction_type);
CREATE INDEX twitter_created_at_idx ON twitter (created_at);

#LEXISNEXIS

CREATE TABLE lexisnexis (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  id VARCHAR(64) DEFAULT NULL,
  feedtype VARCHAR(255) DEFAULT NULL,
  language VARCHAR(64) DEFAULT NULL,
  load_date DATETIME DEFAULT NULL,
  docinfo_lnlni VARCHAR(255) DEFAULT NULL,
  source_name VARCHAR(64) DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX lexisnexis_interaction_id_idx ON lexisnexis (interaction_id);
CREATE INDEX lexisnexis_created_at_idx ON lexisnexis (created_at);
  

CREATE TABLE lexisnexis_indexing_company (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  term VARCHAR(255) DEFAULT NULL,
  score DOUBLE DEFAULT NULL,
  score_percentage INTEGER DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX lexisnexis_indexing_company_interaction_id_idx ON lexisnexis_indexing_company (interaction_id);
CREATE INDEX lexisnexis_indexing_company_created_at_idx ON lexisnexis_indexing_company (created_at);
  

CREATE TABLE lexisnexis_indexing_ticker (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  term VARCHAR(255) DEFAULT NULL,
  score DOUBLE DEFAULT NULL,
  score_percentage INTEGER DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX lexisnexis_indexing_ticker_interaction_id_idx ON lexisnexis_indexing_ticker (interaction_id);
CREATE INDEX lexisnexis_indexing_ticker_created_at_idx ON lexisnexis_indexing_ticker (created_at);
  

CREATE TABLE lexisnexis_indexing_city (
  interaction_id VARCHAR(64) NOT NULL,
  interaction_type VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL,
  term VARCHAR(255) DEFAULT NULL,
  score DOUBLE DEFAULT NULL,
  score_percentage INTEGER DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX lexisnexis_indexing_city_interaction_id_idx ON lexisnexis_indexing_city (interaction_id);
CREATE INDEX lexisnexis_indexing_city_created_at_idx ON lexisnexis_indexing_city (created_at);


#Facebook Pages
CREATE TABLE IF NOT EXISTS facebook_page (
  interaction_id VARCHAR(64) PRIMARY KEY,
  created_at DATETIME DEFAULT NULL,
  type VARCHAR(50) DEFAULT NULL,
  id VARCHAR(255) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
  link VARCHAR(255) DEFAULT NULL,
  icon VARCHAR(255) DEFAULT NULL,
  message TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  picture VARCHAR(255) DEFAULT NULL,
  like_count INTEGER DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX facebook_page_interaction_id_idx ON facebook_page (interaction_id);
CREATE INDEX facebook_page_created_at_idx ON facebook_page (created_at);


CREATE TABLE IF NOT EXISTS facebook_page_page (
  interaction_id VARCHAR(64) PRIMARY KEY,
  created_at DATETIME DEFAULT NULL,
  id VARCHAR(64) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
  username VARCHAR(50) DEFAULT NULL,
  category VARCHAR(50) DEFAULT NULL,
  link VARCHAR(255) DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX facebook_page_page_interaction_id_idx ON facebook_page_page (interaction_id);
CREATE INDEX facebook_page_page_created_at_idx ON facebook_page_page (created_at);


CREATE TABLE IF NOT EXISTS facebook_page_post (
  interaction_id VARCHAR(64) PRIMARY KEY,
  created_at DATETIME DEFAULT NULL,
  id VARCHAR(64) DEFAULT NULL,
  type VARCHAR(50) DEFAULT NULL,
  link VARCHAR(255) DEFAULT NULL,
  content TEXT DEFAULT NULL,
  post_created_at DATETIME DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
CREATE INDEX facebook_page_post_interaction_id_idx ON facebook_page_post (interaction_id);
CREATE INDEX facebook_page_post_created_at_idx ON facebook_page_post (created_at);







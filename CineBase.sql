CREATE DATABASE IF NOT EXISTS KinoDaten 
CHARACTER SET utf8
COLLATE utf8_unicode_ci;

USE KinoDaten;

CREATE TABLE IF NOT EXISTS t_Land (
    ID SERIAL PRIMARY KEY,
    Land VARCHAR(150) NOT NULL,
    UNIQUE uk_Land (Land)
);

CREATE TABLE IF NOT EXISTS t_Stadt (
    ID SERIAL PRIMARY KEY,
    PLZ VARCHAR(10) NOT NULL,
    Ort VARCHAR (250) NOT NULL,
    LandID BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_StadtLand FOREIGN KEY (LandID) REFERENCES t_Land(ID),
    UNIQUE uk_StadtPLZLand (PLZ, Ort, LandID)
);

CREATE TABLE IF NOT EXISTS t_Adresse (
    ID SERIAL PRIMARY KEY,
    Strasse VARCHAR(250) NOT NULL,
    StrNr SMALLINT UNSIGNED NOT NULL,
    StadtID BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_Adresse FOREIGN KEY (StadtID) REFERENCES t_Stadt(ID)
);

CREATE TABLE IF NOT EXISTS t_Kino(
    ID SERIAL PRIMARY KEY,
    Kinoname VARCHAR (100) NOT NULL,
    Strasse VARCHAR(250) NOT NULL,
    PLZ VARCHAR(10) NOT NULL,
    Ort VARCHAR (250) NOT NULL,
    Land VARCHAR(150) NOT NULL,
    TelNr VARCHAR(25) NOT NULL
    /*CONSTRAINT fk_KinoAdresse FOREIGN KEY (AdresseID) REFERENCES t_Adresse(ID),*/
    /*UNIQUE uk_CinemaAddress (AddressID)*/
);

CREATE TABLE IF NOT EXISTS t_Saal(
    ID SERIAL PRIMARY KEY,
    KinoID BIGINT UNSIGNED NOT NULL,
    Saalname VARCHAR(50) NOT NULL,
    CONSTRAINT fk_KinoSaal FOREIGN KEY (KinoID) REFERENCES t_Kino(ID),
    UNIQUE uk_Saal (Saalname, KinoID)
);

CREATE TABLE IF NOT EXISTS t_Platz(
    ID SERIAL PRIMARY KEY,
    SaalID BIGINT UNSIGNED NOT NULL,
    Reihe INT UNSIGNED NOT NULL,
    Sitz INT UNSIGNED NOT NULL,
    CONSTRAINT fk_SitzSaal FOREIGN KEY (SaalID) REFERENCES t_Saal(ID),
    UNIQUE uk_Sitz (Reihe, Sitz, SaalID)
);

CREATE TABLE IF NOT EXISTS t_Film (
    ID SERIAL PRIMARY KEY,
    Titel VARCHAR(150) NOT NULL,
    Beschreibung TEXT,
    Dauer DATETIME NOT NULL,
    Preis Decimal(3,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS t_FilmAuffuerung (
    ID SERIAL PRIMARY KEY,
    FilmID BIGINT UNSIGNED NOT NULL,
    SaalID BIGINT UNSIGNED NOT NULL,
    Uhrzeit DATETIME NOT NULL,
    CONSTRAINT fk_FilmAuff FOREIGN KEY (FilmID) REFERENCES t_Film(ID),
    CONSTRAINT fk_AuffSaal FOREIGN KEY (SaalID) REFERENCES t_Saal(ID),
    UNIQUE uk_FilmAuffuerung (FilmID, SaalID, Uhrzeit)
);

CREATE TABLE IF NOT EXISTS t_Kunde (
    ID SERIAL PRIMARY KEY,
    Benutzername VARCHAR (30) NOT NULL,
    Passwort VARCHAR(500) NOT NULL,
    Vorname VARCHAR (100) NOT NULL,
    Nachname VARCHAR (100) NOT NULL,
    AdresseID BIGINT UNSIGNED NOT NULL,
    MailAdresse VARCHAR(100) NOT NULL,
    CONSTRAINT fk_KundeAdresse FOREIGN KEY (AdresseID) REFERENCES t_Adresse(ID),
    UNIQUE uk_UserAddress (AdresseID),
    UNIQUE uk_Username (Benutzername),
    UNIQUE uk_MailAdresse (MailAdresse)
);

CREATE TABLE IF NOT EXISTS t_Typ (
    ID SERIAL PRIMARY KEY,
    Typ VARCHAR (30) NOT NULL
);

CREATE TABLE IF NOT EXISTS t_Angestellte (
    ID SERIAL PRIMARY KEY,
    Benutzername VARCHAR (30) NOT NULL,
    Passwort VARCHAR(500) NOT NULL,
    TypID BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_AngestelltenTyp FOREIGN KEY (TypID) REFERENCES t_Typ(ID)
);

CREATE TABLE IF NOT EXISTS t_Ticket (
    ID SERIAL PRIMARY KEY,
    AuffuerungID BIGINT UNSIGNED NOT NULL,
    PlatzID BIGINT UNSIGNED NOT NULL,
    Verkaufsdatum Date,
    KundeID BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_AuffTicket FOREIGN KEY (AuffuerungID) REFERENCES t_FilmAuffuerung(ID),
    CONSTRAINT fk_TicketPlatz FOREIGN KEY (PlatzID) REFERENCES t_Platz(ID),
    CONSTRAINT fk_TicketKunde FOREIGN KEY (KundeID) REFERENCES t_Kunde(ID),
    UNIQUE uk_Ticket (AuffuerungID, PlatzID)
);

CREATE OR REPLACE VIEW v_Angestellte AS 
	SELECT t_Angestellte.ID , t_Angestellte.Benutzername, t_Typ.Typ, t_Angestellte.Passwort
    FROM t_Angestellte INNER JOIN t_Typ 
    ON t_Angestellte.TypID = t_Typ.ID;

CREATE OR REPLACE VIEW v_Account AS 
	SELECT 'Kunde' AS Typ, CONVERT(BenutzerName USING latin1) COLLATE latin1_general_cs AS Username, Passwort AS Password FROM t_Kunde 
    UNION 
    SELECT Typ AS Typ, CONVERT(BenutzerName USING latin1) COLLATE latin1_general_cs AS Username, Passwort AS Password FROM v_Angestellte;
    
CREATE OR REPLACE VIEW v_KinoOrt AS
	SELECT ID, Kinoname, Ort FROM t_Kino
    

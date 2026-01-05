
/* 01_schema.sql
   Projet Tifosi - MySQL
   - Création BDD + utilisateur
   - Tables + contraintes + index */

/* Sécurité : on supprime la BDD si elle existe */
DROP DATABASE IF EXISTS tifosi;

/* Création base (UTF8 complet) */
CREATE DATABASE tifosi
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

/* Création utilisateur local */ 
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi@2026!';

GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

USE tifosi;

/*Tables "référentiels"*/

CREATE TABLE marque (
  id_marque INT PRIMARY KEY,
  nom_marque VARCHAR(50) NOT NULL,
  CONSTRAINT uq_marque_nom UNIQUE (nom_marque)
) ENGINE=InnoDB;

CREATE TABLE boisson (
  id_boisson INT PRIMARY KEY,
  nom_boisson VARCHAR(80) NOT NULL,
  id_marque INT NOT NULL,
  CONSTRAINT uq_boisson_nom UNIQUE (nom_boisson),
  CONSTRAINT fk_boisson_marque
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_boisson_marque ON boisson(id_marque);

CREATE TABLE ingredient (
  id_ingredient INT PRIMARY KEY,
  nom_ingredient VARCHAR(80) NOT NULL,
  CONSTRAINT uq_ingredient_nom UNIQUE (nom_ingredient)
) ENGINE=InnoDB;

CREATE TABLE focaccia (
  id_focaccia INT PRIMARY KEY,
  nom_focaccia VARCHAR(80) NOT NULL,
  prix DECIMAL(5,2) NOT NULL,
  CONSTRAINT uq_focaccia_nom UNIQUE (nom_focaccia),
  CONSTRAINT ck_focaccia_prix CHECK (prix > 0)
) ENGINE=InnoDB;

/* Relation "comprend" (focaccia <-> ingredient) avec quantite */
CREATE TABLE focaccia_ingredient (
  id_focaccia INT NOT NULL,
  id_ingredient INT NOT NULL,
  quantite INT NOT NULL,
  PRIMARY KEY (id_focaccia, id_ingredient),
  CONSTRAINT ck_quantite_pos CHECK (quantite > 0),
  CONSTRAINT fk_fi_focaccia
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_fi_ingredient
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_fi_ingredient ON focaccia_ingredient(id_ingredient);

/* Tables "menu" / "client" / "achat" */

/* "est constitué" : un menu est constitué d’1 focaccia (1,1 côté menu)*/
CREATE TABLE menu (
  id_menu INT PRIMARY KEY,
  nom_menu VARCHAR(80) NOT NULL,
  prix DECIMAL(5,2) NOT NULL,
  id_focaccia INT NOT NULL,
  CONSTRAINT uq_menu_nom UNIQUE (nom_menu),
  CONSTRAINT ck_menu_prix CHECK (prix > 0),
  CONSTRAINT fk_menu_focaccia
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_menu_focaccia ON menu(id_focaccia);

/* "contient" : un menu contient 1..n boissons */
CREATE TABLE menu_boisson (
  id_menu INT NOT NULL,
  id_boisson INT NOT NULL,
  quantite INT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_menu, id_boisson),
  CONSTRAINT ck_mb_quantite_pos CHECK (quantite > 0),
  CONSTRAINT fk_mb_menu
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_mb_boisson
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_mb_boisson ON menu_boisson(id_boisson);

CREATE TABLE client (
  id_client INT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  email VARCHAR(80) NOT NULL,
  code_postal INT NOT NULL,
  CONSTRAINT uq_client_email UNIQUE (email),
  CONSTRAINT ck_cp_fr CHECK (code_postal BETWEEN 0 AND 99999)
) ENGINE=InnoDB;

/* "achète" : association client <-> menu avec date_achat */
CREATE TABLE achat (
  id_client INT NOT NULL,
  id_menu INT NOT NULL,
  date_achat DATE NOT NULL,
  PRIMARY KEY (id_client, id_menu, date_achat),
  CONSTRAINT fk_achat_client
    FOREIGN KEY (id_client) REFERENCES client(id_client)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_achat_menu
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_achat_date ON achat(date_achat);

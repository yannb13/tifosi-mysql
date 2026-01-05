/* 02_insert_data.sql
   - Insertion des données de test (Excel fourni)
   - + quelques menus/clients/achats pour tester le MCD */

USE tifosi;

START TRANSACTION;

/* Marques (marque.xlsx)*/
INSERT INTO marque (id_marque, nom_marque) VALUES
(1, 'Coca-cola'),
(2, 'Cristalline'),
(3, 'Monster'),
(4, 'Pepsico');

/* Boissons (boisson.xlsx)*/
INSERT INTO boisson (id_boisson, nom_boisson, id_marque) VALUES
(1,  'Coca-cola zéro',             1),
(2,  'Coca-cola original',         1),
(3,  'Fanta citron',               1),
(4,  'Fanta orange',               1),
(5,  'Capri-sun',                  1),
(6,  'Pepsi',                      4),
(7,  'Pepsi Max Zéro',             4),
(8,  'Lipton zéro citron',         4),
(9,  'Lipton Peach',               4),
(10, 'Monster energy ultra gold',  3),
(11, 'Monster energy ultra blue',  3),
(12, 'Eau de source',              2);

/* Ingrédients (ingredient.xlsx)*/
INSERT INTO ingredient (id_ingredient, nom_ingredient) VALUES
(1,  'Ail'),
(2,  'Ananas'),
(3,  'Artichaut'),
(4,  'Bacon'),
(5,  'Base Tomate'),
(6,  'Base crème'),
(7,  'Champignon'),
(8,  'Chevre'),
(9,  'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fumé'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise'),
(25, 'Mozarella');

/* Focaccias (focaccia.xlsx)*/
INSERT INTO focaccia (id_focaccia, nom_focaccia, prix) VALUES
(1, 'Mozaccia',       9.80),
(2, 'Gorgonzollaccia',10.80),
(3, 'Raclaccia',      8.90),
(4, 'Emmentalaccia',  9.80),
(5, 'Tradizione',     8.90),
(6, 'Hawaienne',     11.20),
(7, 'Americaine',    10.80),
(8, 'Paysanne',      12.80);

/* Association focaccia <-> ingredient (comprend) + quantités */

/* F1 Mozaccia : Base Tomate, Mozarella, Cresson, Jambon fumé, Ail, Artichaut, Champignon, Parmesan, Poivre, Olive noire */
INSERT INTO focaccia_ingredient VALUES
(1, 5, 200),  -- Base Tomate
(1, 25, 50),  -- Mozarella
(1, 9, 20),   -- Cresson
(1, 13, 80),  -- Jambon fumé
(1, 1, 2),    -- Ail
(1, 3, 20),   -- Artichaut
(1, 7, 40),   -- Champignon
(1, 18, 50),  -- Parmesan
(1, 20, 1),   -- Poivre
(1, 16, 20);  -- Olive noire

/* F2 Gorgonzollaccia : Base Tomate, Gorgonzola, Cresson, Ail, Champignon, Parmesan, Poivre, Olive noire */
INSERT INTO focaccia_ingredient VALUES
(2, 5, 200),
(2, 11, 50),
(2, 9, 20),
(2, 1, 2),
(2, 7, 40),
(2, 18, 50),
(2, 20, 1),
(2, 16, 20);

/* F3 Raclaccia : Base Tomate, Raclette, Cresson, Ail, Champignon, Parmesan, Poivre */
INSERT INTO focaccia_ingredient VALUES
(3, 5, 200),
(3, 22, 50),
(3, 9, 20),
(3, 1, 2),
(3, 7, 40),
(3, 18, 50),
(3, 20, 1);

/* F4 Emmentalaccia : Base crème, Emmental, Cresson, Champignon, Parmesan, Poivre, Oignon */
INSERT INTO focaccia_ingredient VALUES
(4, 6, 200),
(4, 10, 50),
(4, 9, 20),
(4, 7, 40),
(4, 18, 50),
(4, 20, 1),
(4, 15, 20);

/* F5 Tradizione : ... champignon(80), olive noire(10), olive verte(10) */
INSERT INTO focaccia_ingredient VALUES
(5, 5, 200),
(5, 25, 50),
(5, 9, 20),
(5, 12, 80),
(5, 7, 80),   -- override
(5, 18, 50),
(5, 20, 1),
(5, 16, 10),  -- override
(5, 17, 10);  -- override

/* F6 Hawaienne : Base Tomate, Mozarella, Cresson, Bacon, Ananas, Piment, Parmesan, Poivre, Olive noire */
INSERT INTO focaccia_ingredient VALUES
(6, 5, 200),
(6, 25, 50),
(6, 9, 20),
(6, 4, 80),
(6, 2, 40),
(6, 19, 2),
(6, 18, 50),
(6, 20, 1),
(6, 16, 20);

/* F7 Americaine : ... pomme de terre(40)*/
INSERT INTO focaccia_ingredient VALUES
(7, 5, 200),
(7, 25, 50),
(7, 9, 20),
(7, 4, 80),
(7, 21, 40),  -- override
(7, 18, 50),
(7, 20, 1),
(7, 16, 20);

/* F8 Paysanne : Base crème, Chevre, Cresson, Pomme de terre, Jambon fumé, Ail, Artichaut, Champignon, Parmesan, Poivre, Olive noire, Oeuf */
INSERT INTO focaccia_ingredient VALUES
(8, 6, 200),
(8, 8, 50),
(8, 9, 20),
(8, 21, 80),
(8, 13, 80),
(8, 1, 2),
(8, 3, 20),
(8, 7, 40),
(8, 18, 50),
(8, 20, 1),
(8, 16, 20),
(8, 14, 50);

/* Données complémentaires (menus/clients/achats) */

INSERT INTO menu (id_menu, nom_menu, prix, id_focaccia) VALUES
(1, 'Menu Mozaccia + Coca-cola zéro',  11.90, 1),
(2, 'Menu Raclaccia + Pepsi',          10.50, 3),
(3, 'Menu Paysanne + Eau de source',   14.00, 8),
(4, 'Menu Hawaienne + Fanta orange',   13.00, 6);

INSERT INTO menu_boisson (id_menu, id_boisson, quantite) VALUES
(1, 1, 1),
(2, 6, 1),
(3, 12, 1),
(4, 4, 1);

INSERT INTO client (id_client, nom, email, code_postal) VALUES
(1, 'Alice Martin', 'alice.martin@test.fr', 75001),
(2, 'Bob Durand',   'bob.durand@test.fr',   69002),
(3, 'Chloe Petit',  'chloe.petit@test.fr',  33000);

INSERT INTO achat (id_client, id_menu, date_achat) VALUES
(1, 1, '2026-01-02'),
(1, 3, '2026-01-03'),
(2, 2, '2026-01-03'),
(3, 4, '2026-01-04');

COMMIT;

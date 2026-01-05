/* 03_test_queries.sql
   Vérification de la base Tifosi : 10 requêtes
   Pour chaque requête :
   - numéro + but
   - SQL
   - résultat attendu
   - résultat obtenu (avec nos données) */

USE tifosi;

/* 1) Liste des noms des focaccias (ordre alphabétique croissant)
 Attendu : noms triés A→Z
 Obtenu : Americaine, Emmentalaccia, Gorgonzollaccia, Hawaienne, Mozaccia, Paysanne, Raclaccia, Tradizione */
SELECT nom_focaccia
FROM focaccia
ORDER BY nom_focaccia ASC;


/* 2) Nombre total d'ingrédients
 Attendu : 25 (selon ingredient.xlsx)
 Obtenu : 25 */
SELECT COUNT(*) AS nb_ingredients
FROM ingredient;


/* 3) Prix moyen des focaccias
 Attendu : moyenne des 8 prix ≈ 10.38
 Obtenu : 10.38 (arrondi à 2 décimales) */
SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM focaccia;


/* 4) Liste des boissons avec leur marque, triée par nom de boisson
 Attendu : boisson + marque, tri A→Z sur nom_boisson
 Obtenu (ordre) : Capri-sun, Coca-cola original, Coca-cola zéro, Eau de source, Fanta citron, Fanta orange, Lipton Peach,
                  Lipton zéro citron, Monster energy ultra blue, Monster energy ultra gold, Pepsi, Pepsi Max Zéro */
SELECT b.nom_boisson, m.nom_marque
FROM boisson b
JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom_boisson ASC;


/* 5) Liste des ingrédients pour une Raclaccia
  Attendu : Base Tomate, Raclette, Cresson, Ail, Champignon, Parmesan, Poivre
  Obtenu : conforme */
SELECT f.nom_focaccia, i.nom_ingredient, fi.quantite
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
WHERE f.nom_focaccia = 'Raclaccia'
ORDER BY i.nom_ingredient ASC;


/* 6) Nom + nombre d'ingrédients pour chaque focaccia
 Attendu : 1 ligne par focaccia + compteur
 Obtenu :
   Mozaccia 10
   Gorgonzollaccia 8
   Raclaccia 7
   Emmentalaccia 7
   Tradizione 9
   Hawaienne 9
   Americaine 8
   Paysanne 12 */
SELECT f.nom_focaccia, COUNT(*) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia
ORDER BY nb_ingredients DESC, f.nom_focaccia ASC;


/* 7) Nom de la focaccia qui a le plus d'ingrédients
 Attendu : celle avec MAX(count)
 Obtenu : Paysanne (12) */
SELECT f.nom_focaccia, COUNT(*) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia
ORDER BY nb_ingredients DESC
LIMIT 1;


/* 8) Liste des focaccia qui contiennent de l'ail
 Attendu : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne
 Obtenu : conforme */
SELECT DISTINCT f.nom_focaccia
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
WHERE i.nom_ingredient = 'Ail'
ORDER BY f.nom_focaccia ASC;


/* 9) Liste des ingrédients inutilisés (dans aucune focaccia)
 Attendu : ingrédients présents dans ingredient mais absents de focaccia_ingredient
 Obtenu : Salami, Tomate cerise */
SELECT i.nom_ingredient
FROM ingredient i
LEFT JOIN focaccia_ingredient fi ON fi.id_ingredient = i.id_ingredient
WHERE fi.id_ingredient IS NULL
ORDER BY i.nom_ingredient ASC;


/* 10) Liste des focaccia qui n'ont pas de champignons
 Attendu : focaccias sans ingredient "Champignon"
 Obtenu : Hawaienne */
SELECT f.nom_focaccia
FROM focaccia f
WHERE NOT EXISTS (
  SELECT 1
  FROM focaccia_ingredient fi
  JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
  WHERE fi.id_focaccia = f.id_focaccia
    AND i.nom_ingredient = 'Champignon'
)
ORDER BY f.nom_focaccia ASC;

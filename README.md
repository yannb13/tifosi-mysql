# Tifosi - Base de données MySQL

## Contenu du livrable
Le dépôt contient :
- `sql/01_schema.sql` : création de la base `tifosi`, création utilisateur, tables, contraintes.
- `sql/02_insert_data.sql` : insertion des données de test (Excel) + données complémentaires pour menus/clients/achats.
- `sql/03_test_queries.sql` : 10 requêtes de vérification avec commentaires (attendu / obtenu / écarts).

## Exécution (MySQL Workbench)
1. Ouvrir MySQL Workbench et se connecter.
2. Exécuter `sql/01_schema.sql`
3. Exécuter `sql/02_insert_data.sql`
4. Exécuter `sql/03_test_queries.sql`

> Exécuter les scripts dans cet ordre.

## Fichiers sources (Excel)

Les fichiers Excel fournis (`boisson.xlsx`, `focaccia.xlsx`, `ingredient.xlsx`, `marque.xlsx`)
sont présents dans le dossier `fichiers-à-joindre-au-devoir/`.

Ils ont été utilisés comme source de données pour rédiger manuellement
le script SQL `02_insert_data.sql`, conformément aux consignes du projet

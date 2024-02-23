# Grails REDDIT

## Contributeurs 
- Maxime BELLET
- Benjamin BERNAUD

## Fonctionnalités

API Rest :
- GET, PUT, PATCH, DELETE:
- - /user
  - /community
  - /post
  - /message
- GET, POST
- - /users
  - /communities
  - /posts
  - /messages

**Pas de delete sur /user**

Backend : 
- Interface Admin
- - Créer
  - Voir de manière unitaire ou en liste
  - Modifier
  - Supprimer
des Users, Communities, Posts et des Messages
- Upload de fichiers

## Outils utilisés
- Grails - version 3.3.8
- Hibernate
- Spring Security
- h2


## Lancer le projet 

```bash
gradle clean build
```
pour installer toutes les dépendances

puis on run le projet
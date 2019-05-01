Castle est une cartouche [PICO-8](https://www.lexaloffle.com/pico-8.php) en cours de développement.

<img src="images/castle_0.gif" width="256px" height="auto">

## Prérequis

Installer PICO-8 v0.1.12.

La version v0.1.12 est nécessaire pour l'option `-root_path` et l'instruction `#include`.

## Lancer la cartouche

Lancer PICO-8, et exécuter la commande `folder`. Cette commande ouvre le répertoire de vos cartouches PICO-8.

Copier la cartouche `carts/castle.p8` dans vos cartouches.

Chargez la cartouche et lancez la :
```
> load castle
> run
```

## Mode développement

Ce mode sert à lancer la cartouche depuis le dépot git, pour pouvoir versionner le code indépendamment du répertoire par défaut de PICO-8.

### Indiquer où se trouve votre exécutable PICO-8

Pour indiquer le chemin de `pico8`, vous pouvez soit renseigner la variable d'environnement `PICO_8` devant la commande `make`, soit créer un fichier `.env`.

**Par variable d'environnement**

```
PICO_8=/path/to/pico8 make
```

**Par fichier `.env`**

Créer un fichier `.env` sur le modèle de `.env.example` qui indique où se trouve votre exécutable `pico8`. Ce fichier `.env` ne sera pas versionné.

### Lancer la cartouche

Ensuite, lancer PICO-8 avec :

```
make start-pico8
```

### Lancer les tests

Les tests utilisent la librairie Lua [busted](https://olivinelabs.com/busted/).

Pour s'exécuter, ils ont besoin de Lua 5.2. Le `Dockerfile` fournit cet environnement.

La cible `make build` construit un container avec Lua 5.2 et busted, et la cible `make test` exécute les tests dans ce container.

Castle est une cartouche [PICO-8](https://www.lexaloffle.com/pico-8.php) en cours de développement.

![Demo GIF](images/castle_0.gif?raw=true)

## Prérequis

Installer PICO-8 v0.1.12.

La version v0.1.12 est nécessaire pour l'option `-root_path` et l'instruction `#include`.

## Lancer la cartouche

Lancer PICO-8, et exécuter la commande `folder`. Cette commande ouvre le répertoire de vos cartouches PICO-8.

Copier les fichiers du répertoire `carts/` dans vos cartouches.

Chargez la cartouche et lancez la :
```
> load castle
> run
```

## Mode développement

Ce mode sert à lancer la cartouche depuis le dépot git, pour pouvoir versionner le code indépendamment du répertoire par défaut de PICO-8.

Pour lancer la cartouche, vous pouvez utiliser le `Makefile` à condition d'indiquer le chemin de l'exécutable `pico8`. Pour indiquer ce chemin, vous pouvez soit renseigner la variable d'environnement `PICO_8` devant la commande `make`, soit créer un fichier `.env`.

**Par variable d'environnement**

```
PICO_8=/path/to/pico8 make run
```

**Par fichier `.env`**

Créer un fichier `.env` sur le modèle de `.env.example` qui indique où se trouve votre exécutable `pico8`. Ce fichier `.env` ne sera pas versionné.

Ensuite, lancer la cartouche avec :

```
make run
```

### Lancer les tests

Les tests utilisent la librairie Lua [busted](https://olivinelabs.com/busted/).

Pour s'exécuter, ils ont besoin de Lua 5.2. Le `Dockerfile` fournit cet environnement.

La cible `make build` construit un container avec Lua 5.2 et busted, et la cible `make test` exécute les tests dans ce container.

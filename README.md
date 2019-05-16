# Validation Bash
> Uniquement pour cette validation, vous pouvez vous mettre avec un/une partenaire pour le réaliser. Vous pouvez également le faire seul/e, cela ne pose aucun problème.
>
> Vous allez devoir réaliser non pas un, non pas deux, mais trois scripts qui vont permettre respectivement de:
>
> 1) Au lancement de ce script, vous devrez créer un Vagrantfile et demander à l'utilisateur le nom de son dossier synchronisé local (qui de base est data) puis de le créer. 
>	 Une fois le tout achevé, vous devrez trouver le moyen de lancer un vagrant up, puis de lancer un vagrant SSH et de faire un 'sudo apt update'...
>
> 2) Au lancement de ce script, vous ajouterez tous les fichiers/dossiers qui se situent au même endroit que ce script dans un repo Git local. Ensuite, un commit automatique devra 
>	 être lancé et vous devrez demander une URL à l'utilisateur afin de l'ajouter en tant que remote et pouvoir push ce repo local sur le repo distant.
>
> 3) Vous allez devoir créer un script sur le thème de votre choix. Soyez inventifs. Mettez des couleurs, des clignotements, des commentaires, utilisez des fonctions, 
>	 des boucles et des conditions. 
>
>Évidemment, vous devrez réaliser un fichier readme.md en expliquant à quoi servent chaque script et quelles difficultés vous avez rencontré.

---
_Justine et Laëtitia DFS16_  
Avant de commencer merci de vérifier que les fichiers bash.sh, vagrant.sh et gitinit.sh sont bien dans le même dossier.

## Gestionnaire
Pour commencer dans votre terminal vous devez lancer bash.sh.  
Si jamais vous ne savez pas quoi faire vous pouvez taper help après avoir lancé le script.  
Les différents choix qui vont s'offrir à vous, vous permettent de :  
* Gérer vos fichiers;
* Lancer une vagrant sous ubuntu;
* Gérer GitHub dans votre répertoir actuel.

## Vagrant
Vous pouvez utiliser vagrant.sh seul. Il initialisera une vagrant ubuntu/xenial64, vous demandra le dossier avec lequel vous souhaitez synchroniser votre vagrant. Et mettra à jour celle-ci, puis vous connectera.

## Github
Vous pouvez utiliser gitinit.sh seul. Il vous permettra d'initialiser un répertoire, d'ajouter des fichier dessus et de push. Il gere les cas où votre remote n'existe pas et vous permet de mettre un message personnalisé lors de votre push.

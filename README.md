# Roger-Deploy
## Script de deploiement, machine virtuel + debian + pare-feu + server web + page web
![InitChecker](https://zupimages.net/up/19/03/cqkj.png)
<p align="center">
  <b>Script de deploiement pour le projet Roger-Skyline-1 de 42.</b><br>
</p>

### ATTENTION
Ce script a pour but de deployer sur une machine virtuel virtualbox , un systeme d'exploitation debian associe a des caracteristiques propres au sujet Roger-skyline-1 de l'ecole 42.
Tel quel le script ce deploie sur les machines de l'ecole 42.

Le ploiement doit s'effectuer dans l'ordre suivant :
-sh createvm.sh
-suivre installation debian sur la machien virtuel
-su root sur la machine
-sh install.sh
-reconnexion sur le machine
-su root
-sh deploiementssl.sh

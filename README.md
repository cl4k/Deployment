# Roger-Deploy
## Script de deploiement, machine virtuel + debian + pare-feu + server web + page web
![InitChecker](https://zupimages.net/up/19/03/cqkj.png)
<p align="center">
  <b>Script de deploiement pour le projet Roger-Skyline-1 de 42.</b><br>
</p>

### ATTENTION
Ce script a pour but de deployer sur une machine virtuel virtualbox , un systeme d'exploitation debian associe a des caracteristiques propres au sujet Roger-skyline-1 de l'ecole 42.
Tel quel le script se deploie sur les machines de l'ecole 42.

Le deploiement doit s'effectuer dans l'ordre suivant :<br>
-sh createvm.sh<br>
-suivre installation debian sur la machien virtuel<br>
-su root sur la machine<br>
-sh install.sh<br>
-reconnexion sur le machine<br>
-su root<br>
-sh deploiementssl.sh<br>

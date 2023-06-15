# Bookmark_url_validation
Tester dans un terminal BASH sous Linux Mint.

Ce script permet de vérifier les liens URL présents dans un fichier HTML donné, en envoyant une requête HTTP HEAD à chaque lien pour vérifier son état de validité. Les liens invalides sont ensuite enregistrés dans un fichier de sortie nommé "Liens_invalide.txt".

Le script fonctionne de la manière suivante :

1. Il vérifie si la commande "kdialog" est installée sur le système.
2. Il affiche une boîte de dialogue pour sélectionner le fichier HTML ciblé avec des dimensions réduites.
3. Il compte le nombre total de liens à vérifier.
4. Il boucle pour chaque ligne du fichier HTML ciblé.
5. Pour chaque ligne, il recherche les liens URL avec une expression régulière.
6. Pour chaque lien trouvé, il envoie une requête HTTP HEAD pour vérifier son état de validité avec un timeout de 10 secondes.
7. Si le lien est valide, il affiche un message dans le terminal.
8. Si le lien est invalide, il l'enregistre dans un fichier de sortie avec son code de statut (500, 404, 000, 307, 308).
9. À la fin de la boucle, il affiche un message pour indiquer que tous les liens ont été vérifiés avec succès.

--------------
**Comment utiliser le script**

Placer le script dans le même dossier du fichier HTML à vérifier.

Ouvrir un terminal et exécuter le script : **sh Bookmark_url_validation.sh**

# Nom du fichier de sortie pour les liens invalides
output_file="Liens_invalide.txt"

# Initialise une variable pour compter les liens URL
link_count=0

# Vérifiez si kdialog est installé sur le système
if ! [ -x "$(command -v kdialog)" ]; then
  echo "Kdialog n'est pas installé. Veuillez l'installer avant de continuer."
  exit 1
fi

# Affiche une boîte de dialogue pour sélectionner le fichier HTML ciblé avec des dimensions réduites
file=$(kdialog --getopenfilename . "*.html" --geometry 500x300)

# On compte les liens avant de boucler
while read line; do
    links=$(echo $line | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*")
    for link in $links; do
        link_count=$((link_count+1))
    done
done <$file

# Affiche le nombre de liens URL à vérifier
echo "Nombre total de liens à vérifier: $link_count"

# Boucle pour chaque ligne du fichier HTML ciblé
while read line; do
    # Recherche des liens URL avec l'expression régulière
    links=$(echo $line | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*")

    # Boucle pour chaque lien trouvé
    for link in $links; do
        # Envoi une requête HTTP HEAD au lien avec un timeout de 10 sec, vérifie le code de statut
        status_code=$(curl --max-time 10 --silent --head --write-out '%{http_code}' "$link" --output /dev/null)

        # Si le lien est valide, l'affiche dans le terminal
        if [ $status_code -eq 200 ]; then
            echo "Le lien est valide: $link ($status_code)"
        # Si le lien est invalide avec les codes de statut 500, 404, 000, 307 et 308, l'écris dans un fichier avec le code de statut
        elif [ $status_code -eq 500 ] || [ $status_code -eq 404 ] || [ $status_code -eq 000 ] || [ $status_code -eq 307 ] || [ $status_code -eq 308 ]; then
            echo "Le lien est invalide: $link ($status_code)" >> $output_file
        fi
    done
done <$file

echo "Tout les liens ont été vérifiés avec succès !"


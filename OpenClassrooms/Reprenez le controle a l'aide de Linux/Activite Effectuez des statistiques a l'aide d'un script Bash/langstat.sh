#!/bin/bash

# By Sebastien Malissard
# On 14 December 2014 
# http://openclassrooms.com/courses/reprenez-le-controle-a-l-aide-de-linux

temp=fichier_temp	# Nom du fichier temporaire

if [ -z $1 ] 		# Verification de l'existance du 1er parametre
then
	echo "Veuillez mettre un fichier dictionaire en paramètre"

elif [ ! -e $1 ]	# Verification si le fichier existe
then
	echo "Le fichier n'existe pas"

elif [ ! -r $1 ]	# Verification si le fichier est lisible
then
	echo "Le fichier n'est pas lisible"

elif [ -z $2 ]
then
	if [ -e $temp ]	# Verification de l'existance d'un fichier temporaire
	then
		rm $temp	# Supression si ce fichier existe
	fi
	touch $temp		# Creation du fichier temporaire
	
	for i in `seq 65 90`;	# boucle de A = 65 a Z = 90 (ASCII)
	do
		c=$(printf \\$(printf '%03o' $i)) 	# Convertion decimal en caractere
		r=$(grep -c $c $1)					# Compte de nombre de mots contenant le caractere dans le fichier
		echo "$r - $c" >> $temp				# Ecriture du resultat dans le fichier temporaire		
	done

	sort -rn $temp	# Tri par ordre decroissant et affichage a l'ecran

	rm $temp		# Supression du fichier temporaire

else				# Option recherher uniquement une lettre (ou groupe de lettre)
	r=$(grep -c $2 $1)	# Compte le nombre de mots contenat le caractere dans le fichier
	echo "$r - $2"		# Affichage a l'ecran

fi	

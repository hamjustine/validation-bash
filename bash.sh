#!/bin/bash
# if [ $# -eq 1 ]; then
#     echo -e "\033[32m\033[5m$1\033[0m"
#     exit
#  elif  [ $# -gt 1 ]; then
#     echo "Trop de parametres"
#     exit
# fi


function Accueil() {
    echo "Bonjour, que voulez vous faire ?"
    echo -e " pour l'aide tapez \033[44m\033[5m\033[97m help \033[0m"
    read reponse
    case $reponse in
        help | Help | HELP) afficherAide;;
        move* | Move*) moveTo;;
        vagrant | Vagrant) vagrantLaunch;;
        git* | Git*) github;;
        read* | Read*) Read;;
        exit | Exit) exit;;
        AgirSur) echo " Sur quoi voulez vous agir ?"
                echo "Dossier, Fichier"
                read reponse2
                Agir;;
        *) echo " Je ne connais pas cette commande"
           Accueil
    esac
}

function afficherAide()
{
    echo -e "Se deplacer : \033[34mMoveTo\033[0m <cible>"
    echo -e "Lancer une vagrant en ubuntu, vierge : \033[34mVagrant\033[0m"
    echo -e "entrer dans le gestionnaire Github : \033[34mgit\033[0m"
    echo -e "lire le fichier : \033[34mRead \033[0m<cible>"
    echo -e "modifier un fichier ou un dossier: \033[34m AgirSur \033[0m"
    Accueil
}

function github()
{
    chmod 777 gitinit.sh
    ./gitinit.sh
}


function vagrantLaunch()
{
    chmod 777 vagrant.sh
    ./vagrant.sh
}

function moveTo()
{
    subStr=${reponse:7}
    if test -d "$subStr"; then
        cd $subStr
        echo -e "vous etes maintenant dans le dossier \033[34m$subStr\033[30m"
        Accueil
    else
        echo -e " $subStr n'existe pas, voulez vous créer ce dossier ? \033[32mOui\033[0m/\033[31mNon\033[0m"
        read reponse2
        case $reponse2 in
            o* | O*) mkdir $subStr
                echo -e "\033[32m$subStr\033[0m a bien été créé"
                Accueil;;
            nN*) Accueil;;
        esac
    fi
}
function Agir()
{
    if $reponse2 = "Dossier"; then
        Dossier
    elif $reponse2 = "Fichier"; then
        Fichier
    else
        echo "commande inconnue"
        read reponse2
        Agir
    fi
}

function Dossier
{
    echo -e "\033[34mCreate, Suppr, Move, Rename \033[0m<cible> "
    read reponse3
    case $reponse3 in
        create* | Create* | CREATE*) subStr=${reponse3:7}
                                        mkdir $subStr;;
        suppr* | Suppr*) subStr=${reponse3:6}
                            var=$(ls -a $subStr | sed -e "/\.$/d" | wc -l)
                            echo $var
                            sleep 5
                            if [ $var -eq 0 ]
                            then
                                rm $subStr
                            else
                                echo "ce dossier contient $var fichier(s), voulez vous quand même le supprimer ?"
                                read reponseDossier
                                    if $reponseDossier = "oui"; then rem -f $subStr
                                    else Accueil
                                    fi
                            fi;;
        move* | Move*) subStr=${reponse3:5}
                        mv $subStr
                        Accueil;;
        copy* | Copy*) subStr=${reponse3:5}
                        cp $subStr
                        Accueil;;
        back | Back) Accueil;;
        exit) exit;;
    esac
}

function Fichier
{
    echo -e "modifier un fichier : \033[34m Copy, Suppr, Move, Rename \033[0m<cible>; Back"
    read reponse3
    case $reponse3 in
        copy* | Copy*) subStr=${reponse3:5}
                        cp $subStr
                        Accueil;;
        suppr* | Suppr*) subStr=${reponse3:6}
            if [ -s $subStr ]
            then
                echo -e "\033[34m$subStr\033[30m n'est pas vide, voulez vous quand même le supprimer ? \033[32mOui\033[0m/\033[31mNon\033[0m"
                read reponseFichier
                    if $reponseFichier = "Oui";then rm -f $subStr
                    else Accueil
                    fi
                else
                rm $subStr
                fi;;
        move* | Move*) subStr=${reponse3:5}
                        mv $subStr
                        Accueil;;
        rename* | Rename*) subStr=${reponse3:7}
                        mv $subStr
                        Accueil;;
        back | Back) Accueil;;
        exit) exit;;
    esac
}

function Read()
{
    subStr=${reponse:4}
    if test -r "$subStr"; then
        echo "vous voulez lire $subStr"
        while IFS= read -r var
        do
            echo "$var"
        done < "$subStr"
    else
        echo " le fichier $subStr n'existe pas, ou vous n'avez pas les droits pour le lire"
    fi
    Accueil
}

Accueil





# NomDossier="test"
# echo "dossier a créer :"

# while [ $NomDossier != "stop" ]
#   do 
#     read NomDossier
#     if [ $NomDossier = "stop" ]
#     then
#         exit
#     fi
#     mkdir $NomDossier
#     echo "le dossier $NomDossier vient d'être créé, ensuite ?"
#     done
#   echo "fin du script"

# echo "Aimez vous les cheeseburger?"
# read varmmo

# if [ $varmmo == "Oui" ]
# then
#     echo "vous avez bien raison"
# elif [ $varmmo == "Non" ]
# then
#     echo " il en faut bien pour tout le monde"
# fi

# echo -e "$num1 + $num2 = \033[45m\033[5m$somme\033[0m"

# echo "premier chiffre"
# read num1
# total=0
# while [ $num1 != "=" ]
#     do
#     total=$(($num1+$total))
#     echo "ensuite ?"
#     read num1
#     done
# echo $total
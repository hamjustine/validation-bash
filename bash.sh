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
    #si jamais le user n'a pas les droits, on les mets :>
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
    #on recupère le nom du dossier/fichier en cutant la chaine après la commande
    subStr=${reponse:7}
    #on verifie s'il existe
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

# cette fonction nous permet d'avoir des actions differentes si c'est un dossier ou un fichier
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
        #on compte le nombre de fichiers dans le dossier
                            var=$(ls -a $subStr | sed -e "/\.$/d" | wc -l)
                            echo $var
                            sleep 5
                            #s'il n'y a pas de fichier, on supprime sans probleme, sinon on lui demande s'il est bourrin
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
        #on verifie si le fichier est vide avant de le supprimer
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
    # on verifie si le fichier existe ou si on a les droits de le lire
    if [ -f ${subStr} ]
    then
        if [ -s ${subStr} ]
        then
            echo "vous voulez lire $subStr"
            while IFS= read -r var
            do
                echo "$var"
            done < "$subStr"
        fi
    else
        echo "le fichier $subStr n'existe pas, ou vous n'avez pas les droits pour le lire"
    fi
    Accueil
}

Accueil
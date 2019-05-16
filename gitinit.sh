#cette fonction enregistre les id de l'user pour els utiliser plus tard
# function saveUser()
# {
#     echo "Avez vous un compte git Hub ? \033[32mY\033[0m/\033[31mN\033[0m"
#     read $response
#     case $response in
#         yY*) echo "Identifiant : "
#             read $user
#             echo "mot de passe : "
#             read $mdp;;
#         *) echo "continuons";;
#     esac
# }

function afficherAide()
{
    echo -e "Push sur votre repo  : \033[34mpush\033[0m <remote> (optionnel)"
    echo -e "Initaliser votre repo  : \033[34minit\033[0m"
    echo -e "Créer un git ignore  : \033[34mignore\033[0m <file> (optionnel)"
    echo -e "Retour au gestionnaire : \033[34mback\033[0m "
    start
}

#créé le repo
function repoCreate()
{
    git init &>-
    echo "votre repo a bien été initialisé"
    start
}
    # *) for i in `echo $response | tr "," " "`
#cette fonction ajoute les fichiers souhaitez au repo
function addFiles()
{
    echo "Quels fichiers souhaitez-vous ajouter ? 'all' permet d'ajouter tous les fichiers"
    read fichiers
    case $fichiers in 
    all) git add --all 
         git status;;
    #on tri dans la reponse chaucn des fichiers afin de les tester independamment
    *) for i in `echo $fichiers`
       do 
       if ! test -f "$i"; then echo "le fichier $i n'existe pas"
       addFiles
       else
            git add $i
            echo "le fichier $i a bien été ajouté au repo"
       fi
    done;;
    esac
}

function ignore()
{
    subStr=${reponse:7}
    echo "$subStr" > .gitignore
    echo "$subStr a bien été ajouté au gitignore"
    start
}

function push()
{
    # https://github.com/hamjustine/validation-bash.git
    remote=${reponse:5}
    addFiles
    #on verifie si une remote a été indiquée ou non
    if [ -z "$remote" ] 
    then
    echo "dans quelle remote voulez vous push ?"
    read remote
    fi
    #on verifie que la remote existe et on propose de la créer si ce n'est pas le cas
    git ls-remote --exit-code $remote &>-
    if git config remote.${VAR1}.url; then
        echo "$?"
        echo -e "cette remote n'existe pas, la creer ? \033[32mOui\033[0m/\033[31mNon\033[0m" 
        read responseRemote
        case $responseRemote in
        oui | Oui) echo "quel est le chemin ?"
                read $remoteUrl
                if [ git remote add $remote $remoteUrl ]
                then
                    echo "la création a échoué"
                    start
                fi;;
        non | Non) start;;
        esac
    fi
    echo "quel message voulez vous ajouter a votre commit ?'First commit' par défaut"
    read message
    #si le message est vide, le message de base sera 'first commit'
    if [ -z "$message" ]
    then 
        $message="first commit"
    fi
    git commit -m "$message"
    git push $remote master 
    echo "le push a bien été réalisé"
    start
}

#fonction au démarrage, qui permet a l'user de decider de ses actions
function start()
{
    echo "Bienvenue dans le gestionnaire Git, que voulez vous faire ?"
    echo -e " pour l'aide tapez \033[45m\033[5m gitHelp \033[0m"
    read reponse
    case $reponse in
        githelp | gitHelp | GITHELP) afficherAide;;
        push* | Push*) push;;
        init* | Init*) repoCreate;;
        ignore* | Ignore*) ignore;;
        back | Back) chmod 777 bash.sh
        ./bash.sh;;
        exit | Exit) exit;;
        *) echo " Je ne connais pas cette commande"
           start;;
    esac
}

start

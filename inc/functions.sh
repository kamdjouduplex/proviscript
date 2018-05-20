
func_proviscript_welcome() {
    echo "                                                                                  ";
    echo "                                                                                  ";
    echo " ██████╗ ██████╗  ██████╗ ██╗   ██╗██╗███████╗ ██████╗██████╗ ██╗██████╗ ████████╗";
    echo " ██╔══██╗██╔══██╗██╔═══██╗██║   ██║██║██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝";
    echo " ██████╔╝██████╔╝██║   ██║██║   ██║██║███████╗██║     ██████╔╝██║██████╔╝   ██║   ";
    echo " ██╔═══╝ ██╔══██╗██║   ██║╚██╗ ██╔╝██║╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ";
    echo " ██║     ██║  ██║╚██████╔╝ ╚████╔╝ ██║███████║╚██████╗██║  ██║██║██║        ██║   ";
    echo " ╚═╝     ╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ";
    echo "                                                                                  ";
    echo "                         https://proviscript.github.io                            ";
    echo "                                                                                  ";
    echo "                  Provisioning Shell Scripts for Linux servers                    ";
}

func_proviscript_thanks() {
    echo "                                                                                  ";
    echo "  .-.-.  .-.-.  .-.-.  .-.-.  .-.-.  .-.-.                                        ";
    echo " ( T .' ( h .' ( a .' ( n .' ( k .' ( s .'                                        ";
    echo '  `.(    `.(    `.(    `.(    `.(    `.(                                          ';
    echo "                                                                                  ";
    echo " Thanks for using Proviscript!                                                    ";
    echo " Star us to let us know you like this script!                                     ";
    echo " https://github.com/Proviscript/proviscript                                       ";
    echo "                                                                                  ";
    echo " If you have any questions please don't hesitate to leave your messages on:       ";
    echo " https://github.com/Proviscript/proviscript/issues                                ";
    echo "                                                                                  ";
    echo " Bye.                                                                             ";
    echo "                                                                                  ";
}

func_component_welcome() {
    echo
    echo
    echo " Prepare to install.."                                                                                        
    case  "${1}" in
        "nginx")
            echo "  _   _           _                       ";
            echo " | \ | |   __ _  (_)  _ __   __  __       ";
            echo " |  \| |  / _\` | | | | '_ \  \ \/ /      ";
            echo " | |\  | | (_| | | | | | | |  >  <        ";
            echo " |_| \_|  \__, | |_| |_| |_| /_/\_\       ";
            echo "          |___/                      ${2} ";
        ;;           
        "mariadb")
            echo "  __  __                  _           ____    ____        ";
            echo " |  \/  |   __ _   _ __  (_)   __ _  |  _ \  | __ )       ";
            echo " | |\/| |  / _\` | | '__| | |  / _\` | | | | | |  _ \     ";
            echo " | |  | | | (_| | | |    | | | (_| | | |_| | | |_) |      ";
            echo " |_|  |_|  \__,_| |_|    |_|  \__,_| |____/  |____/       ";
            echo "                                                     ${2} ";
        ;;
        "php-fpm")
            echo "  ____    _   _   ____            _____   ____    __  __        ";
            echo " |  _ \  | | | | |  _ \          |  ___| |  _ \  |  \/  |       ";
            echo " | |_) | | |_| | | |_) |  _____  | |_    | |_) | | |\/| |       ";
            echo " |  __/  |  _  | |  __/  |_____| |  _|   |  __/  | |  | |       ";
            echo " |_|     |_| |_| |_|             |_|     |_|     |_|  |_|       ";
            echo "                                                           ${2} ";
        ;;
    esac
}                                                                                    
                                                                                                  


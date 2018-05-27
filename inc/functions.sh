
INIT_PROVISCRIPT() {
    # Nothing to do. 
    # Just tell components it is load by main script "proviscript.sh"
}

# Bash color set
COLOR_EOF="\e[0m"
COLOR_BLUE="\e[34m"
COLOR_RED="\e[91m"
COLOR_GREEN="\e[92m"
COLOR_WHITE="\e[97m"
COLOR_DARK="\e[90m"
COLOR_BG_BLUE="\e[44m"
COLOR_BG_GREEN="\e[42m"
COLOR_BG_DARK="\e[100m"

func_proviscript_msg() {
    case "$1" in
        "info")
            echo -e "[${COLOR_BLUE}PS${COLOR_EOF}] ${COLOR_BLUE}${2}${COLOR_EOF}"
        ;;
        "warning")
            echo -e "[${COLOR_RED}PS${COLOR_EOF}] ${COLOR_RED}${2}${COLOR_EOF}"
        ;;
        "success")
            echo -e "[${COLOR_GREEN}PS${COLOR_EOF}] ${COLOR_GREEN}${2}${COLOR_EOF}"
        ;;
    esac
}

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
            echo " |  \| |  / _  \ | | | |_ \  \ \/ /       ";
            echo " | |\  | | (_| | | | | | | |  >  <        ";
            echo " |_| \_|  \__, | |_| |_| |_| /_/\_\       ";
            echo "          |___/                      ${2} ";

            
        ;;           
        "mariadb")
            echo "  __  __                  _           ____    ____        ";
            echo " |  \/  |   __ _   _ __  (_)   __ _  |  _ \  | __ )       ";
            echo " | |\/| |  / _  | | '__| | |  / _  | | | | | |  _ \       ";
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
        "redis")
            echo "  ____               _   _         "      
            echo " |  _ \    ___    __| | (_)  ___   "
            echo " | |_) |  / _ \  / _  | | | / __|  "
            echo " |  _ <  |  __/ | (_| | | | \__ \  "
            echo " |_| \_\  \___|  \__,_| |_| |___/  "
            echo "                                 ${2} "
        ;;
        "apache")
            echo "      _                             _              "
            echo "     / \     _ __     __ _    ___  | |__     ___   "
            echo "    / _ \   | '_ \   / _  |  / __| | '_ \   / _ \  "
            echo "   / ___ \  | |_) | | (_| | | (__  | | | | |  __/  "
            echo "  /_/   \_\ | .__/   \__,_|  \___| |_| |_|  \___|  "
            echo "            |_|                                   ${2} "
        ;;
    esac
}                                                                                    
                                                                                                  


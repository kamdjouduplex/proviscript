#
#                    +----------------+
#                    |  functions.sh  |   
#                    +----------------+
#
# Global Functions in Proviscript project
#
# Package  Proviscript
# Author   Terry Lin
# Link     https://github.com/Proviscript/proviscript
# License  MIT
#
#==============================================================================

INIT_PROVISCRIPT() {
    # Nothing to do. 
    # Just tell components it is load by main script "proviscript.sh"
    echo "" 2>&1
}

# Bash color set
readonly COLOR_EOF="\e[0m"
readonly COLOR_BLUE="\e[34m"
readonly COLOR_RED="\e[91m"
readonly COLOR_GREEN="\e[92m"
readonly COLOR_WHITE="\e[97m"
readonly COLOR_DARK="\e[90m"
readonly COLOR_BG_BLUE="\e[44m"
readonly COLOR_BG_GREEN="\e[42m"
readonly COLOR_BG_DARK="\e[100m"

func::proviscript_msg() {
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

func::proviscript_welcome() {
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

func::proviscript_thanks() {
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

func::component_welcome() {
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
        "mysql")
            echo "  __  __           ____     ___    _      ";
            echo " |  \/  |  _   _  / ___|   / _ \  | |     ";
            echo " | |\/| | | | | | \___ \  | | | | | |     ";
            echo " | |  | | | |_| |  ___) | | |_| | | |___  ";
            echo " |_|  |_|  \__, | |____/   \__\_\ |_____| ";
            echo "           |___/                         ${2}  ";
        ;;
    esac
}

# https://gist.github.com/l5x/8cf512c6d64641bde388
# Based on https://gist.github.com/pkuczynski/8665367

func::parse_yaml() {
    local prefix=$2
    local s
    local w
    local fs
    s='[[:space:]]*'
    w='[a-zA-Z0-9_]*'
    fs="$(echo @|tr @ '\034')"
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
    awk -F"$fs" '{
    indent = length($1)/4;
    vname[indent] = $2;
    for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
            vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
            printf("%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, $3);
        }
    }' | sed 's/_=/+=/g'
}

func::os_name() {
    eval $(cat /etc/lsb-release)
    echo ${DISTRIB_ID}
}

func::os_release_number() {
    eval $(cat /etc/lsb-release)
    echo ${DISTRIB_RELEASE}
}
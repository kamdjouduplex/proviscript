#!/usr/bin/env bash
#>                           +------------------+
#>                           |  proviscript.sh  |   
#>                           +------------------+
#-
#- SYNOPSIS
#-
#-    proviscript.sh [-h] [-i] install
#-
#- OPTIONS
#-
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    -p, --print-config   Print config variables, for debug
#-
#+
#+ IMPLEMENTATION:
#+
#+    version    1.01
#+    copyright  https://proviscript.sh/
#+               https://github.com/Proviscript
#+    license    GNU General Public License
#+    authors    Terry Lin (terrylinooo)
#+
#==============================================================================
set -eux
set -o pipefail

export PROVISCRIPT=main
export PROVISCRIPT_DIR=$(dirname $(readlink -f $0))

# Load base functions
source "${PROVISCRIPT_DIR}/inc/functions.sh"

_PROVI=false

readonly OS_NAME="$(func::os_name)"
readonly OS_RELEASE_NUMBER="$(func::os_release_number)"
readonly OS_DIST="${OS_NAME}_${OS_RELEASE_NUMBER}"

if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
        case "$1" in
            # Help
            "-h"|"--help")
                show_script_help
                exit 1
            ;;
            # Info
            "-i"|"--information")
                show_script_information
                exit 1
            ;;
            # Print config variables, debug
            "-p"|"--print-config")
                func::parse_yaml config.yml
                exit 1
            ;;
            "install")
                _PROVI=true
                shift 1
            ;;
        esac
    done
fi

if [ ${_PROVI} == true ]; then
    # Load config settings
    eval $(func::parse_yaml config.yml)

    case "${OS_NAME}" in
        "Ubuntu") ;;
        *)
            func::func::proviscript_msg warning "Sorry! Proviscript currently does't support your OS, please watch us on GitHub for further update."
            exit 1
        ;;
    esac

    # Show welcome message
    functions::func_proviscript_welcome

    # Load components
    for component in ${install[@]}; do
        eval "component_name=(\$config_${component}_name)"
        eval "component_version=(\$config_${component}_version)"
        export PACKAGE_VERSION=${component_version}

        if [ "${component_name}" == "php-fpm" ]; then
            export PHP_MODULES=${config_php_modules}
        fi

        if [ "${component_name}" == "mariadb" ]; then
            export MYSQL_ROOT_PASSWORD=${config_mariadb_password}
            export MYSQL_SECURE=${config_mariadb_secure}
            export MYSQL_REMOTE=${config_mariadb_remote}
            export MYSQL_REMOTE_USER=${config_mariadb_remote_user}
            export MYSQL_REMOTE_PASSWORD=${config_mariadb_remote_password}
        fi

        # Load component script
        source "${PROVISCRIPT_DIR}/components/${OS_DIST}/${component_name}.sh"

    done

    # Show thanks message
    func::func_proviscript_thanks

    unset PROVISCRIPT
    unset PROVISCRIPT_DIR
fi
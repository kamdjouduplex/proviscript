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
            # Show welcome message (test)
            "--welcome")
                func::proviscript_welcome
                exit 1
            ;;
            # Show thanks message (test)
            "--thanks")
                func::proviscript_thanks
                exit 1
            ;;
            "init")
                _INIT=true
                shift 1
            ;;
            "install")
                _PROVI=true
                shift 1
            ;;
        esac
    done
fi

if [ "${_INIT}" == "true" ]; then
    func::proviscript_welcome
    func::proviscript_msg info "Copy components/${OS_DIST,,}/config.yml to current folder..."
    sudo cp components/${OS_DIST,,}/config.yml config.yml

    if [ $? -eq 0 ]; then
        func::proviscript_msg success "Configuration file config.yml is ready."
        func::proviscript_msg success "Please edit config.yml to choose which packages to install."
        echo
    else
        func::proviscript_msg warning "Configuration file config.yml is not ready."
        func::proviscript_msg warning "Proviscript currently does't support your OS, please watch us on GitHub for further update."
        echo
    fi
    exit 2
fi

if [ "${_PROVI}" == "true" ]; then
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
    func::proviscript_welcome

    # Install component packages
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
        source "${PROVISCRIPT_DIR}/components/${OS_DIST,,}/${component_name}.sh"
    done

    # Show thanks message
    func::proviscript_thanks

    unset PROVISCRIPT
    unset PROVISCRIPT_DIR
fi
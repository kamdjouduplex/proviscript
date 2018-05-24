#!/usr/bin/env bash
#>                   +------------------+
#>                   |  proviscript.sh  |   
#>                   +------------------+
#-
#- SYNOPSIS
#-
#-    proviscript.sh [-h] [-i]
#-
#- OPTIONS
#-
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
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
#================================================================

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
        esac
    done
fi

export PROVISCRIPT=main
export PROVISCRIPT_DIR=$(dirname $(readlink -f $0))

# Load basic functions
source "${PROVISCRIPT_DIR}/inc/functions.sh"

# Show welcome message
func_proviscript_welcome

# Load components

#linux_distribution="ubuntu_16.04"
#source "${PROVISCRIPT_DIR}/components/${linux_distribution}/nginx.sh"
#source "${PROVISCRIPT_DIR}/components/${linux_distribution}/php-fpm.sh"
#source "${PROVISCRIPT_DIR}/components/${linux_distribution}/mariadb.sh"

# Show thanks message
func_proviscript_thanks

unset PROVISCRIPT
unset PROVISCRIPT_DIR
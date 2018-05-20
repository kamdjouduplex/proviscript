#!/usr/bin/env bash
export PROVISCRIPT=main
export PROVISCRIPT_DIR=$(dirname $(readlink -f $0))

# Load basic functions
source "${PROVISCRIPT_DIR}/inc/functions.sh"

# Show welcome message
func_proviscript_welcome

# Load components

linux_distribution="ubuntu_16.04"
source "${PROVISCRIPT_DIR}/components/${linux_distribution}/nginx.sh"
source "${PROVISCRIPT_DIR}/components/${linux_distribution}/php-fpm.sh"
source "${PROVISCRIPT_DIR}/components/${linux_distribution}/mariadb.sh"

# Show thanks message
func_proviscript_thanks

unset PROVISCRIPT
unset PROVISCRIPT_DIR
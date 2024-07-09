#!/bin/bash

# Define variables
SETUP_DIR="$BONITA_HOME/setup"
PLATFORM_CONF_DIR="$SETUP_DIR/platform_conf/current"
SECURITY_CONFIG_FILE="$PLATFORM_CONF_DIR/platform_portal/security-config.properties"

# Descarga la configuración actual
bash $SETUP_DIR/setup.sh pull

# Modifica el archivo de configuración
sed -i 's/^security.csrf.cookie.secure=.*/security.csrf.cookie.secure=true/' $SECURITY_CONFIG_FILE

# Sube la configuración modificada
bash $SETUP_DIR/setup.sh push
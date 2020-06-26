#!/bin/bash

# Udmurt Linux Locale installation script.
# Files affected:
# - /etc/locale.gen
# - /usr/share/i18n/locales/udm_RU
# - /usr/share/locale/locale-archive

directory=$(dirname "$0")

echo "$(tput setaf 15)Install Udmurt locale$(tput sgr0)"

# Generate locale
echo "[1/2] Compiling locale..."
sudo localedef -i "$directory"/udm_RU -f UTF-8 udm_RU.UTF-8 -c $localedef_params
if ! [ $? -eq 0 ];
then
  echo "$(tput setaf 1)Error$(tput sgr0)";
  exit;
fi

# Copy locale
echo "[2/2] Copying the locale..."
sudo cp "$directory"/udm_RU /usr/share/i18n/locales
if ! [ $? -eq 0 ];
then
  exit;
fi

# Register locale in /etc/locale.gen
# If there will be an update of glibc `locale-gen` will remove the locale
# unless it is listed there.
if ! grep "udm_RU.UTF-8" /etc/locale.gen >/dev/null;
then
  sudo sh -c 'echo "udm_RU.UTF-8 UTF-8" >> /etc/locale.gen';
fi

echo "$(tput setaf 2)Done!$(tput sgr0)"

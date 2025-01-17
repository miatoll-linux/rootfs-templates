#!/bin/sh
# Setup hostname
echo $1 > /etc/hostname
echo "127.0.0.1 $1" >> /etc/hosts

# Generate locales (only en_US.UTF-8 for now)
sed -i -e '/en_US\.UTF-8/s/^# //g' /etc/locale.gen
locale-gen

# Change plymouth default theme
plymouth-set-default-theme mobian

# Load phosh on startup if package is installed
if [ -f /usr/bin/phosh-session ]; then
    systemctl enable phosh.service
fi

if [ -f /usr/bin/cutie-ui-io ]; then
    systemctl enable cutie-ui-io.service
fi

if [ -f /usr/bin/cutie-settings-daemon ]; then
    systemctl enable cutie-settings-daemon.service
fi

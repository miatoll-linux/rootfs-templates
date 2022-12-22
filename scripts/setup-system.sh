#!/bin/sh
# Setup hostname
echo $1 > /etc/hostname
echo "127.0.0.1 $1" >> /etc/hosts

# Generate locales (only en_US.UTF-8 for now)
sed -i -e '/en_US\.UTF-8/s/^# //g' /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF8

# Change plymouth default theme
plymouth-set-default-theme mobian

# Load phosh on startup if package is installed
if [ -f /usr/bin/phosh ]; then
    systemctl enable phosh.service
fi

if [ -f /usr/bin/cutie-ui-io ]; then
    systemctl enable cutie-ui-io.service
fi

if [ -f /usr/bin/cutie-settings-daemon ]; then
    systemctl enable cutie-settings-daemon.service
fi

rm -f /etc/systemd/system/android-service@hwcomposer.service.d/20-phosh.conf

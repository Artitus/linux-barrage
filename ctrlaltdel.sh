#!/bin/bash


if [ $Distribution = "debian" ]; then
    del /lib/systemd/system/ctrl-alt-del.target
    ln -s /dev/null /lib/system/system/ctrl-alt-del.target
    systemctl daemon-reload
    log master "SUCCESS: ctrl+alt+del disabled"
elif [ $Distribution = "ubuntu" ]; then
    del /etc/init/control-alt-delete.conf
    cp -f ./data/ctrlaltdel/control-alt-delete.conf /etc/init/
    log master "SUCCESS: ctrl+alt+del disabled"
else
    error master "CONFIG_ERROR: ctrlaltdeh.sh distribution value invalid"
fi
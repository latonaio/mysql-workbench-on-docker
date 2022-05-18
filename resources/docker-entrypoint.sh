#!/bin/bash

eval `dbus-launch --auto-syntax`
/usr/bin/mysql-workbench "$@"

#!/bin/bash

VC="/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt"
VOLUME="/Volumes/ziga-secure"

unmount_volume() {
    while test -d $VOLUME; do echo "Volume mounted"; sleep 5; done
    sleep 1
    $VC --dismount
}

$VC --dismount
$VC --text --protect-hidden=no --keyfiles "" --pim 0 --mount ~/Dropbox/Secure/ziga-secure.hc $VOLUME
unmount_volume &

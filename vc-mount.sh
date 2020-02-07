#!/bin/bash

# Script to mount a VeraCrypt volume inside Dropbox.  Assumes the VeraCrypt file container
# is stored in ~/Dropbox/Secure/$USER-secure.hc.  It will be mounted in /Volumes/$USER-secure.

VC="/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt"
IMAGE="$HOME/Dropbox/Secure/$USER-secure.hc"
VOLUME="/Volumes/$USER-secure"

# If the volume is umounted using the eject button in Finder, we have to explicitly Dismount it
# in VeraCrypt too, to trigger a Dropbox sync.
volume_unmount_monitor() {
    # Wait for the mount point to disappear (i.e. volume was ejected).
    while test -d $VOLUME; do sleep 1; done
    sleep 1
    # Dismount the volume using VeraCrypt.  If it's already dismounted, ignore the error.
    $VC --text --dismount $IMAGE &> /dev/null
}

$VC --text --protect-hidden=no --keyfiles "" --pim 0 --mount $IMAGE $VOLUME

# Start a background function to monitor for improperly unmounted volumes.
volume_unmount_monitor &

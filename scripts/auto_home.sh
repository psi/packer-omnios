#!/bin/bash
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.


# Replaces /etc/auto_home with a script that automatically creates home
# directories

if [[ $UID != 0 ]]; then
    echo This script must be run as root
    exit
fi

while getopts "f" opt; do
    case $opt in
      f)
         FORCE=1
         ;;
      *)
         echo "Valid option is -f to force overwriting even if target is already a script."
         exit 1
         ;;
    esac
done

if [[ -z ""`grep '^#!/' /etc/auto_home` || -n FORCE ]]; then
    echo "Converting /etc/auto_home into a script"
    cp /etc/auto_home /etc/auto_home.orig
    cat > /etc/auto_home <<'EOF'
#!/bin/bash
# Script to automatically create home directories on demand, and mount them
# from BASE (default /export/home)
BASE=/export/home
ID=$(/bin/id $1 2>/dev/null)
if [[ -n "$ID" ]]; then
    if [[ ! -d "$BASE/$1" ]]; then
        DSET=$(/usr/sbin/zfs list -H -o mountpoint,zoned,name | gawk -v base=$BASE -v zone=$(zonename) '$1==base && ( $2=="off" || zone != "global" ) { print $3 }')
        if [[ -n "$DSET" ]]; then
            /usr/sbin/zfs create $DSET/$1
        else
            /bin/mkdir -p $BASE/$1
        fi
        cat > $BASE/$1/.bash_profile <<'EOF1'
PATH="/usr/ccs/bin:/usr/sfw/bin:/usr/gnu/bin:/usr/bin:/usr/sbin:/opt/omni/bin:/opt/OMNIperl/bin"
MANPATH=/usr/share/man:/opt/omni/share/man:/opt/omni/man
EDITOR=vi
PS1='\u@\h:\w\$ '
export PATH MANPATH EDITOR PS1

[[ $TERM == 'xterm' ]] && export TERM=dtterm
[[ $TERM == 'xterm-color' ]] && export TERM=dtterm
[[ -f ${HOME}/.bashrc ]] && . ${HOME}/.bashrc
EOF1
        cat > $BASE/$1/.vimrc <<'EOF2'
set nocompatible backspace=2
set expandtab
set sts=4
set sw=4
syntax enable
EOF2
        /bin/chown -R $1 $BASE/$1
    fi
    echo "localhost:$BASE/$1"
fi
EOF
    chmod +x /etc/auto_home
    /usr/sbin/svcadm refresh autofs
    echo "Done. The old file has been backed up to /etc/auto_home.orig"
else
    echo "/etc/auto_home is already a script. Skipping conversion"
fi

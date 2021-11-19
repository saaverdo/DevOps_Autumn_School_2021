#!/bin/bash

# bsv

err_exit(){
    echo "Error: $ERR_MSG" >&2
    echo "-------------------------------------" >&2
    echo "You must run this programm under the root priviledges" >&2
    echo "and provide 2 arguments: <username> and <directory>" >&2
    echo "<username> - should be existing user in your OS" >&2
    echo "<directory> - should be correct path to the existing directory, not file" >&2
    echo "Example:" >&2
    echo "sudo ./chowner.sh carmic ~/coala" >&2
    exit 1
}

if [ $EUID -ne 0 ]; then
    ERR_MSG="User is not root" 
    err_exit;
elif [ $# -ne 2 ]; then
    ERR_MSG="wrong number of arguments"
    err_exit;
elif [ ! $(id -u $1) ] ; then 
    ERR_MSG="user $1 does not exist"
    err_exit;
elif [ ! -d $2 ]; then 
    ERR_MSG="$2 is not directory"
    err_exit;
fi

chown -R $1:$1 $2

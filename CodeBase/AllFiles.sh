#!/bin/bash
# Code to copy all files to a client ...
# make sure you all all fiels required here ...

function getFile { # remote path and local path
  sftp $sshHost:$1 $2 || echo "Error getting file $1 as $2"
}

function getExec { # remote path and local path
  sftp $sshHost:$1 $2 && chmod 777 $2 || echo "Error getting executable $1 as $2"
}

where = "/Codebase" # where the files areon the server relative to user directory ...

# get the necessary files
getFile $where/sshHost sshHost
getExec $where/Version.sh Version.sh
getExec $where/AllFiles.sh AllFiles.sh

# get the executable Python files
getFile $where/*.py .
chmod 777 ./*.py

mkdir MonitorWall
getFile $where/MonitorWall/*.py MonitorWall
chmod 777 ./*MonitorWallpy

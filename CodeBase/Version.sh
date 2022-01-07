#!/bin/bash
# Version script
# This can be called on a machine to start the main program from a code base ...
# When called as anything but Version.sh:
#   returns the current version
# When called as Vesrion.sh:
#   requests the remote version of Version.sh as a new temp script name
#   calls that version of Vesrion.sh script to get the remote version and compares versions
#   if the versions are different it initiates clone of remote verion of codebase
#   ititiates the main program from the code base

version="V0.2" # change this for a new version
properName="./Version.sh" # if run from the same directory as this file (code base?)
sshHost=$(cat sshHost) # get host used by this machine and hide from prying eyes!

# these require setting up ssh public / private key authorization ...

function copyFile { # just one path ..
  sftp $sshHost:$1 $1 || echo "Error copying file $1"
}

function getFile { # remote path and local path
  sftp $sshHost:$1 $2 || echo "Error getting file $1 as $2"
}

function copyExec { # just one path ..
  sftp $sshHost:$1 $1 && chmod 777 $1 || echo "Error copying executable $1"
}

function getExec { # remote path and local path
  sftp $sshHost:$1 $2 && chmod 777 $2 || echo "Error getting executable $1 as $2"
}

function startApp { # command to start things off
  python3 Main.py
}

function inportCode {
  # Import new version of code base
  dest='/tmp/CodeBase'

  # clear the temp directory
  rm -rf $dest

  # get the copy grogram
  getExec CodeBase/AllFiles.sh $dest/AllFiles.sh

  # swap to temp directory and copy all the files
  push=$(pwd)
  cd $dest
  ./AllFiles.sh

  # swap back and copy into local code base
  cd $push
  cp -rf $dest/* .
}

function versionCheck {
  # echo "Import server Version.sh as /tmp/version ..."
  getExec CodeBase/Version.sh /tmp/version
  # echo "Get version of server code base"
  newVersion=$(/tmp/version) # get it's version
  [ $1 != $newVersion ] && importCode
  startApp
}

# if we are not the "proper" version, just return our version number
# if we are the real one, then check for code changes and then execute the main app ...
[ $0 != $properName ] && echo "$version" || versionCheck $version


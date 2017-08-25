#!  /bin/bash

# Behat Commands

# Test all suites (default)
function bh {
  pushd $BEHAT_ROOT > /dev/null
  bin/behat $@
  popd > /dev/null
}

# Test a single suite in pretty format (first arg is suite name)
function bhs {
  pushd $BEHAT_ROOT > /dev/null
  bin/behat -s $@
  popd > /dev/null
}

# Test a single suite with progress format (first arg is suite name)
function bhsp {
  pushd $BEHAT_ROOT > /dev/null
  bin/behat -fprogress -s$@
  popd > /dev/null
}

# Append snippets to context class for a suite (first arg is suite name)
function bhapp {
  pushd $BEHAT_ROOT > /dev/null
  bin/behat --append-snippets -s $@
  popd > /dev/null
}

# List files for named behat suite
function bhslist {
  pushd $BEHAT_ROOT > /dev/null
  php ~/bin/suitefiles.php $1 | perl -pe 'tr/ /\n/s'
  popd > /dev/null
}

# Behat suite editing (edits all features and contexts for a defined suite)
function vibh {
  pushd $BEHAT_ROOT > /dev/null
  vi $(php ~/bin/suitefiles.php $1)
  popd > /dev/null
}

# Serverless commands

# Invokes function live in AWS
# arg1 is short function name, arg2 is mock event file.
function invoke {
  pushd $SLS_PROJECT_ROOT > /dev/null
  CMD="serverless invoke --function=$1"
  if [ ! -z "$2" ]; then
    CMD="${CMD} --path=events/$2"
  fi
  $CMD
  popd > /dev/null
}

function sls-logs {
  pushd $SLS_PROJECT_ROOT > /dev/null
  CMD="serverless logs --function=$1"
  $CMD
  popd > /dev/null
}

# Invokes function locally from filesysteme AWS
# arg1 is short function name, arg2 is mock event file.
function iloc {
  pushd $SLS_PROJECT_ROOT > /dev/null
  SLS_DEBUG=1 serverless invoke local --function=$1 --path=$2
  popd > /dev/null
}

# Deploys entire stack to AWS
function deploy {
  pushd $SLS_PROJECT_ROOT > /dev/null
  serverless deploy --verbose
  popd > /dev/null
}

# Deploys single function to AWS
# arg1 is short function name
function deployf {
  pushd $SLS_PROJECT_ROOT > /dev/null
  serverless deploy function -v --function=$1
  popd > /dev/null
}

# Removes entire stack from AWS
function remove {
  pushd $SLS_PROJECT_ROOT > /dev/null
  serverless remove --verbose
  popd > /dev/null
}

# Function editing (edits all .js files within a function package)
function vijs {
  pushd $SLS_PROJECT_ROOT > /dev/null
  vi "functions/$1/handler.js" $(find "functions/$1/node_modules/cscu" -name \*.js) serverless.yml custom.yml
  popd > /dev/null
}

# List files for named behat suite
function jslist {
  pushd $SLS_PROJECT_ROOT > /dev/null
  find "functions/$1" -name \*.js
  popd > /dev/null
}

function fgil {
  if [ -d "$1" ]
  then
    find $1 -type f -exec grep -il "$2" {} \;
  else
    find . -type f -exec grep -il "$1" {} \;
  fi
}

function vifgil {
  vi $(fgil "$@")
}


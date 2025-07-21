#!/bin/sh

# CONFIG
BASH_FUNCTION_DIR=/$HOME/Dev/bash/docknroll
CODE_DIR=$HOME/Dev/django/appname
KEY_FILE=$CODE_DIR/_aws/appname.pem
REMOTE_SERVER_CONNECTION_STRING=ec2-user@ec2-123-123-123-123.eu-west-2.compute.amazonaws.com

echo $HOSTNAME
cd "$(dirname "$0")"    # This makes the script switch into the directory it lives in before running any other commands 

source $BASH_FUNCTION_DIR/terminal_functions.sh
open_live_terminal_window "cd $CODE_DIR && sleep 5 && ssh -i '$KEY_FILE' $REMOTE_SERVER_CONNECTION_STRING"
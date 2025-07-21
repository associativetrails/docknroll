#!/bin/sh

# CONFIG
BASH_FUNCTION_DIR=$HOME/Dev/bash/docknroll
CODE_DIR=$HOME/Dev/django/appname
DJANGO_SERVER_CONTAINER_NAME=web
LOCALHOST=https://appname.local:8000/login
USEFUL_LINKS=(
	"https://getbootstrap.com"
	"https://docs.djangoproject.com"
	"https://fontawesome.com/icons?d=gallery"
	"https://jsonformatter.curiousconcept.com/"
	"https://portal.azure.com/#home"
	"https://eu-west-2.console.aws.amazon.com/console/home?region=eu-west-2"
)


# HOUSEKEEPING
echo $HOSTNAME										
cd "$(dirname "$0")"								# This makes the script switch into the directory it lives in before running any other commands 
source $BASH_FUNCTION_DIR/docker_functions.sh		# Load external functions
source $BASH_FUNCTION_DIR/terminal_functions.sh		# Load external functions


# CHECK DOCKER DESKTOP IS RUNNING AND STOP ANY CURRENT CONTAINERS
is_docker_running     # from docker_functions.sh
stop_all_containers   # from docker_functions.sh


# FIRE UP DOCKER CONTAINERS
docker-compose up -d


# MAKE SURE OUR CONTAINERS ARE RUNNING AND THE DJANGO DEV SERVER IS READY
check_all_containers_running    							# from docker_functions.sh
wait_for_django_server $DJANGO_SERVER_CONTAINER_NAME      	# from docker_functions.sh


# OPEN BROWSERS - DEV SITE IN FIREFOX, USEFUL LINKS IN CHROME
open -a firefox -g $LOCALHOST & disown
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "${USEFUL_LINKS[@]}" & disown


# OPEN APPLICATIONS
open -a "Visual Studio Code" $CODE_DIR & disown
open -a postico & disown
open -a scout-app & disown
open -a "Microsoft Outlook" & disown
open -a "SnippetsLab" & disown 


# OPEN FINDER WINDOW AT CODE DIRECTORY
open $CODE_DIR


# OPEN TERMINAL WINDOW AND RUN TESTS
open_local_testing_terminal_window "cd $CODE_DIR && sleep 5 && docker-compose exec $DJANGO_SERVER_CONTAINER_NAME ./manage.py test"

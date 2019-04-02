#!/bin/bash

## File: ISLE_docker_compose/isle-docker-compose.sh
## Created 30-Mar-2019
## Mark A. McFate - Grinnell College Libraries
##
## Usage: ./isle-docker-compose
## The script must be eXecutable. To create a `./isle-docker-compose` "command" use:
##    chmod u+x isle_docker_compose/isle-docker-compose.sh
##    ln -s isle-docker-compose isle_docker_compose/isle-docker-compose.sh
##
## This bash script provides an ISLE-specific substitution for the standard
##   'docker-compose up -d' command.  It finds any/all files with a path of
##   the form './ISLE_docker_compose/ORDER_PROJECT/docker-compose.NAME.yml`
#    and appends them, in ORDER, to the standard
##   'docker-compose up -d' command.
##
## See https://docs.docker.com/compose/extends/ for an explanation of using
##   multiple 'docker-compose.yml' files in this manner.
##
## `ORDER` must be 2-characters, preferably a positive integer (like '00', '01',
##   '10', etc.).  It will be used to determine the order of inclusion of the
##   .yml files.  `PROJECT` and `NAME` can be any descriptive text you like;
##   but NO spaces please.

## Pull in the .env file variable definitions.
source ./.env

## Begin with the base `docker-compose` command
command='docker-compose -f docker-compose.yml'

## Find any/all `docker-compose.ORDER.NAME.yml` files one directory below the
## working directory, and append them, in ORDER order, to $command.
printf "Looking for any 'ORDER_PROJECT/docker-compose.NAME.yml' paths in './ISLE_docker_compose'.\n"
found=0
for file in ./ISLE_docker_compose/??_*/docker-compose.*.yml; do
  if [ -f "$file" ]; then
    command+=" -f $file"
    found=1
    printf "  Found $file.  Command is now: $command\n"
  fi
done

if [ ${found} -eq 0 ]; then
  printf "No additional './ISLE_docker_compose/ORDER_PROJECT/docker-compose.NAME.yml' files found.\n"
else
  printf "One or more additional 'docker-compose.NAME.yml' files were found.\n"
fi

## Append the `-d` option to $command and execute it.
command+=' up -d'
printf "\nFinal command is '$command'.  Executing it now...\n\n"
eval $command
printf "\nisle-docker-compose is done, but containers may take a minute to completely spin up.\n"

## Instruct the user how to proceed...
printf "\nIf this is the first time you've created this ISLE instance, you may want to run\n"
printf "  time docker exec -it isle-apache-${CONTAINER_SHORT_ID} bash ./utility-scripts/isle_drupal_build_tools/isle-islandora-installer.sh\n"
printf "to complete the installation of Drupal/Islandora components.\n\n"

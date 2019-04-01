# ISLE_docker_compose

This project provides a *bash* script that allows an ISLE admin to select and engage customization to ISLE using a relatively simple, structured approach. The script, `isle-docker-compose.sh` basically uses a "hook" approach by looking for files on an ISLE host in any directory one level below an institution's root ISLE folder, where `docker-compose.yml` exists. The script scans all such directories for files that fit the naming convention of: docker-compose.ORDER.NAME.yml. It subsequently builds and executes a command of the form:

docker-compose -f docker-compose.yml -f docker-compose.00.name00.yml -f docker-compose.01.name1.yml -f docker-compose.XX.nameXX.yml up -d

Comments within the script provide a little more detail.  Note that this project name contains *underscores*, because it is a *directory*, while the script name itself uses *dashes*, because it is a *single file*.

## Additional Requirements

  - Navigate to the host directory where ISLE is installed, the host directory where `docker-compose.yml` exists.  Probably something like: `cd /opt/ISLE`.
  - Add this project to ISLE using: `git clone https://github.com/DigitalGrinnell/ISLE_docker_compose.git`
  - Ensure that the *bash* script is executable with: `chmod u+x ./ISLE_docker_compose/isle-docker-compose.sh`.
  - Create a symbolic link in the same folder using: `ln -s ./ISLE_docker_compose/isle-docker-compose.sh isle-docker-compose`. Adding this link will essentially define/create a new `isle-docker-compose` command for the ISLE admin to use.

## Example Use

Once installed this feature would enable sysadmins to add properly structured features using a procedure like the following example. This example assumes that ISLE is installed on a host in the `/opt/ISLE` directory. It engages the GitHub project https://github.com/DigitalGrinnell/cleanup_in_ISLE_one_please.

cd /opt/ISLE/ISLE_docker_compose
## Clone the feature/project to be implemented.  Repeat this for as many features/projects as you like.
git clone https://github.com/DigitalGrinnell/cleanup_in_ISLE_one_please.git
## Do a `docker-compose up -d` with your new feature included
./isle-docker-compose

## Available Projects / Features
Updated:  01-Apr-2019

| Repository URL | Purpose |
| https://github.com/DigitalGrinnell/cleanup_in_ISLE_one_please.git | Obliterates some unnecessary cruft in ISLE's FEDORA container |
| https://github.com/DigitalGrinnell/web_auth_traefik_portainer.git | Provides an authentication challenge for ISLE's Traefik and Portainer dashboards |

docker-shell
============

Interactive shell for progressive creation of docker images.

## Usage ##

Run inter.sh 

## Documentation ##

A simple script that acts like a regular shell but creates a Docker container with the command input. The container is then committed to create a new image.  This image is then used as the starting point for the next command input. In this way a sequence of Docker containers and corresponding images are created tracking a users commands.

## Concept ##

The idea is a system for capturing or recording a sucession of images that each capture a step in a series of commands. This facilitates exploration of the the command line as a workflow.  

## License ##

MIT: http://rem.mit-license.org

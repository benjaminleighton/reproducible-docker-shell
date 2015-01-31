# Docker Shell for Reproducible Workflows

This provides an interactive docker shell into an Ubuntu container that records user commands into a Dockerfile on the host. Keword commands within the interactive docker shell build the produced Dockerfile on the host into a new container and thus rexecute a serious of recorded commands. When this occurs a test is executed to check to see if the produced container satisfies some reproducibility test. 

# Prerequistes

* Docker 

# Usage

Run `sudo su` to become as superuser

Run `./reproduce.sh` to enter the interactive docker shell 

In the interactive docker shell execute commands as desired. Commands will be captured in a Dockerfile on the host Dockerfile_day_month_year_hour_minute_second

In the interactive docker shell run `SHA [filename]` to trigger a build of the host Dockerfile and run the sha1sum command on filename in a container from the produced image. The interactive shell will report whether the files matched between the containers. 

# More Details

This is the beginning of a system that I hope will provide a flexible and lightweight way of capturing and ensuring reproducibility of a wide range of bash and linux workflows. At the moment the 

# Limitations and Future work

The only keyword at the moment is `SHA`. Hopefully soon more generic tests keywords will be executed so that non deterministic builds processes can be compared. Ultimately what constitutes a sucessfully reproduced workflow varies between use cases. More flexible testing should allow for arbitary tests to be executed between containers.  

The interactive docker shell captures commands and can detect when working directories change and make the corresponding workdirectory changes in the Dockefile. It doesn't capture and persist enviornment variables between commands in the produced Dockerfile yet. This should be possible by monitoring the enviornment.  

# Authors

Ben Leighton

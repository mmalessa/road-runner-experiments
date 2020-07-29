# How to install dockerized Symfony kickstart


```shell script
#!/bin/bash

# create directory 'kickstart' and entry into it
mkdir kickstart
cd kickstart

# install symfony using composer
docker run --rm --interactive --tty --user $UID --volume $PWD:/app composer create-project symfony/skeleton .

# add some dockerization
git init
git remote add origin git@gitlab.performance-media.pl:utils/kickstart.git
git pull origin master
git remote rm origin
# if you wish to remove all git history
# rm -rf .git
```

# How to use it
```shell script
# To build image
make build

# To start image
make up

# To go to application console
make console


# To clean up
make clean 
```

# Configuration for new project
1. Setup **Makefile**: `ALIAS`, `BUILD_IMAGE_CLI`, `BUILD_IMAGE_FPM`.
2. Setup **.docker/.env**: `ALIAS`, `DEV_IMAGE`.
Comment unnecessary services for your project.
3. Add your `ALIAS` to all services in docker-compose.yaml like:
```bash
# template services in docker-compose.yaml:
services:
  grafana:
    [...]
  nginyx:
    [...]
  database-mysql:
    [...]
[...]
# use your ALIAS and change all services like this:
services:
  xxxxx-grafana:
    [...]
  xxxxx-nginyx:
    [...]
  xxxxx-database-mysql:
    [...]
[...]
```
4. Install symfony project in container.


###### If your image need ssh-key to get package from company repository
uncomment this in Makefile, and comment previous target "build-prod"
```bash
#build-prod:	## Build prod image with private key
#	@docker build -t $(IMAGE)-cli:$(TAG)                       \
#		-t $(IMAGE)-cli:latest                                 \
#		--build-arg BASE_IMAGE=$(REGISTRY)/$(BASE_IMAGE_FPM)   \
#       --build-arg SSH_PRIVATE_KEY="${PRIVATE_KEY}" .
```

uncomment this in production Dockerfile
```
#RUN apt-get update && apt-get install -y git openssh-client
#
#RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
#
#ARG SSH_PRIVATE_KEY
#RUN echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa && \
#    chmod 600 ~/.ssh/id_rsa && \
#    ssh-keyscan gitlab.performance-media.pl > ~/.ssh/known_hosts
```
next, build your image `make build && make build-prod`
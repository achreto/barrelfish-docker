Gitlab based CI with Docker and Barrelfish 
==========================================

This repository sets up the CI test environment to compile and test Barrelfish
code repositories.

Bootstraping
------------

Install docker on your machine. Follow [Docker Documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

TL;DR

```
# remote the old docker
sudo apt-get remove docker docker-engine docker.io
# update apt 
sudo apt-get update
#install dependencies
sudo apt-get install apt-transport-https ca-certificates \
                     curl software-properties-common
# install PGP key of docker                     
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# show the key
sudo apt-key fingerprint 0EBFCD88
# adding docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update  && sudo apt-get install docker-ce 
```

Install Gitlab CI Multi-Runner

```
apt-get update
apt-get install gitlab-ci-multi-runner
```

If this fails, you may need to add the gitlab repository
```
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
```

Build the Docker image
----------------------
Next we can build the image. 
```
docker build -t bf-gitlab-ci-runner .
```

Permission denied:
```
sudo usermod -a -G docker $USER
```


Register Gitlab Runner
----------------------

```
gitlab-ci-multi-runner register -non-interactive\
    --name bf-ci \
    --executor docker \
    --registration-token $TOKEN \
    --limit $LIMIT \
    --url $URL \
    -t $SERVER_TOKEN
```

To find the local docker image, you will need to change the pull policy
of the 

/etc/gitlab-runner vim config.toml 

```
[[runners]]
  [runners.docker]
    pull_policy = "if-not-present"

```

Mounting a local Git Repository
-------------------------------
Add the following to the runners.docker.volumes to mount a path on the host
to a path in docker. It's important to set the mount to be read-only (:ro)

```
[[runners]]
  [runners.docker]
    volumes = ["/path/on/host/git:/git:ro"]
```

This enables to pull changes from this path, without allowing to modify the 
repository.

```
git remote add other /git/other
```

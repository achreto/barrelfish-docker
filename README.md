Gitlab based CI with Docker and Barrelfish 
==========================================

This repository sets up the CI test environment to compile and test Barrelfish
code repositories.

Bootstraping
------------
Install docker on your machine:

```
apt-get update
apt-get -y install docker-engine
```

Install Gitlab CI Multi-Runner

```
apt-get update
apt-get install gitlab-ci-multi-runner
```

Build the Docker image
----------------------
Next we can build the 
```
docker build -t bf-gitlab-ci-runner .
```


Register Gitlab Runner
---------------------
i
```
gitlab-ci-multi-runner register -non-interactive\
    --name bf-ci \
    -- executor docker \
    --registration-token $TOKEN \
    --limit $LIMIT \
    --url $URL \
    -t $SERVER_TOKEN
```



Gitlab based CI with Docker and Barrelfish 
==========================================

This repository sets up the CI test environment to compile and test Barrelfish
code repositories.

Bootstraping
------------
Install docker on your machine:

```
apt-get update
apt-get -y install docker.io 
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
Next we can build the 
```
docker build -t bf-gitlab-ci-runner .
```


Register Gitlab Runner
---------------------

```
gitlab-ci-multi-runner register -non-interactive\
    --name bf-ci \
    -- executor docker \
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


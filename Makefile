
USERNAME=achreto
IMAGE=bf-gitlab-ci-runner
BF_SOURCE=/path/to/barrelfish-src

build: Dockerfile config.pp
	docker build -t $(IMAGE) .

tag:
	docker tag $(IMAGE) achreto/barrelfish-ci

publish: build
	docker tag $(IMAGE) achreto/barrelfish-ci
	docker push achreto/barrelfish-ci

login:
	docker login $(USERNAME)

compile:
	docker run -u $$(id -u) --mount type=bind,source=$(BF_SOURCE),target=/source  $(IMAGE) /bin/sh -c '(cd /source/build && ../hake/hake.sh -s ../ -a armv8)'

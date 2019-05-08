
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

run:
	docker run -u $$(id -u) -i -t \
		--mount type=bind,source=$(CURDIR),target=/source $(IMAGE)

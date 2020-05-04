
USERNAME=achreto
IMAGE=bf-gitlab-ci-runner
BF_SOURCE=/path/to/barrelfish-src

LATEST=18.04-lts

default: build-$(LATEST)


build-20.04-lts: 20.04-lts/Dockerfile config.pp
	docker build -t $(IMAGE):20.04-lts 20.04-lts

build-18.04-lts: 18.04-lts/Dockerfile config.pp
	docker build -t $(IMAGE):18.04-lts 18.04-lts


tag-20.04-lts: build-20.04-lts
	docker tag $(IMAGE):20.04-lts achreto/barrelfish-ci:20.04-lts

tag-18.04-lts: build-18.04-lts
	docker tag $(IMAGE):18.04-lts achreto/barrelfish-ci:18.04-lts


publish-20.04-lts: build-20.04-lts
	docker tag $(IMAGE):20.04-lts achreto/barrelfish-ci:20.04-lts
	docker push achreto/barrelfish-ci:20.04-lts

publish-18.04-lts: build-18.04-lts
	docker tag $(IMAGE):18.04-lts achreto/barrelfish-ci:18.04-lts
	docker push achreto/barrelfish-ci:18.04-lts

publish-latest:build-$(LATEST)
	docker tag $(IMAGE):$(LATEST) achreto/barrelfish-ci
	docker push achreto/barrelfish-ci
	

login:
	docker login $(USERNAME)

run:
	docker run -u $$(id -u) -i -t \
		--mount type=bind,source=$(CURDIR),target=/source $(IMAGE):$(LATEST)

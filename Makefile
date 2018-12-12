
USERNAME=achreto
IMAGE=bf-gitlab-ci-runner

build: Dockerfile
	docker build -t $(IMAGE) .

tag:
	docker tag $(IMAGE) achreto/barrelfish-ci

publish: build
	docker tag $(IMAGE) achreto/barrelfish-ci
	docker push achreto/barrelfish-ci

login:
	docker login $(USERNAME)

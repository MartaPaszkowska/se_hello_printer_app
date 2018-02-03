SERVICE_NAME=hello-world-printer
MY_DOCKER_NAME=$(SERVICE_NAME)

.PHONY: test

deps:
	pip install -r requirements.txt;
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test

test_smoke:
	curl --fail 127.0.0.1:5000

run:
	python main.py

docker_build:
	docker build -t $(MY_DOCKER_NAME) .

docker_run: docker_build
	docker run \
		--name $(MY_DOCKER_NAME)-dev \
		-p 5000:5000 \
		-d $(MY_DOCKER_NAME)

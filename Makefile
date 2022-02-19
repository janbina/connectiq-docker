VERSION := 0.1

all: build 

build:
	@echo "+++ Building docker image +++"
	docker pull ubuntu:20.04
	docker build -t johny/connectiq:$(VERSION) .
	docker tag johny/connectiq:$(VERSION) johny/connectiq:latest

run:
	bash ./run.sh

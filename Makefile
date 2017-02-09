IMAGENAME = gasbuddy/fluentd-elastic

all: build

build:
	docker build -t $(IMAGENAME) .

clean:
	docker images | awk -F' ' '{if ($$1=="$(IMAGENAME)") print $$3}' | xargs -r docker rmi

test:
	docker run --rm --env ELASTICSEARCH_HOST=elastic-search --env ELASTICSEARCH_USERNAME=elastic --env ELASTICSEARCH_PASSWORD=test --name fluentd-test -it $(IMAGENAME)

publish:
	docker push $(IMAGENAME)
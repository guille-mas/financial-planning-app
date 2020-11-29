include .env .secrets
# speed up builds and improve build UI by enabling Docker Buildkit
export DOCKER_BUILDKIT=1

start:
	docker-compose up

stop: 
	docker-compose stop

run:
	@read -p "Write a command to run inside your docker environment: " command; \
		docker-compose run --rm ${PROJECT_NAME} sh -c "$$command"

build:
	docker build -f ./docker/Dockerfile -t guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION} \
		-t guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}-production \
		--target prod \
		--build-arg PORT=${PORT} \
		./${PROJECT_NAME}
	docker build -f ./docker/Dockerfile -t guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}-development \
		--target dev \
		--build-arg PORT=${PORT} \
		./${PROJECT_NAME}

clean:
	docker-compose down --rmi all
	docker image rm -f guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}
	docker image rm -f guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}-production


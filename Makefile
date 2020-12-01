include .env
# speed up builds and improve build UI by enabling Docker Buildkit
export DOCKER_BUILDKIT=1

# start development environment
start:
	docker-compose up

# stop development environment
stop: 
	docker-compose stop

# run any command inside an ephemeral container
run:
	@read -p "Write a command to run inside your docker environment: " command; \
		docker-compose run --rm ${PROJECT_NAME} \
			sh -c "$$command"

# build docker images
build:
	docker build -f ./docker/Dockerfile -t guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION} \
		-t guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}-production \
		--target prod \
		--build-arg PORT=${PORT} \
		--build-arg PROJECT_NAME=${PROJECT_NAME} \
		./${PROJECT_NAME}
	docker build -f ./docker/Dockerfile -t guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}-development \
		--target dev \
		--build-arg PORT=${PORT} \
		--build-arg PROJECT_NAME=${PROJECT_NAME} \
		./${PROJECT_NAME}

# install npm vendors in binded volume
setup:
	# install npm libraries locally from a containerized environment
	docker-compose run --rm ${PROJECT_NAME} npm i

# wipe any docker image and containers
clean:
	docker-compose down --rmi all
	docker image rm -f guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}
	docker image rm -f guillermomaschwitz/${PROJECT_NAME}:${PROJECT_VERSION}-production

# open a bash session inside the container
bash:
	docker-compose exec ${PROJECT_NAME} bash

# deploy to firebase (not working)
deploy:
	(cd ${PROJECT_NAME} && ng deploy)

# push docker image
push:
	docker login -u guillermomaschwitz
	docker push guillermomaschwitz/${PROJECT_NAME}

# production build
ng-build:
	docker-compose run --rm ${PROJECT_NAME} ng build --prod --aot=true --buildOptimizer

.SHELLFLAGS = -ec

COMMIT=$(shell git rev-parse --short HEAD)
IMAGE_NAME="robinnagpal/argo-learning-bar-app:${COMMIT}"

write-commit:
	echo ${COMMIT} > commit.txt

docker-build:
	docker build . -t ${IMAGE_NAME}


docker-push: docker-build
	docker push ${IMAGE_NAME}

update-k8s-deployment:
	yq w -i k8s/bar-deployment.yml 'spec.template.spec.containers.[0].image' ${IMAGE_NAME}

build-develop:
	BUILD_KIT=1 docker build -f docker/Dockerfile.development -t rails-tutorial:develop .
run-develop:
	BUILD_KIT=1 docker run -v $(PWD):/rails-app-tutorial -it rails-tutorial:develop /bin/bash
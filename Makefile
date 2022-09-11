build-develop:
	BUILD_KIT=1 docker build -f docker/Dockerfile.development -t rails-tutorial:develop .
run-develop:
	BUILD_KIT=1 docker run -p 3000:3000 -v $(PWD):/rails-app-tutorial -it rails-tutorial:develop /bin/bash
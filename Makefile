.PHONY: docker_setup

CLOSE_BRACE := )

docker_setup:
	export DOCKERHOST=$$(ifconfig | grep -E "([0-9]{1,3}\.${CLOSE_BRACE}{3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $$2 }' | cut -f2 -d: | head -n1) && docker-compose -f docker-compose.dev.yml up -d

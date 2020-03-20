all: dockerfile-sbc dockerfile-router

dockerfile-sbc:
	docker build --no-cache -t wazopbx/wazo-c4-sbc:latest -f Dockerfile-sbc .

dockerfile-router:
	docker build --no-cache -t wazopbx/wazo-c4-router:latest -f Dockerfile-router .

dockerfile-aio:
	docker build --no-cache -t wazopbx/wazo-c4-aio:latest -f Dockerfile-aio .

.PHONY: dockerfile-sbc dockerfile-router dockerfile-aio

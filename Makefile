ACTION = build --no-cache

all: sbc router

sbc:
	docker $(ACTION) -t wazopbx/wazo-c4-sbc:latest -f Dockerfile-sbc .

router:
	docker $(ACTION) -t wazopbx/wazo-c4-router:latest -f Dockerfile-router .

.PHONY: sbc router

BUILD = build --no-cache
BUILD_PATH = .

all: sbc router

sbc:
	docker $(BUILD) -t wazopbx/wazo-c4-sbc -f Dockerfile-sbc $(BUILD_PATH)

router:
	docker $(BUILD) -t wazopbx/wazo-c4-router -f Dockerfile-router $(BUILD_PATH)

push:
	docker push wazopbx/wazo-c4-sbc
	docker push wazopbx/wazo-c4-router

.PHONY: sbc router push

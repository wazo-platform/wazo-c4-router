ACTION = build --no-cache -t
BUILD_PATH = .

all: sbc router

sbc:
	docker $(ACTION) wazopbx/wazo-c4-sbc -f Dockerfile-sbc $(BUILD_PATH)

router:
	docker $(ACTION) wazopbx/wazo-c4-router -f Dockerfile-router $(BUILD_PATH)

.PHONY: sbc router

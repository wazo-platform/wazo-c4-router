.PHONY: dockerfile
dockerfile:
	docker build -t wazopbx/wazo-c4-router:latest -f Dockerfile .

.PHONY: dockerfilesbc
dockerfilesbc:
        docker build -t wazopbx/wazo-c4-sip-sbc:latest -f Dockerfile.debian .

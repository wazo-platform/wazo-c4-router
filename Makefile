.PHONY: dockerfile
dockerfile:
	docker build -t wazopbx/wazo-c4-router:latest -f Dockerfile .

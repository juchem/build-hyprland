.PHONY: all image build interactive

all: build

image:
	DOCKER_BUILDKIT=1 \
		docker build \
			-t build-hyprland \
				docker

image-from-scratch:
	DOCKER_BUILDKIT=1 \
		docker build \
			-t build-hyprland \
			--no-cache \
				docker

build-from-scratch: image-from-scratch
	docker run -it --rm \
		-v "/tmp/build-hyprland/out:/out" \
		--env-file .env \
			build-hyprland

interactive-from-scratch: image-from-scratch
	docker run -it --rm \
		-v "/tmp/build-hyprland/out:/out" \
		--env-file .env \
		--entrypoint bash \
			build-hyprland

build: image
	docker run -it --rm \
		-v "/tmp/build-hyprland/out:/out" \
		--env-file .env \
			build-hyprland

interactive: image
	docker run -it --rm \
		-v "/tmp/build-hyprland/out:/out" \
		--env-file .env \
		--entrypoint bash \
			build-hyprland

help:
	grep '^[a-zA-Z\-_0-9].*:' Makefile | cut -d : -f 1 | sort

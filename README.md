A self-contained, sandboxed container image that will build and install
[hyprland](https://hypr.land/).

**TL;DR**: build and install latest version under `/usr/local`:
```
# build the builder image:
make image

# build latest `hyprland` using the builder image:
make

# start build environment using the builder image:
# once inside the build environment, run `/srv/entrypoint.sh`
# to build `hyprland`
make interactive
```

The source code for this image can be found at
[juchem/build-hyprland](https://github.com/juchem/build-hyprland).

Choose the version to build by setting environment variables (defaults to
`HEAD` for bleeding edge):
- [`HYPRLAND_VERSION`](https://github.com/hyprwm/Hyprland/tags)

Binaries will be installed into the container's directory `/out`. Mount that
directory with `-v host_dir:/out` to install it into some host directory.

Customize the base installation directory by setting the environment variable
`PREFIX_DIR`. Defaults to `/usr/local`.

Example: build given version and install under `~/opt`:
```
OUT_DIR="$HOME/opt"
mkdir -p "${OUT_DIR}"
# build hyprland using the build image
docker run -it --rm \
    -v "${OUT_DIR}:/out" \
    -e "HYPRLAND_VERSION=v1.2.3" \
    build-hyprland
```

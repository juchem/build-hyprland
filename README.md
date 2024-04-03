A self-contained, sandboxed docker image that will build and install [hyprland](https://github.com/hyprwm/Hyprland).

**TL;DR**: build and install latest version:
```
# build the build image:
make

# build latest `hyprland` using the build image and store binaries in `/tmp/hyprland`:
docker run -it --rm -v /tmp/hyprland:/out build-hyprland
```

The source code for this image can be found at
[juchem/build-hyprland](https://github.com/juchem/build-hyprland).

Binaries will be installed into guest directory `/out`. Mount that directory
with `-v host_dir:/out` to install it into some host directory.

Choose the version to build by setting environment variables (defaults to
`HEAD` for bleeding edge):
- [`HYPRLAND_VERSION`](https://github.com/hyprwm/Hyprland/releases)
- [`HYPRLANG_VERSION`](https://github.com/hyprwm/hyprlang/releases)
- [`HYPRCURSOR_VERSION`](https://github.com/hyprwm/hyprcursor/releases)

Customize the base installation directory by setting the environment variable
`PREFIX_DIR`. Defaults to `/usr/local`.

Example: install under `~/opt` with specific versions:
```
OUT_DIR="$HOME/opt"
mkdir -p "${OUT_DIR}"

# build hyprland using the build image
docker run -it --rm \
    -v "${OUT_DIR}:/out" \
    -e "HYPRLANG_VERSION=v1.2.3" \
    -e "HYPRCURSOR_VERSION=v1.2.3" \
    -e "HYPRLAND_VERSION=v1.2.3" \
    build-hyprland
```

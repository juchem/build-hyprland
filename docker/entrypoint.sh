#!/bin/bash -xe

build_aquamarine() {
  pushd "${AQUAMARINE_SRC}" > /dev/null

  build_version="${AQUAMARINE_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://github.com/hyprwm/aquamarine?tab=readme-ov-file#building
  mkdir -p "${AQUAMARINE_SRC}/build"
  pushd "${AQUAMARINE_SRC}/build" > /dev/null
  (set -x; \
    time cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_BUILD_TYPE=Release \
      --no-warn-unused-cli \
      .. \
    && ninja \
    && ninja install \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprlang() {
  pushd "${HYPRLANG_SRC}" > /dev/null

  build_version="${HYPRLANG_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://github.com/hyprwm/hyprlang?tab=readme-ov-file#building-and-installation
  mkdir -p "${HYPRLANG_SRC}/build"
  pushd "${HYPRLANG_SRC}/build" > /dev/null
  (set -x; \
    time cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_BUILD_TYPE=Release \
      --no-warn-unused-cli \
      .. \
    && ninja \
    && ninja install \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprcursor() {
  pushd "${HYPRCURSOR_SRC}" > /dev/null

  build_version="${HYPRCURSOR_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://github.com/hyprwm/hyprcursor?tab=readme-ov-file#building
  mkdir -p "${HYPRCURSOR_SRC}/build"
  pushd "${HYPRCURSOR_SRC}/build" > /dev/null
  (set -x; \
    time cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_BUILD_TYPE=Release \
      --no-warn-unused-cli \
      .. \
    && ninja \
    && ninja install \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprutils() {
  pushd "${HYPRUTILS_SRC}" > /dev/null

  build_version="${HYPRUTILS_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://github.com/hyprwm/hyprutils?tab=readme-ov-file#building
  mkdir -p "${HYPRUTILS_SRC}/build"
  pushd "${HYPRUTILS_SRC}/build" > /dev/null
  (set -x; \
    time cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_BUILD_TYPE=Release \
      --no-warn-unused-cli \
      .. \
    && ninja \
    && ninja install \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprgraphics() {
  pushd "${HYPRGRAPHICS_SRC}" > /dev/null

  build_version="${HYPRGRAPHICS_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://github.com/hyprwm/hyprgraphics?tab=readme-ov-file#building
  mkdir -p "${HYPRGRAPHICS_SRC}/build"
  pushd "${HYPRGRAPHICS_SRC}/build" > /dev/null
  (set -x; \
    time cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_BUILD_TYPE=Release \
      --no-warn-unused-cli \
      .. \
    && ninja \
    && ninja install \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprwayland_scanner() {
  pushd "${HYPRWAYLAND_SCANNER_SRC}" > /dev/null

  build_version="${HYPRWAYLAND_SCANNER_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://github.com/hyprwm/hyprwayland-scanner?tab=readme-ov-file#building
  mkdir -p "${HYPRWAYLAND_SCANNER_SRC}/build"
  pushd "${HYPRWAYLAND_SCANNER_SRC}/build" > /dev/null
  (set -x; \
    time cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_BUILD_TYPE=Release \
      --no-warn-unused-cli \
      .. \
    && ninja \
    && ninja install \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprland() {
  pushd "${HYPRLAND_SRC}" > /dev/null

  build_version="${HYPRLAND_VERSION}"
  [ -n "${build_version}" ] || build_version="HEAD"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive --depth=1

  # https://wiki.hypr.land/Getting-Started/Installation/#manual
  mkdir -p "${HYPRLAND_SRC}/build"
  pushd "${HYPRLAND_SRC}" > /dev/null
  (set -x; \
    meson setup build \
      --prefix="${PREFIX_DIR}" \
      -Dbuildtype=release \
        -Dxwayland=enabled \
        -Dsystemd=enabled \
        -Duwsm=enabled \
        -Dhyprpm=enabled \
        -Dtracy_enable=false \
    && ninja -C build \
    && ninja -C build install \
  )
  popd > /dev/null

  popd > /dev/null
}

(set -x; apt-get update)
(set -x; apt-get upgrade -y --only-upgrade --no-install-recommends)

rm -rf "${PREFIX_DIR}"

(set -x; build_hyprutils "$@")
(set -x; build_hyprlang "$@")
(set -x; build_hyprcursor "$@")
(set -x; build_hyprgraphics "$@")
(set -x; PREFIX_DIR="/usr" build_hyprwayland_scanner "$@")
(set -x; build_aquamarine "$@")
(set -x; build_hyprland "$@")

rm -rf "${PREFIX_DIR}"/{include,lib/pkgconfig,share/pkgconfig}

cp -R /usr/local/* /out/

cat <<EOF

Successfully built hyprland.
EOF

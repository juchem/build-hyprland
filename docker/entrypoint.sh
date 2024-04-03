#!/bin/bash -xe

build_hyprlang() {
  pushd "${HYPRLANG_SRC}" > /dev/null

  build_version="${HYPRLANG_VERSION:-HEAD}"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive

  # https://github.com/hyprwm/hyprlang?tab=readme-ov-file#building-and-installation
  mkdir "${HYPRLANG_SRC}/build"
  pushd "${HYPRLANG_SRC}/build" > /dev/null
  (set -x; \
    CC='gcc' \
    CXX='g++' \
    LDFLAGS='-static-libstdc++ -static-libgcc' \
      cmake -G Ninja \
        --no-warn-unused-cli \
        -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
        -DCMAKE_BUILD_TYPE=Release \
        .. \
    && time ninja \
    && time ninja install \
    && mv libhyprlang.so* /out \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprcursor() {
  pushd "${HYPRCURSOR_SRC}" > /dev/null

  build_version="${HYPRCURSOR_VERSION:-HEAD}"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive

  # https://github.com/hyprwm/hyprcursor?tab=readme-ov-file#building
  mkdir "${HYPRCURSOR_SRC}/build"
  pushd "${HYPRCURSOR_SRC}/build" > /dev/null
  (set -x; \
    CC='gcc' \
    CXX='g++' \
    LDFLAGS='-static-libstdc++ -static-libgcc' \
      cmake -G Ninja \
        --no-warn-unused-cli \
        -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
        -DCMAKE_BUILD_TYPE=Release \
        .. \
    && time ninja \
    && time ninja install \
    && mv libhyprcursor.so* /out \
  )
  popd > /dev/null

  popd > /dev/null
}

build_hyprland() {
  pushd "${HYPRLAND_SRC}" > /dev/null

  build_version="${HYPRLAND_VERSION:-HEAD}"
  git fetch --depth=1 origin "${build_version}"
  git checkout -b "build-${build_version}-$(date +%s)" FETCH_HEAD
  git clean -xfd
  git submodule update --init --recursive

  # https://wiki.hyprland.org/Getting-Started/Installation/#manual-manual-build
  mkdir "${HYPRLAND_SRC}/build"
  pushd "${HYPRLAND_SRC}/build" > /dev/null
  (set -x; \
    CC='gcc' \
    CXX='g++' \
    LDFLAGS='-static-libstdc++ -static-libgcc' \
      time cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
        -DCMAKE_BUILD_TYPE=Release \
        .. \
    && time ninja \
    && mv Hyprland hyprctl/hyprctl hyprpm/hyprpm \
      ../subprojects/wlroots/build/libwlroots.so ../subprojects/wlroots/build/libwlroots.so.* \
        /out \
  )
  popd > /dev/null

  popd > /dev/null
}

(set -x; apt-get update)
(set -x; apt-get upgrade -y --only-upgrade --no-install-recommends)

(set -x; build_hyprlang "$@")
(set -x; build_hyprcursor "$@")
(set -x; build_hyprland "$@")

cat <<EOF

Successfully built Hyprland.
EOF

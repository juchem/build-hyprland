FROM debian:unstable-slim

#################
# base settings #
#################

ENV DEBIAN_PRIORITY=critical
ENV DEBIAN_FRONTEND=noninteractive

RUN truncate --size=0 /etc/apt/sources.list
COPY debian-testing.list /etc/apt/sources.list.d/
COPY debian-unstable.list /etc/apt/sources.list.d/

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  ca-certificates \
  file cpio coreutils time \
  curl wget git \
  gzip bzip2 xz-utils 7zip \
  gettext gettext-base pkgconf \
  python3 python3-dev \
  build-essential \
  g++ clang clang-format \
  cmake cmake-extras meson ninja-build \
  gdb

# hyprlang repo: https://github.com/hyprwm/hyprlang.git

ENV HYPRLANG_SRC="/src/hyprlang"

RUN mkdir -p "${HYPRLANG_SRC}"
RUN cd "${HYPRLANG_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprlang.git"

# hyprcursor repo: https://github.com/hyprwm/hyprcursor.git

ENV HYPRCURSOR_SRC="/src/hyprcursor"

RUN mkdir -p "${HYPRCURSOR_SRC}"
RUN cd "${HYPRCURSOR_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprcursor.git"

# hyprland repo: https://github.com/hyprwm/Hyprland.git

ENV HYPRLAND_SRC="/src/hyprland"

RUN mkdir -p "${HYPRLAND_SRC}"
RUN cd "${HYPRLAND_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/Hyprland.git"

# Hyprland build deps
# - https://wiki.hyprland.org/Getting-Started/Installation/#manual-manual-build
# - https://github.com/hyprwm/hyprlang?tab=readme-ov-file#building-and-installation
# - https://github.com/hyprwm/hyprcursor?tab=readme-ov-file#building

RUN apt-get install -y --no-install-recommends \
  libzip-dev \
  librsvg2-dev \
  libxml2-dev \
  libtomlplusplus-dev \
  libgbm-dev \
  libsystemd-dev \
  libseat-dev seatd \
  libegl-dev libgles2 libegl1-mesa-dev glslang-tools \
  libinput-bin libinput-dev \
  hwdata \
  libdrm-dev \
  libdisplay-info-dev \
  libvulkan-dev libvulkan-volk-dev vulkan-utility-libraries-dev libvkfft-dev libgulkan-dev \
  libliftoff-dev \
  libavutil-dev libavcodec-dev libavformat-dev \
  libxkbcommon-x11-dev libxkbregistry-dev \
  libxkbcommon-dev libxcb-dri3-dev libxcb-composite0-dev \
  libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev \
  libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev \
  fontconfig libfontconfig-dev libffi-dev \
  libpixman-1-dev \
  libcairo2-dev libpango1.0-dev \
  libudev-dev \
  libwayland-dev libwayland-egl-backend-dev wayland-protocols \
  xwayland \
  xdg-desktop-portal-wlr

# finish

RUN apt autoremove --purge -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

WORKDIR "/src"
RUN mkdir -p /out

ENV PREFIX_DIR="/usr/local"

COPY entrypoint.sh /srv
ENTRYPOINT "/srv/entrypoint.sh"

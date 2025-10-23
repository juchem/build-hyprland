ARG BASE_IMAGE_NAME=debian
ARG BASE_IMAGE_TAG=testing
ARG BASE_IMAGE_TAG_SUFFIX=-slim
FROM $BASE_IMAGE_NAME:$BASE_IMAGE_TAG$BASE_IMAGE_TAG_SUFFIX

############
# apt repo #
############

ENV DEBIAN_PRIORITY=critical
ENV DEBIAN_FRONTEND=noninteractive

RUN truncate --size=0 /etc/apt/sources.list
RUN rm -rf /etc/apt/sources.list.d
RUN mkdir -p /etc/apt/sources.list.d

#################
# debian trixie #
#################

ARG WITH_DEBIAN_TRIXIE=true

COPY debian-trixie.list /tmp
RUN [ "${WITH_DEBIAN_TRIXIE}" != true ] || ( \
  mv /tmp/debian-trixie.list /etc/apt/sources.list.d/ \
)

##################
# debian testing #
##################

ARG WITH_DEBIAN_TESTING=true

COPY debian-testing.list /tmp
RUN [ "${WITH_DEBIAN_TESTING}" != true ] || ( \
  mv /tmp/debian-testing.list /etc/apt/sources.list.d/ \
)

###################
# debian unstable #
###################

ARG WITH_DEBIAN_UNSTABLE=true

COPY debian-unstable.list /tmp
RUN [ "${WITH_DEBIAN_UNSTABLE}" != true ] || ( \
  mv /tmp/debian-unstable.list /etc/apt/sources.list.d/ \
)

############################
# debian unstable debports #
############################

ARG WITH_DEBIAN_UNSTABLE_DEBPORTS=true

COPY debian-unstable.debports.list /tmp
RUN [ "${WITH_DEBIAN_UNSTABLE_DEBPORTS}" != true ] || ( \
  apt-get update \
  && apt-get install -y --no-install-recommends \
    debian-ports-archive-keyring \
  && mv /tmp/debian-unstable.debports.list /etc/apt/sources.list.d/ \
)

#########################
# debian unstable debug #
#########################

ARG WITH_DEBIAN_UNSTABLE_DEBUG=false

COPY debian-unstable.debug.list /tmp
RUN [ "${WITH_DEBIAN_UNSTABLE_DEBUG}" != true ] || ( \
  mv /tmp/debian-unstable.debug.list /etc/apt/sources.list.d/ \
)

#############################
# upgrade existing packages #
#############################

RUN apt-get update \
  && apt-get upgrade -y

############################
# aptitude package manager #
############################

ARG WITH_APTITUDE=false

RUN [ "${WITH_APTITUDE}" != true ] || ( \
  apt-get update \
  && apt-get install -y --no-install-recommends \
    aptitude \
)

##################
# basic packages #
##################

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  file cpio coreutils time \
  sudo bash-completion \
  gettext gettext-base \
  gzip bzip2 xz-utils 7zip unzip \
  dos2unix recode

#############
# utilities #
#############

RUN apt-get update && apt-get install -y --no-install-recommends \
  bc

###########
# network #
###########

RUN apt-get update && apt-get install -y --no-install-recommends \
  openssh-client \
  curl \
  wget

#################
# documentation #
#################

RUN apt-get update && apt-get install -y --no-install-recommends \
  man-db manpages manpages-dev manpages-posix manpages-posix-dev

#######
# vcs #
#######

RUN apt-get update && apt-get install -y --no-install-recommends \
  git

########
# text #
########

RUN apt-get update && apt-get install -y --no-install-recommends \
  vim-nox \
  ripgrep \
  less \
  jq \
  icdiff

###################
# build/dev tools #
###################

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  pkgconf \
  make \
  cmake cmake-extras \
  meson \
  ninja-build

##########
# python #
##########

RUN apt-get update && apt-get install -y --no-install-recommends \
  python-is-python3 python3 \
  python3-dev \
  python3-numpy \
  python3-matplotlib \
  python3-pygments

########
# ruby #
########

RUN apt-get update && apt-get install -y --no-install-recommends \
  ruby \
  ruby-rails

#######
# c++ #
#######

RUN apt-get update && apt-get install -y --no-install-recommends \
  g++ \
  clang \
  clang-format

##############################################
# hyprland build deps
# - https://wiki.hypr.land/Getting-Started/Installation/#manual
##############################################

RUN apt-get update && apt-get install -y --no-install-recommends \
  libwlroots-0.19-dev \
  libinotifytools0-dev \
  libre2-dev \
  systemd-dev \
  xorg-dev \
  libtracy-dev \
  libglaze-dev

# hyprland repo: https://github.com/hyprwm/Hyprland.git

ENV HYPRLAND_SRC="/src/hyprland"

RUN mkdir -p "${HYPRLAND_SRC}"
RUN cd "${HYPRLAND_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/Hyprland.git"

##############################################
# aquamarine build deps
# - https://github.com/hyprwm/aquamarine?tab=readme-ov-file#building
##############################################

# NOTE: many of these are hyprland's dependencies too
RUN apt-get update && apt-get install -y --no-install-recommends \
  libgl-dev libglvnd-dev \
  libvulkan-dev \
  libwayland-dev \
  libwayland-egl-backend-dev \
  libnvidia-egl-wayland-dev \
  libudev-dev \
  libdrm-dev \
  hwdata \
  libdisplay-info-dev \
  libinput-dev \
  libseat-dev \
  libgbm-dev \
  wayland-protocols

# aquamarine repo: https://github.com/hyprwm/aquamarine.git

ENV AQUAMARINE_SRC="/src/aquamarine"

RUN mkdir -p "${AQUAMARINE_SRC}"
RUN cd "${AQUAMARINE_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/aquamarine.git"

##############################################
# hyprlang build deps
# - https://github.com/hyprwm/hyprlang?tab=readme-ov-file#building-and-installation
##############################################

# hyprlang repo: https://github.com/hyprwm/hyprlang.git

ENV HYPRLANG_SRC="/src/hyprlang"

RUN mkdir -p "${HYPRLANG_SRC}"
RUN cd "${HYPRLANG_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprlang.git"

##############################################
# hyprcursor build deps
# - https://github.com/hyprwm/hyprcursor?tab=readme-ov-file#building
# deps: hyprlang
##############################################

RUN apt-get update && apt-get install -y --no-install-recommends \
  libcairo2-dev \
  libzip-dev \
  librsvg2-dev \
  libtomlplusplus-dev

# hyprcursor repo: https://github.com/hyprwm/hyprcursor.git

ENV HYPRCURSOR_SRC="/src/hyprcursor"

RUN mkdir -p "${HYPRCURSOR_SRC}"
RUN cd "${HYPRCURSOR_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprcursor.git"

##############################################
# hyprutils build deps
# - https://github.com/hyprwm/hyprutils?tab=readme-ov-file#building
##############################################

# hyprutils repo: https://github.com/hyprwm/hyprutils.git

ENV HYPRUTILS_SRC="/src/hyprutils"

RUN mkdir -p "${HYPRUTILS_SRC}"
RUN cd "${HYPRUTILS_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprutils.git"

##############################################
# hyprgraphics build deps
# - https://github.com/hyprwm/hyprgraphics?tab=readme-ov-file#building
# deps: hyprutils
##############################################

RUN apt-get update && apt-get install -y --no-install-recommends \
  libpixman-1-dev \
  libcairo2-dev \
  libjpeg-dev \
  libwebp-dev \
  libmagic-dev \
  libpng-dev \
  librsvg2-dev \
  \
  libjxl-dev

  #libjxl_cms-dev \
  #libjxl_threads-dev

# hyprgraphics repo: https://github.com/hyprwm/hyprgraphics.git

ENV HYPRGRAPHICS_SRC="/src/hyprgraphics"

RUN mkdir -p "${HYPRGRAPHICS_SRC}"
RUN cd "${HYPRGRAPHICS_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprgraphics.git"

##############################################
# hyprwayland_scanner build deps
# - https://github.com/hyprwm/hyprwayland-scanner?tab=readme-ov-file#building
##############################################

RUN apt-get update && apt-get install -y --no-install-recommends \
  libpugixml-dev

# hyprwayland_scanner repo: https://github.com/hyprwm/hyprwayland-scanner.git

ENV HYPRWAYLAND_SCANNER_SRC="/src/hyprwayland_scanner"

RUN mkdir -p "${HYPRWAYLAND_SCANNER_SRC}"
RUN cd "${HYPRWAYLAND_SCANNER_SRC}" \
  && git init \
  && git remote add origin "https://github.com/hyprwm/hyprwayland-scanner.git"

#########################
# repo metadata cleanup #
#########################

RUN apt-get update && apt-get upgrade -y
RUN apt autoremove --purge -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

###############
# environment #
###############

ENV OUT_DIR="/out"
RUN mkdir -p "${OUT_DIR}"

ENV PREFIX_DIR="/usr/local"

ARG IMAGE_ENV_ROOT="/srv"
RUN mkdir -p "${IMAGE_ENV_ROOT}"

ARG IMAGE_ETC_DIR="${IMAGE_ENV_ROOT}/etc"
RUN mkdir -p "${IMAGE_ETC_DIR}"

ARG IMAGE_ENV_DIR="${IMAGE_ENV_ROOT}/env"
RUN mkdir -p "${IMAGE_ENV_DIR}"

#############
# provision #
#############

ARG TMP_PROVISION_DIR="/tmp/.build-env-provision"
RUN mkdir -p "${TMP_PROVISION_DIR}"

#COPY import-profile "${IMAGE_ENV_DIR}/import-profile"

##############
# entrypoint #
##############

#ENTRYPOINT ["bash", "-o", "history"]
COPY entrypoint.sh "/srv/entrypoint.sh"
ENTRYPOINT "/srv/entrypoint.sh"

WORKDIR "/srv"

#!/usr/bin/env bash
#
# docoolwechat.sh - Docker WeChat for Linux
#
#   Author: Bimbing (李绍兵) <robin_lee@qq.com>
#   Copyright (c) 2020
#
#   License: Apache-2.0
#   GitHub: https://github.com/robinlee/coolwechat
#
set -eo pipefail

#
# The defeault docker image version which confirmed that most stable.
#   See: https://github.com/robinlee/coolwechat/issues/29#issuecomment-619491488
#
DEFAULT_WECHAT_VERSION=1.0

#
# Get the image version tag from the env
#
DOCHAT_IMAGE_VERSION="robinlee/coolwechat:${DOCHAT_WECHAT_VERSION:-${DEFAULT_WECHAT_VERSION}}"

function hello () {
  cat <<'EOF'

  ____            __           __        ____ _           _
 / ___| ___  ___ ||\ \   ~~~   / / ___  / ___| |__   __ _| |_
| |    / _ \/ _ \|| \ \ / ^ \ / / / ==\| |   | '_ \ / _` | __|
| |___  (_)  (_) ||  \ V / \ V /  |(__ | |___| | | | (_| | |_
 \____|\___/\___/|_)  \_/   \_/   \___) \____|_| |_|\__,_|\__|


      https://github.com/robinlee/coolwechat

                +--------------+
               /|             /|
              / |            / |
             *--+-----------*  |
             |  |           |  |
             |  |   备份    |  |
             |  |   微信    |  |
             |  +-----------+--+
             | /            | /
             |/             |/
             *--------------*

      CoolWeChat /cool wetʃæt/ (coolWeChat) is:

      📦 a Docker image
      🤐 for running PC Windows WeChat
      💻 on your Linux desktop
      💖 by one-line of command

EOF
}

function pullUpdate () {
  if [ -n "$DOCHAT_SKIP_PULL" ]; then
    return
  fi

  echo '🚀 Pulling the docker image...'
  echo
  docker pull "$DOCHAT_IMAGE_VERSION"
  echo
  echo '🚀 Pulling the docker image done.'
}

function main () {

  hello
  pullUpdate

  DEVICE_ARG=()
  for DEVICE in /dev/video* /dev/snd; do
    DEVICE_ARG+=('--device' "$DEVICE")
  done

  echo "🚀 Starting CoolWeChat[ $DOCHAT_IMAGE_VERSION ] /dɑɑˈtʃæt/ ..."
  echo

  #
  # --privileged: enable sound (/dev/snd/)
  # --ipc=host:   enable MIT_SHM (XWindows)
  #
  docker run \
    "${DEVICE_ARG[@]}" \
    --name CoolWeChat \
    --rm \
    -i \
    \
    -v "$HOME/CoolWeChat/WeChat Files/":'/home/user/WeChat Files/' \
    -v "$HOME/CoolWeChat/Applcation Data":'/home/user/.wine/drive_c/users/user/Application Data/' \
    \
    -e DOCHAT_DEBUG \
    -e DOCHAT_DPI \
    \
    -e XMODIFIERS=@im=fcitx \
    -e GTK_IM_MODULE=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e AUDIO_GID="$(getent group audio | cut -d: -f3)" \
    -e VIDEO_GID="$(getent group video | cut -d: -f3)" \
    -e GID="$(id -g)" \
    -e UID="$(id -u)" \
    \
    --ipc=host \
    --privileged \
    \
    -p 5900:5900 \
    --network=host \
    "$DOCHAT_IMAGE_VERSION"
#   -e DISPLAY \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \

    echo
    echo "📦 CoolWeChat Exited with code [$?]"
    echo
    echo '🐞 Bug Report: https://github.com/robinlee/coolwechat/issues'
    echo

}

main

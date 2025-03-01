#/bin/bash

# Brew
brew install \
  rust \
  python3 \
  marskman \
  npm \
  cargo \
  shfmt \
  terraform \
  yamlfmt \
  hadolint

# install pip
python3 -m ensurepip --upgrade

# install pip packages
python3 -m pip install black

# npm packages
npm install -g \
  markdownlint-cli2 \
  prettier \
  dockerfile-language-server-nodejs \
  bash-language-server

# cargo packaes
cargo install \
  selene \
  taplo-cli

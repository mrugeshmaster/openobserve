#! /bin/bash
set -e

PLATFORM=$(uname -p)

if [[ $PLATFORM == "x86_64" ]]; then
  curl -L --output protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protoc-21.12-linux-x86_64.zip"
elif [[ $PLATFORM == "aarch64" ]]; then
  curl -L --output protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protoc-21.12-linux-aarch_64.zip"
else
  echo "unsupported platform $PLATFORM"
  exit 1
fi

# -o (overwrite) so a rerun over an already-populated protoc/ dir doesn't hit the
# interactive "replace? [y]es,[n]o" prompt, read EOF on non-interactive stdin, and
# abort the whole setup under `set -e`.
unzip -o protoc.zip -d protoc

sudo cp protoc/bin/protoc /usr/local/bin/
sudo cp -r protoc/include/google /usr/local/include/

echo "successfully installed protoc"

#!/bin/bash

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/behdanisohrab/parch-zram/master"
BIN_PATH="/usr/bin/parch-zram"
SERVICE_PATH="/etc/systemd/system/parch-zram.service"

sudo wget -O "$BIN_PATH" "$REPO_URL/zram.sh"
sudo chmod +x "$BIN_PATH"
sudo wget -O "$SERVICE_PATH" "$REPO_URL/parch-zram.service"

sudo systemctl daemon-reload
sudo systemctl enable --now parch-zram.service

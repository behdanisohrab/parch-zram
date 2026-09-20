#!/bin/bash

set -euo pipefail

sudo systemctl stop parch-zram.service 2>/dev/null || true
sudo systemctl disable parch-zram.service 2>/dev/null || true
sudo rm -f /etc/systemd/system/parch-zram.service
sudo rm -f /usr/bin/parch-zram
sudo systemctl daemon-reload

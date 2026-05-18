#!/bin/bash

set -euo pipefail
export LANG=C

ACTION="${1:-start}"
CORES="${ZRAM_NUM_DEVICES:-$(nproc --all)}"
ALGORITHM="${ZRAM_ALGORITHM:-lz4}"
PERCENT="${ZRAM_PERCENT:-50}"
MAX_MB="${ZRAM_MAX_MB:-0}"
SWAP_PRIORITY="${ZRAM_SWAP_PRIORITY:-100}"

require_cmd() {
    command -v "$1" >/dev/null 2>&1 || {
        echo "Required command not found: $1" >&2
        exit 1
    }
}

cleanup_zram() {
    local core=0
    while [ "$core" -lt "$CORES" ]; do
        if [ -b "/dev/zram$core" ]; then
            swapoff "/dev/zram$core" 2>/dev/null || true
        fi
        core=$((core + 1))
    done
    if lsmod | grep -q "^zram"; then
        rmmod zram
    fi
}

require_cmd nproc
require_cmd modprobe
require_cmd mkswap
require_cmd swapon
require_cmd swapoff
require_cmd awk

if ! [[ "$PERCENT" =~ ^[0-9]+$ ]] || [ "$PERCENT" -lt 1 ] || [ "$PERCENT" -gt 100 ]; then
    echo "ZRAM_PERCENT must be an integer between 1 and 100" >&2
    exit 1
fi

if ! [[ "$MAX_MB" =~ ^[0-9]+$ ]]; then
    echo "ZRAM_MAX_MB must be an integer" >&2
    exit 1
fi

if [[ "$ACTION" == "stop" ]]; then
    cleanup_zram
    exit 0
fi

cleanup_zram

modprobe zram num_devices="$CORES"

total_kib=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
target_kib=$((total_kib * PERCENT / 100))
target_bytes=$((target_kib * 1024))

if [ "$MAX_MB" -gt 0 ]; then
    max_bytes=$((MAX_MB * 1024 * 1024))
    if [ "$target_bytes" -gt "$max_bytes" ]; then
        target_bytes="$max_bytes"
    fi
fi

per_device_bytes=$((target_bytes / CORES))
if [ "$per_device_bytes" -lt $((16 * 1024 * 1024)) ]; then
    per_device_bytes=$((16 * 1024 * 1024))
fi

core=0
while [ "$core" -lt "$CORES" ]; do
    algo_path="/sys/block/zram$core/comp_algorithm"
    size_path="/sys/block/zram$core/disksize"
    echo "$ALGORITHM" > "$algo_path"
    echo "$per_device_bytes" > "$size_path"
    mkswap "/dev/zram$core" >/dev/null
    swapon -p "$SWAP_PRIORITY" "/dev/zram$core"
    core=$((core + 1))
done

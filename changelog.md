# Changelog

## Unreleased

Improved zram sizing logic in `zram.sh` to prevent total swap from scaling as `RAM * CPU cores`, which previously caused very large configured swap values such as 90GB on multi-core systems.

Reworked runtime behavior so the script no longer disables all system swap entries with `swapoff -a`, and now only manages zram devices during start and stop flows.

Added safer shell practices with `set -euo pipefail`, dependency checks for required commands, parameter validation, and explicit start and stop action handling.

Introduced configurable runtime settings via environment variables including `ZRAM_NUM_DEVICES`, `ZRAM_ALGORITHM`, `ZRAM_PERCENT`, `ZRAM_MAX_MB`, and `ZRAM_SWAP_PRIORITY`.

Adjusted zram provisioning logic to compute a total target size from a RAM percentage, optionally cap it, then divide across devices while enforcing a small minimum per-device size.

Made compression configuration consistent across all created zram devices instead of only setting `zram0`.

Aligned install and uninstall scripts with package naming by standardizing on `parch-zram.service` and `/usr/bin/parch-zram`.

Updated `install.sh` to install the script and service consistently, reload systemd, and enable plus start the service in one command.

Updated `uninstall.sh` to stop and disable the standardized service, remove installed files safely, and reload systemd.

Refined `parch-zram.service` with `Type=oneshot` to match setup style execution and retain `ExecStop` cleanup behavior.

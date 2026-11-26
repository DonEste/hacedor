# Hacedor

`hacedor` is a version-control repository designed to track configuration files, G-code scripts, and custom macros for a 3D printer running **RepRapFirmware (RRF)**. It provides a history of firmware settings, motor configurations, homing scripts, and custom print routines.

---

## 📂 Repository Structure

The configuration files are organized in directories matching the structure required by RepRapFirmware:

```text
hacedor/
├── sys/                     # RepRapFirmware system files
│   ├── config.g             # Main printer configuration
│   ├── config-override.g    # Values saved with M500 (Z probe offset, workplace offsets)
│   ├── daemon.g             # Background loop: Raspberry Pi temperature control of the board/Pi fan
│   ├── bed.g                # G32: heat-soak, quad gantry leveling, mesh
│   ├── truelevel.g          # Quad Z motor leveling
│   ├── homeall.g / homex.g / homey.g / homez.g
│   ├── start.g / stop.g     # Job start (empty) / job end: park, heaters off, LEDs
│   ├── pause.g / resume.g   # Park and return to the paused position
│   ├── tpre0.g / tpost0.g / tfree0.g
│   ├── filaments.csv        # Filament loaded in each extruder
│   └── lib/                 # Helper macros called by the files above (not shown in DWC)
│       ├── print_start.g    # Slicer start: heat, level, apply filament profile, purge
│       ├── led.g            # All LED states (heating, printing, done, error...)
│       ├── breathe.g        # Heat-wait with pulsing LEDs and safety timeout
│       ├── filament_load.g / filament_unload.g
│       └── filament_sensor.g
├── filaments/               # Per-filament files used by DWC's Load/Unload and print_start
│   └── ABS/ PETG/ PLA/ TPU/ # config.g (pressure advance, skew), load.g, unload.g
├── macros/                  # Macros shown in DWC (LEDs, filament sensor, probe offset steps...)
└── orca/                    # OrcaSlicer custom G-code: start, end, layer change, pause (see orca/README.md)
```

---

## ⚙️ Core Configuration Files Details

### 1. `sys/config.g`
The main configuration script executed when the printer starts up. It defines:
* Board settings and networking protocols.
* Kinematics and axis limits.
* Stepper motor parameters (direction, steps-per-mm, current, speeds).
* Endstop sensors, BLTouch / Z-probe setup, and bed mesh parameters.
* Heater, thermistor, and cooling fan profiles.
* Tool definitions (extruder mapping).

### 2. `sys/bed.g`
Triggered via the `G32` command. It runs a sequence of G-code probes at predefined points to measure bed tilt and compute bed leveling correction parameters.

### 3. Homing Scripts (`homex.g`, `homey.g`, `homez.g`, `homeall.g`)
Define the movements, endstop triggers, and Z-probe behaviors to safely reference each axis coordinate system.

### 4. Pause & Resume (`pause.g`, `resume.g`)
* **`pause.g`**: Retracts filament, lifts the print head, and parks the nozzle in a safe position to prevent melting the model.
* **`resume.g`**: Moves the nozzle back to the last coordinate, primes the extruder, and continues printing at the original speed.

---

## 🚀 How to Apply Configs

To deploy these configurations to your printer:
1. Access your Duet Web Control (DWC) interface via your browser.
2. Navigate to **Files** > **System** tab.
3. Upload the files from `sys/` (including `sys/lib/`), `filaments/` and `macros/` to the matching folders.
4. Restart the firmware (`M999`) to apply the changes.

Alternatively, for offline setup, copy the files directly onto the printer's SD card under the `/sys` directory.

---

## 🔒 Not tracked

* `sys/SBCC_Config.json`: contains the SBC's API key.
* `sys/dwc-cache.json`, `sys/log.log`, `sys/heightmap.csv`, `sys/accelerometer/`: machine-generated data.

---

## 📄 License
This repository is open-source and licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

# Hacedor

`hacedor` is a version-control repository designed to track configuration files, G-code scripts, and custom macros for a 3D printer running **RepRapFirmware (RRF)**. It provides a history of firmware settings, motor configurations, homing scripts, and custom print routines.

---

## 📂 Repository Structure

The configuration files are organized in directories matching the structure required by RepRapFirmware:

```text
hacedor/
├── sys/                  # RepRapFirmware System Configurations
│   ├── config.g          # Primary printer configuration script
│   ├── bed.g             # Bed probing and leveling routine
│   ├── homeall.g         # Homing script for all axes (X, Y, and Z)
│   ├── homex.g           # Homing script for the X axis
│   ├── homey.g           # Homing script for the Y axis
│   ├── homez.g           # Homing script for the Z axis
│   ├── pause.g           # Operations performed when pausing a print
│   ├── resume.g          # Operations performed when resuming a print
│   ├── truelevel.g       # Automated gantry leveling script
│   ├── tfree0.g          # Tool-free actions (when releasing Tool 0)
│   ├── tpre0.g           # Tool-pre actions (before selecting Tool 0)
│   └── tpost0.g          # Tool-post actions (after selecting Tool 0)
├── macros/               # Custom user macros and automation scripts
└── orca/                 # OrcaSlicer printer, process and filament profiles (see orca/README.md)
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
3. Upload the files from the `sys/` folder directly.
4. Restart the firmware (`M999`) to apply the changes.

Alternatively, for offline setup, copy the files directly onto the printer's SD card under the `/sys` directory.

---

## 📄 License
This repository is open-source and licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

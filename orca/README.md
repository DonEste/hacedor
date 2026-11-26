# OrcaSlicer custom G-code

The custom G-code blocks of the OrcaSlicer printer profile **Hacedor** (OrcaSlicer 2.4), one file per field.

| File | Orca field (Printer settings → Machine G-code) | What it does |
|---|---|---|
| `machine_start.gcode` | Machine start G-code | Calls `/sys/lib/print_start.g` with the bed temperature (`B`), nozzle temperature (`H`) and filament type (`F`). The macro heats, homes, levels, applies the filament profile and purges. |
| `machine_end.gcode` | Machine end G-code | `M0`, which runs `sys/stop.g` on the printer. |
| `before_layer_change.gcode` | Before layer change G-code | Resets the extruder position; on the first layer sets the "printing" LEDs. |
| `layer_change.gcode` | Layer change G-code | Marker comment only (inherited from Orca's MyRRF preset). |
| `pause.gcode` | Pause G-code | `M226`, which runs `sys/pause.g`. |
| `filament_start.gcode` / `filament_end.gcode` | Filament settings → Advanced | Orca's default comments, the same for every filament. |

Fields that are empty in this profile, so not saved here: change filament, time-lapse, printing by object, template custom G-code, extrusion-role change, wrapping detection, file start.

The first two comment lines of each file are a header added for this backup. When restoring, paste the text below them into the matching Orca field (keeping the header is harmless; it is only comments).

`[...]` and `{...}` are Orca placeholders and conditions, filled in when slicing. `F"[filament_type]"` must match a folder name under `/filaments` on the printer (ABS, PETG, PLA, TPU).

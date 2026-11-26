# OrcaSlicer profiles

Backup of the OrcaSlicer user profiles used with this printer (OrcaSlicer 2.4).

| Folder | Profile | Notes |
|---|---|---|
| `machine/` | `Hacedor` | Printer limits, start / end / layer-change / pause G-code. Inherits `MyRRF 0.4 nozzle`. |
| `process/` | `Normal.4` | 0.4 mm nozzle, 0.2 mm layers; accelerations 4000 (default, inner wall, first layer), 3000 (outer wall, top), 5500 (travel). |
| `filament/` | `ABS`, `PETG`, `PLA`, `TPU` | Temperatures, flow, cooling. Inherit Orca's Generic profiles. |

The start G-code calls `M98 P"/sys/lib/print_start.g" B… H… F"[filament_type]"`, so the filament names must match the folders under `/filaments` on the printer.

## Restoring

1. Close OrcaSlicer.
2. Copy the JSON files into `%APPDATA%\OrcaSlicer\user\default\<machine|process|filament>\`.
3. In `machine/Hacedor.json`, replace `PRINTER_IP_OR_HOSTNAME` with the printer's address (it is blanked here because this repository is public), or set it later in Orca's printer connection settings.
4. Start OrcaSlicer; the profiles appear under the user presets.

Only the `.json` files are kept. Orca's `.info` side files (sync metadata) are not needed and are recreated by Orca.

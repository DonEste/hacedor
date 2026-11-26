; sys/lib/print_start.g
; Requires B (Bed Temperature) and H (Hotend Temperature) parameters
; Optional F = filament name (e.g. F"PETG"): applies /filaments/<name>/config.g (pressure advance, skew)
; Example: M98 P"/sys/lib/print_start.g" B60 H210 F"PETG"   (slicer start G-code)

; ── Phase 1: Heating ──────────────────────────────────────────────
M98 P"/sys/lib/led.g" S"heating"       ; LEDs: Orange (heating)
M83                               ; Relative extruder moves

; Apply the filament profile named by the slicer (pressure advance, skew) so it never depends on what was last loaded
if exists(param.F)
    var fpath = "/filaments/" ^ param.F ^ "/config.g"
    if fileexists(var.fpath)
        M98 P{var.fpath}
    else
        echo "print_start: no folder for filament " ^ param.F ^ ", keeping the current pressure advance and skew"

; Heat bed (blocks until target)
M140 S{param.B}
M190 S{param.B}

; Pre-heat nozzle to 140°C for leveling (prevents oozing on bed probes)
M104 S140                         ; Fixed: was M105 instead of M104
M400                              ; Wait for commands to process

; ── Phase 2: Homing & Leveling ────────────────────────────────────
G32                               ; Home + quad gantry level + mesh bed comp
M400                              ; Ensure all probing moves complete

; ── Phase 3: Final Heat ───────────────────────────────────────────
M98 P"/sys/lib/led.g" S"heating"       ; LEDs: Orange (heating)
var targetTemp = {param.H}
M104 S{var.targetTemp}             ; Start heating (non-blocking)
G1 X0 Y0 Z2 F2000                ; Park at front-left corner

; Pulse the LEDs while heating (rise step 5, fall step 5, 10 ms between steps)
M98 P"/sys/lib/breathe.g" T{var.targetTemp} U5 D5 W10

M109 S{var.targetTemp}             ; Final block wait
M400                              ; Ensure temp is stable

; ── Phase 4: Purge & Prime ────────────────────────────────────────
; Enable filament sensor before printing
M98 P"/sys/lib/filament_sensor.g" S1

G1 X10 Y0 Z0.3 F1000.0           ; Move to purge start position
G92 E0.0                          ; Reset extruder position
G1 Z0.2 E8                        ; Purge bubble
G1 Y60.0 E9.0 F1000.0             ; Intro line 1
G1 Y100.0 E12.5 F1000.0           ; Intro line 2
G92 E0.0                          ; Reset extruder position

; ── Phase 5: Start Printing ───────────────────────────────────────
M98 P"/sys/lib/led.g" S"printing"      ; LEDs: Red logo + White nozzle
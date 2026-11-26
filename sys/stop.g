; stop.g
; called when a print job finishes

M400                              ; Wait for final print moves to complete
M98 P"/sys/lib/led.g" S"done"          ; LED: Green (done)

G91                               ; Relative positioning
G1 E-2 F900                       ; Retract a bit
G1 Z1 F720                        ; Move print head up 1mm
G90                               ; Absolute positioning
G1 X300 Y300 F10000               ; Park head (faster: was F3600)
G1 Z{min(move.axes[2].userPosition + 49, move.axes[2].max)} F720  ; Move head further up (clamped to Z max)

; ── Shutdown ──────────────────────────────────────────────────────
M221 S100                         ; Reset flow
M104 S0                           ; Turn off extruder
M140 S0                           ; Turn off heatbed
M107                              ; Turn off part cooling fan

; ── Disable filament sensor (no point monitoring after print) ────
M98 P"/sys/lib/filament_sensor.g" S0

; ── LED lifecycle: done → standby ────────────────────────────────
G4 S10                            ; Show green "done" for 10 seconds
M98 P"/sys/lib/led.g" S"standby"       ; Restore standby (logo off, nozzle white)
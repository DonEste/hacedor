; truelevel.g
; called to level the bed using quad Z motors
;

M98 P"/sys/lib/led.g" S"homing"    ; Set LEDs to Cyan/Homing status

; Only home if axes are not already homed
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
    G28

; Loop up to 3 times to level the bed
while iterations < 3
    if iterations == 0
        M558 H5               ; First pass safe height
    elif iterations == 1
        M558 H2               ; Second pass
    else
        M558 H1               ; Subsequent passes fast height

    G30 P0 X270 Y270 Z-99999  ; Probe Rear-Right (Motor 0)
    G30 P1 X30 Y270 Z-99999   ; Probe Rear-Left (Motor 1)
    G30 P2 X270 Y30 Z-99999   ; Probe Front-Right (Motor 2)
    G30 P3 X30 Y30 Z-99999 S4 ; Probe Front-Left (Motor 3) and calibrate Z motors

                              ; If deviation is small enough, we can stop leveling early
    if move.calibration.initial.deviation < 0.02
        break

G1 Z10
M558 H5                          ; restore default probe dive height (as in config.g)
M98 P"/sys/lib/led.g" S"done"      ; Leveling completed - show green
M98 P"/sys/lib/led.g" S"standby"   ; Restore LEDs to Standby status
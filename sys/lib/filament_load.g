; sys/lib/filament_load.g - heat, feed and purge new filament
; Usage: M98 P"/sys/lib/filament_load.g" T<temp>
; Normally called by filaments/<name>/load.g (DWC Load button / M701).

if !exists(param.T)
    abort "Error: Missing T parameter (temperature). Usage: M98 P""/sys/lib/filament_load.g"" T210"

M98 P"/sys/lib/led.g" S"heating"
M104 S{param.T}                    ; Start heating (non-blocking)
M98 P"/sys/lib/breathe.g" T{param.T}
M109 S{param.T}                    ; Final wait to ensure stable

M98 P"/sys/lib/led.g" S"action"
M83                                ; Relative extruder moves
G1 E100 F600                       ; Fast feed 100mm (bowden path clearance)
G1 E40 F120                        ; Slow feed 40mm to purge old filament
G1 E-1 F900                        ; Retract 1mm to prevent ooze
M400                               ; Wait for all moves to finish
M98 P"/sys/lib/led.g" S"done"
G4 S3                              ; Visual confirmation delay
M104 S0                            ; Turn off heater
M98 P"/sys/lib/led.g" S"standby"

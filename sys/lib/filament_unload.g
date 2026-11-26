; sys/lib/filament_unload.g - heat to warm-pull temperature and retract the filament
; Usage: M98 P"/sys/lib/filament_unload.g" T<temp>
; Normally called by filaments/<name>/unload.g (DWC Unload button / M702).

if !exists(param.T)
    abort "Error: Missing T parameter (warm pull temperature). Usage: M98 P""/sys/lib/filament_unload.g"" T120"

M98 P"/sys/lib/led.g" S"heating"
M104 S{param.T}                    ; Start heating (non-blocking)
M98 P"/sys/lib/breathe.g" T{param.T}
M109 S{param.T}                    ; Final wait to ensure stable

M98 P"/sys/lib/led.g" S"action"
M83                                ; Relative extruder moves
M302 P1                            ; Allow cold extrusion (below safety temp)
G1 E-140 F1200                     ; Retract 140mm quickly - warm pull
M302 P0                            ; Restore cold extrusion protection
M400                               ; Wait for all moves to finish
M98 P"/sys/lib/led.g" S"done"
G4 S3                              ; Visual confirmation delay
M104 S0                            ; Turn off heater
M98 P"/sys/lib/led.g" S"standby"

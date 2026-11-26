; homey.g
; called to home the Y axis
;

M98 P"/sys/lib/led.g" S"homing"                              ; Set LEDs to Cyan/Homing status

; increase Z
G91                                                     ; relative positioning
G1 H2 Z10 F6000                                         ; move Z relative to current position to avoid dragging nozzle over the bed
G90                                                     ; absolute positioning

; home Y
var maxTravel = move.axes[1].max - move.axes[1].min + 5 ; calculate how far Y can travel plus 5mm
G1 H1 Y{var.maxTravel} F3000                            ; coarse home in the +Y direction (towards high end)
G91                                                     ; relative positioning
G1 Y-5 F8000                                            ; move back 5mm (away from endstop)
G90                                                     ; absolute positioning
G1 H1 Y{var.maxTravel} F600                             ; fine home in the +Y direction

M98 P"/sys/lib/led.g" S"standby"                             ; Restore LEDs to Standby status
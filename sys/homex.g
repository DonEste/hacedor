; homex.g
; called to home the X axis
;

M98 P"/sys/lib/led.g" S"homing"                              ; Set LEDs to Cyan/Homing status

; increase Z
G91                                                     ; relative positioning
G1 H2 Z10 F6000                                         ; move Z relative to current position to avoid dragging nozzle over the bed
G90                                                     ; absolute positioning

; home X
var maxTravel = move.axes[0].max - move.axes[0].min + 5 ; calculate how far X can travel plus 5mm
G1 H1 X{var.maxTravel} F3000                            ; coarse home in the +X direction (towards high end)
G91                                                     ; relative positioning
G1 X-5 F8000                                            ; move back 5mm (away from endstop)
G90                                                     ; absolute positioning
G1 H1 X{var.maxTravel} F600                             ; fine home in the +X direction

M98 P"/sys/lib/led.g" S"standby"                             ; Restore LEDs to Standby status
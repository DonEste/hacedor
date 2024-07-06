; homey.g
; called to home the Y axis
;

; increase Z
G91 ; relative positioning
G1 Z10 ; move Z relative to current position to avoid dragging nozzle over the bed
G90 ; absolute positioning

; home Y
var maxTravel = move.axes[1].max - move.axes[1].min + 5 ; calculate how far Y can travel plus 5mm
G1 H1 Y{var.maxTravel} F8000 ; coarse home in the +Y direction
G1 Y295 F8000 ; move back 5mm
G1 H1 Y{var.maxTravel} F600 ; fine home in the +Y direction

; decrease Z again
G91 ; relative positioning
G1 Z-10 F6000 ; move Z relative to current position
G90 ; absolute positioning

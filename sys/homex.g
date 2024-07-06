; homex.g
; called to home the X axis
;

; increase Z
G91 ; relative positioning
G1 Z10 ; move Z relative to current position to avoid dragging nozzle over the bed
G90 ; absolute positioning

; home X
var maxTravel = move.axes[0].max - move.axes[0].min + 5 ; calculate how far X can travel plus 5mm
G1 H1 X{-var.maxTravel} F8000 ; coarse home in the -X direction
G1 X5 F8000 ; move back 5mm
G1 H1 X{-var.maxTravel} F600 ; fine home in the -X direction

; decrease Z again
G91 ; relative positioning
G1 Z-10 F6000 ; move Z relative to current position
G90 ; absolute positioning

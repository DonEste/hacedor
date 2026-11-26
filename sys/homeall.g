; homeall.g
; called to home all axes
;

M98 P"/sys/lib/led.g" S"homing"                            ; Set LEDs to Cyan/Homing status

; increase Z
G91                                                   ; relative positioning
G1 H2 Z10 F6000                                       ; move Z relative to current position to avoid dragging nozzle over the bed
G90                                                   ; absolute positioning

; home XY — sequentially for safety on potentially racked gantry
var xTravel = move.axes[0].max - move.axes[0].min + 5 ; calculate how far X can travel plus 5mm
var yTravel = move.axes[1].max - move.axes[1].min + 5 ; calculate how far Y can travel plus 5mm

G91                                                   ; relative positioning
; Coarse homing — individual axes to avoid binding on racked gantry
G1 H1 X{var.xTravel} F6000                            ; coarse home X first
G1 H1 Y{var.yTravel} F6000                            ; then coarse home Y
G1 X-5 Y-5 F3000                                      ; move back 5mm
; Fine homing — slow, precise
G1 H1 X{var.xTravel} F300                             ; fine home X
G1 H1 Y{var.yTravel} F300                             ; fine home Y
G90                                                   ; absolute positioning

; home Z
var xCenter = move.compensation.probeGrid.mins[0] + (move.compensation.probeGrid.maxs[0] - move.compensation.probeGrid.mins[0]) / 2 - sensors.probes[0].offsets[0]
var yCenter = move.compensation.probeGrid.mins[1] + (move.compensation.probeGrid.maxs[1] - move.compensation.probeGrid.mins[1]) / 2 - sensors.probes[0].offsets[1]
G1 X{var.xCenter} Y{var.yCenter} F10000               ; go to bed centre
M558 H5                                          ; normal probe dive height (a previous aborted G29 may have left it lower)
G30                                                   ; probe the bed

M98 P"/sys/lib/led.g" S"standby"                           ; Restore LEDs to Standby status
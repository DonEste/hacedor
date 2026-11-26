; pause.g
; called when pause a print

M98 P"/sys/lib/led.g" S"action"         ; LED: Action (magenta)

; Save the current fan speed to a global for resume.g
if !exists(global.pausedFanSpeed)
    global pausedFanSpeed = fans[0].requestedValue
else
    set global.pausedFanSpeed = fans[0].requestedValue

G91                                ; Relative positioning
G1 E-5 F900                        ; Retract 5mm to relieve pressure
G1 Z10 F6000                       ; Lift head 10mm
G90                                ; Absolute positioning
G1 X150 Y10 F12000                 ; Park at front-center for filament access
M568 P0 A1                         ; Set tool to standby temp
M106 P0 S0                         ; Turn off part fan (prevent cooling while parked)
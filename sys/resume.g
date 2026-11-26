; resume.g
; called when resumed a print

M568 P0 A2                         ; Set tool to active temp
M116 P0                            ; Wait for hotend to reach active temp before priming

G1 E3 F300                         ; Slow prime 3mm (reduced from 5mm to avoid blob)
G4 P1000                           ; Wait 1 second for pressure to stabilize
G1 E-0.5 F900                      ; Tiny retract to prevent ooze during travel
M400                               ; Wait for all moves

; Return to the position saved when the print was paused (RRF saves restore point 1 on pause)
G1 R1 X0 Y0 Z5 F12000              ; XY back to the print position, staying 5mm above it
G1 R1 X0 Y0 Z0 F6000               ; then lower to the saved Z
M400                               ; Wait for the return moves

; Restore fan speed
if exists(global.pausedFanSpeed)
    M106 P0 S{global.pausedFanSpeed}

M98 P"/sys/lib/led.g" S"printing"       ; LED: Printing (red+white)

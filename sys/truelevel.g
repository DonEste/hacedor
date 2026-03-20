; bed.g
; called to level the bed
;

;M140 S60                  ; heat bed to measure deviations

G28                        ; Home all axis

M558 H5                    ; Lift head by 10mm when probing
G30 P0 X30 Y30 Z-99999     ; probe near a leadscrew
G30 P1 X30 Y270 Z-99999    ; probe near a leadscrew
G30 P2 X270 Y270 Z-99999   ; probe near a leadscrew
G30 P3 X270 Y30 Z-99999 S4 ; probe near a leadscrew and calibrate 4 motors

M558 H2                    ; Lift head by 5mm when probing

G30 P0 X30 Y30 Z-99999     ; probe near a leadscrew
G30 P1 X30 Y270 Z-99999    ; probe near a leadscrew
G30 P2 X270 Y270 Z-99999   ; probe near a leadscrew
G30 P3 X270 Y30 Z-99999 S4 ; probe near a leadscrew and calibrate 4 motors
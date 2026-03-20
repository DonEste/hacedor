; pause.g
; called when pause a print
;

G1 E-5 F900 ; retract 5mm
G1 Z100     ; move head up 100mm
M568 P0 A1  ; set tool to standby temp
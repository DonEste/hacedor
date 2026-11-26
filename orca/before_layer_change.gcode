; OrcaSlicer - Before layer change G-code
; Printer profile: Hacedor (OrcaSlicer 2.4). Placeholders like [layer_z] are filled in by Orca when slicing.

;BEFORE_LAYER_CHANGE
;[layer_z]
G92 E0                           ; Reset extruder distance every layer

; Set printing LEDs on first layer (in case start.g didn't run)
{if layer_num == 1}
M98 P"/sys/lib/led.g" S"printing"     ; Ensure printing LEDs are active
{endif}

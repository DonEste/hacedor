; OrcaSlicer - Machine start G-code
; Printer profile: Hacedor (OrcaSlicer 2.4). Placeholders like [layer_z] are filled in by Orca when slicing.

; The following lines trick Orca Slicer into NOT injecting automatic heating commands
; M190 S[first_layer_bed_temperature]
; M109 S[first_layer_temperature]

; Call our custom print_start macro, passing the Bed (B) and Hotend (H) temperatures
M98 P"/sys/lib/print_start.g" B[first_layer_bed_temperature] H[first_layer_temperature] F"[filament_type]"

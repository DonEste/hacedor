; bed.g
; called to level the bed
;

;M140 S65 ; heat bed to measure deviations

M98 P"truelevel.g" ; level corners

G29      ; call mesh bed compensation
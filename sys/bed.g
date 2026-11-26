; bed.g
; called to level the bed
;

; If the bed is cold (below 40°C), heat to a default temp and soak
if heat.heaters[0].current < 40
    echo "Bed is cold — heating to 60°C for accurate probing"
    M140 S60                       ; Set bed to 60°C
    M190 S60                       ; Wait for bed to reach 60°C
    G4 S60                         ; 60-second thermal soak for plate expansion

M98 P"truelevel.g"                 ; level corners

M98 P"/sys/lib/led.g" S"meshing"        ; LED: Blue (mesh probing)
M558 H0.5                          ; set probe height before probing

G29                                ; call mesh bed compensation
M558 H5                          ; restore default probe dive height (as in config.g)
M98 P"/sys/lib/led.g" S"standby"        ; Restore standby after mesh
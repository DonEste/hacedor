; sys/lib/led.g - single place for all LED states
; Usage: M98 P"/sys/lib/led.g" S"heating"
; States: standby homing heating action done meshing printing error off
;         red green blue white super_white

if !exists(param.S)
    abort "led.g: missing S parameter (state name)"

if param.S == "standby"
    M150 E0 R0 U0 B0 W0 S1 F1             ; Turn off logo LED (wait to flush)
    M150 E0 R255 U255 B255 W255 S2 F0     ; Nozzle LEDs white, flush strip
elif param.S == "homing"
    M150 E0 R0 U255 B255 W0 S1 F1         ; Logo cyan (wait to flush)
    M150 E0 R255 U255 B255 W255 S2 F0     ; Nozzle white, flush strip
elif param.S == "heating"
    M150 E0 R255 U120 B0 W0 S1 F1         ; Logo orange/yellow (wait to flush)
    M150 E0 R150 U150 B150 W150 S2 F0     ; Nozzle warm white, flush strip
elif param.S == "action"
    M150 E0 R255 U0 B255 W0 S1 F1         ; Logo magenta (wait to flush)
    M150 E0 R255 U255 B255 W255 S2 F0     ; Nozzle bright white, flush strip
elif param.S == "done"
    M150 E0 R0 U255 B0 W0 S3 F0           ; All 3 LEDs green, flush immediately
elif param.S == "meshing"
    M150 E0 R0 U0 B255 W0 S1 F1           ; Logo blue (distinct from cyan homing)
    M150 E0 R255 U255 B255 W255 S2 F0     ; Nozzle white
elif param.S == "printing"
    M150 E0 R255 U0 B0 W0 S1 F1           ; Logo red (wait to flush)
    M150 E0 R255 U255 B255 W255 S2 F0     ; Nozzle white, flush strip
    M106 P2 S0                            ; LED bar off while printing
elif param.S == "error"
    ; Flash all LEDs red 20 times, then leave solid dim red
    while iterations < 20
        M150 E0 R255 U0 B0 W0 P255 S3 F0  ; All LEDs bright red
        G4 P400
        M150 E0 R0 U0 B0 W0 P0 S3 F0      ; All LEDs off
        G4 P400
    M150 E0 R255 U0 B0 W0 P200 S3 F0      ; Solid dim red = "come look at me"
elif param.S == "off"
    M150 E0 P0 S3                         ; Turn off all
elif param.S == "red"
    M150 E0 R255 P255 S3
elif param.S == "green"
    M150 E0 U255 P255 S3
elif param.S == "blue"
    M150 E0 B255 P255 S3
elif param.S == "white"
    M150 E0 W255 P255 S3
elif param.S == "super_white"
    M150 E0 W255 R255 U255 B255 P255 S3   ; White channel + RGB white
else
    echo "led.g: unknown LED state " ^ param.S

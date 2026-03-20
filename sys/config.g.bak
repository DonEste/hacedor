; Configuration file for RepRapFirmware on Duet 3 Mini 5+ Ethernet
; executed by the firmware on start-up
;

; General
G90                                                                 ; absolute coordinates
M83                                                                 ; relative extruder moves
M550 P"Hacedor"                                                     ; set hostname

; Wait a moment for the CAN expansion boards to become available
G4 S2

; Accelerometers
M955 P121.0 I20                                                     ; configure accelerometer on board #121

; Smart Drivers
M569 P0.0 S0 D3 V0                                                  ; driver 0.0 goes backwards (Z axis)
M569 P0.1 S1 D3 V0                                                  ; driver 0.1 goes forwards (Z axis)
M569 P0.2 S1 D3 V0                                                  ; driver 0.2 goes forwards (Z axis)
M569 P0.3 S0 D3 V0                                                  ; driver 0.3 goes backwards (Z axis)
M569 P0.5 S1 D3 V0                                                  ; driver 0.5 goes forwards (Y axis)
M569 P0.6 S1 D3 V0                                                  ; driver 0.6 goes forwards (X axis)
M569 P121.0 S0 D3 V0                                                ; driver 121.0 goes backwards (extruder 0)

; Axes
M584 X0.6 Y0.5 Z0.0:0.1:0.2:0.3                                     ; set axis mapping
M350 X16 Y16 Z16 I1                                                 ; configure microstepping with interpolation
M906 X1300 Y1300 Z900                                               ; set axis driver currents
M92 X80 Y80 Z400                                                    ; configure steps per mm
M208 X0:300 Y0:300 Z0:260                                           ; set minimum and maximum axis limits
M566 X400 Y400 Z50                                                  ; set maximum instantaneous speed changes (mm/min)
M203 X10800 Y10800 Z1200                                            ; set maximum speeds (mm/min)
M201 X5000 Y5000 Z400                                               ; set accelerations (mm/s^2)

; Extruders
M584 E121.0                                                         ; set extruder mapping
M350 E16 I1                                                         ; configure microstepping with interpolation
M906 E500                                                           ; set extruder driver currents
M92 E727.57                                                         ; configure steps per mm
M566 E2000                                                          ; set maximum instantaneous speed changes (mm/min)
M203 E3600                                                          ; set maximum speeds (mm/min)
M201 E1000                                                          ; set accelerations (mm/s^2)

; Kinematics
M669 K1                                                             ; configure CoreXY kinematics
M671 X350:350:-50:-50 Y-50:350:-50:350 S10                          ; z stepper position

; Probes
M558 K0 P8 C"121.io1.in" H5 F1500:120 T8000                         ; configure unfiltered digital probe via slot #0
G31 P500 X25 Y0 Z2.9                                               ; set Z probe trigger value, offset and trigger height (offser macro value: Z)

; Endstops
M574 X2 P"!io0.in" S1                                               ; configure X axis endstop
M574 Y1 P"!io1.in" S1                                               ; configure Y axis endstop
M574 Z1 S2                                                          ; configure Z axis endstop

; Sensors
M308 S0 P"temp0" Y"thermistor" A"Heated Bed" T100000 B4725 C7.06e-8 ; configure sensor #0
M308 S1 P"121.temp0" Y"thermistor" A"Nozzle" T100000 B4725 C7.06e-8 ; configure sensor #1

; Heaters
M950 H0 C"out0" T0                                                  ; create heater #0
M143 H0 P0 T0 C0 S125 A0                                            ; configure heater monitor #0 for heater #0
M307 H0 R2.43 D5.5 E1.35 K0.56 B0                                   ; configure model of heater #0
M950 H1 C"121.out0" T1                                              ; create heater #1
M143 H1 P0 T1 C0 S285 A0                                            ; configure heater monitor #0 for heater #1
M307 H1 R2.43 D5.5 E1.35 K0.56 B0                                   ; configure model of heater #1

; Heated beds
M140 P0 H0                                                          ; configure heated bed #0

; Fans
M950 F0 C"121.out1"                                                 ; create fan #0
M106 P0 S0 L0 X0.9 B0.1                                             ; configure fan #0
M950 F1 C"121.out2" Q500                                            ; create fan #1
M106 P1 S0 B0.1 H1 T100 X0.9                                        ; configure fan #1
M950 F2 C"out5" Q500                                                ; create fan #2
M950 F3 C"out6" Q500                                                ; create fan #3

; Tools
M563 P0 D0 H1 F0                                                    ; create tool #0
M568 P0 R0 S0                                                       ; set initial tool #0 (Toolhead) active temp to 200C and standby temp to 0C

; Miscellaneous
M501                                                                ; load saved parameters from non-volatile memory
T0                                                                  ; select first tool
M950 E0 C"121.io0.out" T2 U3                                        ; configure LED strip #0
M591 P7 C"121.io2.in" S1 L7 E20 D0                                  ; filament monitor connected to E0 endstop
M557 X25:275 Y25:275 S50                                            ; define grid for mesh bed compensation
M207 S1                                                             ; retraction
M572 D0 S0.04                                                       ; pressure advance
M929 P"log.log" S3                                                  ; start logging debug to file log.log (S0=off,S1=WARN,S2=INFO,S3=DEBUG)
M106 P3 S180                                                        ; start fans
;M98 P"/macros/Leds On"                                              ; All leds on
M98 P"truelevel.g"                                                  ; home all
M593 P"zvd" F60                                                     ; input shaping
;M452 C"io2.out" R255 F200                                           ; Enable Laser mode, on out6, with max intensity being 255, and a PWM frequency of 200
M451                                                                ; set printer mode
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
M569 P0.0 S0 D3 V30                                                 ; driver 0.0 goes backwards (Z axis)
M569 P0.1 S1 D3 V30                                                 ; driver 0.1 goes forwards (Z axis)
M569 P0.2 S1 D3 V30                                                 ; driver 0.2 goes forwards (Z axis)
M569 P0.3 S0 D3 V30                                                 ; driver 0.3 goes backwards (Z axis)
M569 P0.5 S1 D3 V30                                                 ; driver 0.5 goes forwards (Y axis)
M569 P0.6 S0 D3 V30                                                 ; driver 0.6 goes backwards (X axis)
M569 P121.0 S0 D3 V30                                               ; driver 121.0 goes backwards (extruder 0)

; Axes
M584 X0.6 Y0.5 Z0.0:0.1:0.2:0.3                                     ; set axis mapping
M350 X16 Y16 Z16 I1                                                 ; configure microstepping with interpolation
M906 X800 Y800 Z600                                                 ; set axis driver currents
M92 X80 Y80 Z400                                                    ; configure steps per mm
M208 X0:300 Y0:300 Z0:300                                           ; set minimum and maximum axis limits
M566 X600 Y600 Z200                                                 ; set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z1000                                            ; set maximum speeds (mm/min)
M201 X2500 Y2500 Z500                                               ; set accelerations (mm/s^2)

; Extruders
M584 E121.0                                                         ; set extruder mapping
M350 E16 I1                                                         ; configure microstepping with interpolation
M906 E600                                                           ; set extruder driver currents
M92 E727.57                                                         ; configure steps per mm
M566 E120                                                           ; set maximum instantaneous speed changes (mm/min)
M203 E3600                                                          ; set maximum speeds (mm/min)
M201 E500                                                           ; set accelerations (mm/s^2)

; Kinematics
M669 K1                                                             ; configure CoreXY kinematics
M671 X-50:-50:330:330 Y350:-50:350:-50 S10                          ; z stepper position

; Probes
M558 K0 P8 C"121.io1.in" H5 F1800:120 T6000                         ; configure unfiltered digital probe via slot #0
G31 P500 X0 Y0 Z2.24                                                ; set Z probe trigger value, offset and trigger height

; Endstops
M574 X1 P"!io0.in" S1                                               ; configure X axis endstop
M574 Y2 P"!io1.in" S1                                               ; configure Y axis endstop
M574 Z1 S2                                                          ; configure Z axis endstop

; Sensors
M308 S0 P"temp0" Y"thermistor" A"Heated Bed" T100000 B4725 C7.06e-8 ; configure sensor #0
M308 S1 P"121.temp0" Y"thermistor" A"Nozzle" T100000 B4725 C7.06e-8 ; configure sensor #1

; Heaters
M950 H0 C"out0" T0                                                  ; create heater #0
M143 H0 P0 T0 C0 S125 A0                                            ; configure heater monitor #0 for heater #0
M307 H0 R2.43 D5.5 E1.35 K0.56 B0                                   ; configure model of heater #0
M950 H1 C"121.out0" T1                                              ; create heater #1
M143 H1 P0 T1 C0 S270 A0                                            ; configure heater monitor #0 for heater #1
M307 H1 R2.43 D5.5 E1.35 K0.56 B0                                   ; configure model of heater #1

; Heated beds
M140 P0 H0                                                          ; configure heated bed #0

; Fans
M950 F0 C"121.out1"                                                 ; create fan #0
M106 P0 S0 L0 X1 B0.1                                               ; configure fan #0
M950 F1 C"121.out2"                                                 ; create fan #1
M106 P1 S0 B0.1 H1 T100                                             ; configure fan #1

; Tools
M563 P0 D0 H1 F0                                                    ; create tool #0
M568 P0 R0 S0                                                       ; set initial tool #0 active and standby temperatures to 0C

; Miscellaneous
M501                                                                ; load saved parameters from non-volatile memory
T0                                                                  ; select first tool
M950 E0 C"led" T2 U3                                                ; configure LED strip #0
M150 E0 W255 R255 U255 B255 P1 S1 F1                                ; set first to blue but weak ; set the first led to weak white
M150 E0 W255 R255 U255 B255 P255 S2                                 ; set the rest to brigth white
M557 X0:300 Y0:300 S100:100                                         ; define grid for mesh bed compensation
M207 S0.5                                                           ; retraction
M572 D0 S0.04                                                       ; pressure advance
M929 P"log1.log" S3                                                 ; start logging warnings to file a_eventlog.txt
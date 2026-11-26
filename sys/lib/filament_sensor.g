; sys/lib/filament_sensor.g - enable/disable the filament monitor
; Usage: M98 P"/sys/lib/filament_sensor.g" S1   (on)
;        M98 P"/sys/lib/filament_sensor.g" S0   (off)
; The pin definition lives here and in config.g (startup) only.

if !exists(param.S)
    abort "filament_sensor.g: missing S parameter (0 or 1)"

M591 P7 C"121.io2.in" S{param.S} L7 E20 D0   ; filament monitor on the E0 endstop input

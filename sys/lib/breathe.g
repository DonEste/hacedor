; sys/lib/breathe.g - wait until the current tool's heater is near target, pulsing the LEDs
; Usage: M98 P"/sys/lib/breathe.g" T<target> [U<rise step>] [D<fall step>] [W<ms between steps>]
; Defaults: U25 D25 W200. The caller sets the heater target (M104) and does the final M109.
; Safety: aborts when the heater reports a fault, or after 600 s without reaching the target
; (the firmware heater fault detection, M570, is the primary protection).

if !exists(param.T)
    abort "breathe.g: missing T parameter (target temperature)"

var heater = tools[max(0, state.currentTool)].heaters[0]
var rise = exists(param.U) ? param.U : 25
var fall = exists(param.D) ? param.D : 25
var delay = exists(param.W) ? param.W : 200
var brightness = 0
var direction = var.rise
var start = state.upTime

while heat.heaters[var.heater].current < param.T - 2
    if heat.heaters[var.heater].state == "fault" || state.upTime - var.start > 600
        M104 S0
        M98 P"/sys/lib/led.g" S"error"
        abort "SAFETY: heater fault or heat-up timeout (600 s)."

    set var.brightness = max(0, min(250, var.brightness + var.direction))
    if var.brightness >= 250
        set var.direction = -var.fall
    elif var.brightness <= 0
        set var.direction = var.rise
    M150 E0 R{var.brightness} U{floor(var.brightness * 0.47)} B0 W0 S1 F1   ; Logo: pulse orange
    M150 E0 R150 U150 B150 W150 S2 F0                                       ; Nozzle: steady warm white
    G4 P{var.delay}

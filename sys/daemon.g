; daemon.g - runs continuously in the background (RRF restarts it, so it must contain a delay)
;
; Fan 3 ("Board & Pi Fan", out6) cools BOTH the Duet board and the Raspberry Pi.
; Normally it stays in the firmware's thermostatic mode (MCU and drivers, sensors 2 and 3, 35-55 C),
; exactly as configured in config.g. When the Pi CPU gets hot this daemon takes manual control
; and runs the fan at the higher of the Pi demand and the board demand, then hands control back
; to the thermostatic mode once the Pi has cooled down.
;
; Tune the numbers below. Pi 3B+ starts throttling at 60 C (from memory), so 55 C leaves some margin.

var fan       = 3        ; fan number (config.g: M950 F3 C"out6")
var piOn      = 55       ; Pi: start helping at or above this temperature (C)
var piOff     = 50       ; Pi: hand back to thermostatic mode at or below this (C)
var piFull    = 65       ; Pi: 100% fan at this temperature (C)
var minSpeed  = 0.4      ; lowest duty while the daemon is in control (fans stall below ~30-40%)
var boardLow  = 35       ; must match config.g: M106 P3 ... T35:55
var boardHigh = 55

if !exists(global.piFanActive)
    global piFanActive = false   ; true while this daemon holds the fan in manual mode
if !exists(global.piFanLast)
    global piFanLast = -1        ; last speed this daemon set

if exists(sbc.cpu.temperature)
    var t = sbc.cpu.temperature
    var needed = var.t >= var.piOn || (global.piFanActive && var.t > var.piOff)

    if var.needed
        ; demand from the Pi (ramp minSpeed..1) and from the board (replicates the thermostatic ramp)
        var piSpeed = var.minSpeed + (1 - var.minSpeed) * (var.t - var.piOff) / (var.piFull - var.piOff)
        var boardT = max(sensors.analog[2].lastReading, sensors.analog[3].lastReading)
        var boardSpeed = (var.boardT - var.boardLow) / (var.boardHigh - var.boardLow)
        var s = max(var.minSpeed, max(var.piSpeed, var.boardSpeed))
        set var.s = round(min(1, var.s) * 20) / 20     ; 5% steps, avoids constant tiny changes

        if !global.piFanActive || global.piFanLast != var.s
            M106 P{var.fan} H-1 S{var.s}               ; manual mode at this speed
            set global.piFanLast = var.s
            set global.piFanActive = true
    elif global.piFanActive
        M106 P{var.fan} H2:3 T35:55 X1                 ; back to thermostatic (same as config.g)
        set global.piFanActive = false
        set global.piFanLast = -1

G4 S5                                                  ; check every 5 seconds

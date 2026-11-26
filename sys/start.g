; start.g
; called when a print job starts (before the print file's G-code is executed)
;

; --- Stealthburner LED Start Sequence ---
;M150 E0 R255 U0 B0 W0 S1 F1       ; Set LED 1 (Logo) to Red (wait to flush)
;M150 E0 R255 U255 B255 W255 S2 F0 ; Set LEDs 2 & 3 (Nozzle) to White and flush strip

; --- Pre-Print Calibration ---
;G32                               ; Home all axes, perform quad Z-leveling, and run mesh bed compensation (calls bed.g)
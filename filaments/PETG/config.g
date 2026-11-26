; filaments/PETG/config.g - applied when PETG is assigned/loaded
; Every filament config must set ALL values the others change, so nothing leaks between filaments.
M572 D0 S0.04                  ; pressure advance (same as config.g default)
M556 S100 X0 Y0 Z0             ; no skew compensation

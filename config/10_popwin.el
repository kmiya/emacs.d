(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(push '("*anything*" :height 20) popwin:special-display-config)
(push '(dired-mode :position top) popwin:special-display-config)
(push '("*auto-async-byte-compile*" :height 20) popwin:special-display-config)
(push '("*Compile-Log*" :height 20) popwin:special-display-config)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)

(require 'summarye)

(setq-default tab-width 4)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

(require 'text-translator)
(setq text-translator-auto-selection-func
      'text-translator-translate-by-auto-selection-enja)

(which-function-mode 1)
(setq which-function-mode t)
(delete (assoc 'which-function-mode mode-line-format) mode-line-format)
;; (setq-default header-line-format '(which-function-mode ("" which-function-format)))

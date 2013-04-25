(require 'summarye)

(require 'text-translator)
(setq text-translator-auto-selection-func
      'text-translator-translate-by-auto-selection-enja)

(which-function-mode 1)
(setq which-function-mode t)
(delete (assoc 'which-function-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-function-mode ("" which-function-format)))

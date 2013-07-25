(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

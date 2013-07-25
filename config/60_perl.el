(dolist (hook '(perl-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

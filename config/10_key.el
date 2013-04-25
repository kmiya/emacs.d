;; sequential-command
(require 'sequential-command-config)
(sequential-command-setup-keys)

;; key-chord
(require 'key-chord)
(setq key-chord-two-keys-delay 0.04)
(key-chord-mode 1)
;; jk で auto-complete を実行
(key-chord-define-global "kl" 'auto-complete)
;; jk で view-mode を実行
(key-chord-define-global "jk" 'view-mode)
;; emacs-lisp-mode で df を押すと describe-function を実行する
(key-chord-define emacs-lisp-mode-map "df" 'describe-function)
;; emacs-lisp-mode で df を押すと describe-variable を実行する
(key-chord-define emacs-lisp-mode-map "dv" 'describe-variable)

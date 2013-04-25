(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
;; (define-auto-insert "\\.rb$" "ruby-template.rb")

;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; yasnipet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; hippie-expand
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-abbrev
        try-expand-abbrev-all-buffers
        try-expand-abbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        ))
(global-set-key (kbd "M-/") 'hippie-expand)
        

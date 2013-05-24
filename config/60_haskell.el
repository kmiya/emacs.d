(require 'haskell-mode)
(require 'haskell-cabal)
(require 'ghc-doc)
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
;; (setq ghc-module-command "~/.cabal/bin/ghc-mod")
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用

;; key-comboの設定用関数
(require 'key-combo)
;; (key-combo-load-default)
(defun my-haskell-key-combo ()
  (key-combo-define-local (kbd "-") '("-" " -> " "--"))
  ;; (key-combo-define-local (kbd "<=") '("<="))
  (key-combo-define-local (kbd "<") '("<" " <- " " <= " " =<< " "<<" "<"))
  (key-combo-define-local (kbd ">") '(">" " >= " " >>= " ">"))
  (key-combo-define-local (kbd "=") '("=" " = " " == " "=="))
  (key-combo-define-local (kbd ":") '(":" " :: " "::"))
  )

;; 後でまとめてadd-hookするための関数
(defun my-haskell-add-hook ()
  (turn-on-haskell-indentation)
  (my-haskell-key-combo)
  )
(add-hook 'haskell-mode-hook 'my-haskell-add-hook)

(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)

(defvar anything-c-source-ghc-mod
  '((name . "ghc-browse-document")
    (init . anything-c-source-ghc-mod)
    (candidates-in-buffer)
    (candidate-number-limit . 9999999)
    (action ("Open" . anything-c-source-ghc-mod-action))))

(defun anything-c-source-ghc-mod ()
  (unless (executable-find "ghc-mod")
    (error "ghc-mod を利用できません。ターミナルで which したり、*scratch* で exec-path を確認したりしましょう"))
  (let ((buffer (anything-candidate-buffer 'global)))
    (with-current-buffer buffer
      (call-process "ghc-mod" nil t t "list"))))

(defun anything-c-source-ghc-mod-action (candidate)
  (interactive "P")
  (let* ((pkg (ghc-resolve-package-name candidate)))
    (anything-aif (and pkg candidate)
        (ghc-display-document pkg it nil)
      (message "No document found"))))

(defun anything-ghc-browse-document ()
  (interactive)
  (anything anything-c-source-ghc-mod))

;; M-x anything-ghc-browse-document() に対応するキーの割り当て
;; ghc-mod の設定のあとに書いた方がよいかもしれません
(add-hook 'haskell-mode-hook
  (lambda()
    (define-key haskell-mode-map (kbd "C-M-d") 'anything-ghc-browse-document)))

(require 'auto-complete)
;;; Auto-complete
(ac-define-source ghc-mod
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

(add-hook 'find-file-hook 'my-haskell-ac-init)


;;; fly-make
(require 'flymake)

;; flymake
(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "ghc"
        (list "--make" "-fbyte-code"
              (concat "-i"base-dir)  ;;; can be expanded for additional -i options as in the Perl script
              source)))

(defvar multiline-flymake-mode nil)
(defvar flymake-split-output-multiline nil)

;; this needs to be advised as flymake-split-string is used in other places and I don't know of a better way to get (and )t the caller's details
(defadvice flymake-split-output
  (around flymake-split-output-multiline activate protect)
  (if multiline-flymake-mode
      (let ((flymake-split-output-multiline t))
        ad-do-it)
    ad-do-it))

(defadvice flymake-split-string
  (before flymake-split-string-multiline activate)
  (when flymake-split-output-multiline
    (ad-set-arg 1 "^\\s *$")))

;; Why did nobody tell me about eval-after-load - very useful
(eval-after-load "flymake"
  '(progn
     (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.l?hs$" flymake-Haskell-init flymake-simple-java-cleanup))
     (add-to-list 'flymake-err-line-patterns
                  '("^\\(.+\\.l?hs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\\(?:.\\|\\W\\)+\\)"
                    1 2 3 4))))

(add-hook
 'haskell-mode-hook
 '(lambda ()
    (set (make-local-variable 'multiline-flymake-mode) t)))

;; (defun my/display-error-message ()
;; (let ((orig-face (face-attr-construct 'popup-tip-face)))
;;   (set-face-attribute 'popup-tip-face nil
;;                       :height 1.5 :foreground "firebrick"
;;                       :background "LightGoldenrod1" :bold t)
;;   (unwind-protect
;;       (flymake-display-err-menu-for-current-line)
;;     (while orig-face
;;       (set-face-attribute 'popup-tip-face nil (car orig-face) (cadr orig-face))
;;       (setq orig-face (cddr orig-face))))))

;; (defadvice flymake-goto-prev-error (after flymake-goto-prev-error-display-message)
;;   (my/display-error-message))
;; (defadvice flymake-goto-next-error (after flymake-goto-next-error-display-message)
;;   (my/display-error-message))
 
;; (ad-activate 'flymake-goto-prev-error 'flymake-goto-prev-error-display-message)
;; (ad-activate 'flymake-goto-next-error 'flymake-goto-next-error-display-message)
 
;; ;; avoid abnormal exit
;; (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;;   (setq flymake-check-was-interrupted t))
;; (ad-activate 'flymake-post-syntax-check)
 
;; (global-set-key (kbd "M-n") 'flymake-goto-next-error)
;; (global-set-key (kbd "M-p") 'flymake-goto-prev-error)

(define-key haskell-mode-map (kbd "C-c C-v") 'flymake-display-err-menu-for-current-line)





















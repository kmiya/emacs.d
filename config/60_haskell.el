(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
(setq ghc-module-command "~/.cabal/bin/ghc-mod")
;; (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用

;; key-comboの設定用関数
(require 'key-combo)
(key-combo-load-default)
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
  (font-lock-mode)
  (my-haskell-key-combo)
  )

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

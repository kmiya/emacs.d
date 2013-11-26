(add-to-list 'load-path "~/.emacs.d/")

;; ロードパスを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
          (expand-file-name (concat user-emacs-directory path))))
    (add-to-list 'load-path default-directory)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "auto-install" "elpa" "config" "ghc-mod" "plugins")

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil) ; 起動時のログバッファを表示しない
(init-loader-load "~/.emacs.d/config/")
(if (not (equal (init-loader-error-log) "")) ; エラーがあったときだけログバッファを表示
    (init-loader-show-log))

;; point-undo
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)

;; goto-chg
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

;;; try-expand-abbrev を dabbrev-complemention に
(global-set-key "\M-/" 'dabbrev-completion)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

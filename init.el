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
(add-to-load-path "auto-install" "elpa" "config" "ghc-mod")

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

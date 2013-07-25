;;起動時のフレームサイズを設定する
(setq initial-frame-alist
      (append (list
               '(width . 110)
               '(height . 60)
               )
              initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;;; theme
;; (load-theme 'misterioso t)

;;; 折り返し記号の色
(set-face-background 'fringe "gray99") ;;背景色薄いグレーに
(set-face-foreground 'fringe "gray95") ;;表示色薄いグレーに

;; viewer.el
(require 'viewer)
;; 書き込めないファイルは常にview-mode
(viewer-stay-in-setup)
;; view-modeのときはモードラインの色を変える
(setq viewer-modeline-color-unwritable "tomato"
      viewer-modeline-color-view "orange")
(viewer-change-modeline-color-setup)
(setq view-mode-by-default-regexp "\\.log$")

(defvar pager-keybind
      `( ;; vi-like
        ("h" . backward-word)
        ("l" . forward-word)
        ("j" . next-window-line)
        ("k" . previous-window-line)
        (";" . gene-word)
        ("b" . scroll-down)
        (" " . scroll-up)
        ;; w3m-like
        ("m" . gene-word)
        ("i" . win-delete-current-window-and-squeeze)
        ("w" . forward-word)
        ("e" . backward-word)
        ("(" . point-undo)
        (")" . point-redo)
        ("J" . ,(lambda () (interactive) (scroll-up 1)))
        ("K" . ,(lambda () (interactive) (scroll-down 1)))
        ;; bm-easy
        ("." . bm-toggle)
        ("[" . bm-previous)
        ("]" . bm-next)
        ;; langhelp-like
        ("c" . scroll-other-window-down)
        ("v" . scroll-other-window)
        ))
(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;; font
(if window-system
    (progn
      ;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10.5:weight=bold"))
      (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10.5"))
      (set-fontset-font "fontset-default"
			'japanese-jisx0208
			'("TakaoEx明朝" . "iso10646-1"))
      (set-fontset-font "fontset-default"
			'katakana-jisx0201
			'("TakaoEx明朝" . "iso10646-1"))
      (setq face-font-rescale-alist
	    '(
	      (".*TakaoEx明朝.*" . 1.0)
	      ))
      )
  )

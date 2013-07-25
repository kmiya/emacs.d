;; カーソルの位置のファイルを開く
(ffap-bindings)

;; ファイル名がかぶった場合にバッファ名をわかりやすくする
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; * で囲まれたバッファ名は対象外にする
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; iswitchb
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-prompt-newbuffer nil)
;;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
	  (lambda ()
	    (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
	    (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
	    (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
	    (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))
;;; iswitchbで補完対象に含めないバッファ
(setq iswitchb-buffer-ignore
      '(
	"*SKK annotation*"
	"*Completions*"
	"*YaTeX-typesetting*"
	"*YaTeX-makeindex*"
	"*dvi-preview*"
	"*Minibuf-1*"
	"*Minibuf-0*"
	"^\\*auto-install.*"
        ))
(ido-mode 1)
;(ido-everywhere 1)

;; recentf
(setq recentf-save-file "~/.emacs.d/recentf")
(setq recentf-max-saved-items 3000)
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf)
(require 'recentf-ext)
(recentf-mode 1)
(recentf-save-list)
;; (global-set-key (kbd "C-x f") 'recentf-open-files)

;; bookmark
(setq bookmark-save-flag 1)
(progn
  (setq bookmark-sort-flag nil)
  (defun bookmark-arrange-latest-top ()
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (cons latest (delq latest bookmark-alist))))
    (bookmark-save))
  (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))

;;ディレクトリを最初に表示する
(setq ls-lisp-dirs-first t)

;; wdired
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

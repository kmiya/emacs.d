;;====================================
;; Language
;;====================================
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8)
;; encording for file name
;(require 'utf-8m)
(set-file-name-coding-system 'utf-8-unix)

;;====================================
;; package
;;====================================
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(setq package-enable-at-startup 1)
; Adjusting load-path after updating packages
(defun package-update-load-path ()
  "Update the load path for newly installed packages."
  (interactive)
  (let ((package-dir (expand-file-name package-user-dir)))
    (mapc (lambda (pkg)
            (let ((stem (symbol-name (car pkg)))
		  (version "")
		  (first t)
		  path)
	      (mapc (lambda (num)
		      (if first
			  (setq first nil)
			  (setq version (format "%s." version)))
		      (setq version (format "%s%s" version num)))
		    (aref (cdr pkg) 0))
              (setq path (format "%s/%s-%s" package-dir stem version))
              (add-to-list 'load-path path)))
          package-alist)))

;;====================================
;; auto-install
;;====================================
(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq auto-install-use-wget t)
(require 'cl)
(defun my-erase-auto-install-buffer ()
  (interactive)
  (dolist (buf (buffer-list))
    (if (eq (string-match "^\\*auto-install " (buffer-name buf)) 0)
        (progn
	   ;; (print "ok")
	   (kill-buffer buf)))))
;;実行する
(add-hook 'find-file-hook 'my-erase-auto-install-buffer)

;;====================================
;; auto-async-byte-compile
;;====================================
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;====================================
;; misc
;;====================================
;; Webページの閲覧に Firefox を使う
(setq browse-url-browser-function 'browse-url-firefox)
;;現在の行に色をつける
(global-hl-line-mode 1)
;;履歴を保存する
(savehist-mode 1)
;;ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)
;; file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)
;; 一行ずつスクロールさせる
;; (setq scroll-step 1)
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
;;C-h で後退
(global-set-key (kbd "C-h") 'delete-backward-char)
;;タブの代わりに半角スペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)
;;自動再読み込み
(global-auto-revert-mode 1)
;;モードラインに時刻を表示
(display-time)
;;列を表示
(column-number-mode 1)
;;カーソルの点滅を止める
(blink-cursor-mode 0)
;;行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)
;;タイトルバーにファイル名を表示する
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))
;;GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))
;;ログの記録行数を増やす
(setq message-log-max 10000)
;;ミニバッファを再帰的に呼び出せるようにする
(setq enable-recursive-minibuffers t)
;;ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)
;;キーストロークを素早く表示
(setq echo-keystrokes 0.1)
;;ミニバッファで入力を取り消しても履歴に残す
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))
;;分割していないときは左右分割して新しいウィンドウに移る
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)
;;起動時のメッセージを消す
(setq inhibit-startup-message t)
;; scratch の初期メッセージを消去
(setq initial-scratch-message "")
;; 対応する括弧を光らせる（グラフィック環境のみ作用）
(show-paren-mode 1)
;;ツールバーを消す
(tool-bar-mode 0)
;;メニューバーを消す
(menu-bar-mode 0)
;;"yes or no"を"y or n"にする
(fset 'yes-or-no-p 'y-or-n-p)
;;無駄な空行に気付きやすくする
(setq-default indicate-empty-lines t)
;;テンポラリバッファのサイズをいい感じに
(temp-buffer-resize-mode 1)

;;====================================
; backup
;;====================================
;; バックアップファイルを作成する。
(setq make-backup-files t)
;;バックアップファイルの保存場所を指定
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.backup"))
	    backup-directory-alist))
(setq version-control t)     ; 複数のバックアップを残します。世代。
(setq kept-new-versions 5)   ; 新しいものをいくつ残すか
(setq kept-old-versions 5)   ; 古いものをいくつ残すか
(setq delete-old-versions t) ; 確認せずに古いものを消す。
(setq vc-make-backup-files t) ; バージョン管理下のファイルもバックアップを作る。

;;ミニバッファ履歴リストの最大長：tなら無限
(setq history-length 1000)
;; kill-ringやミニバッファで過去に開いたファイルなどの履歴を保存する
(require 'session)
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (add-hook 'after-init-hook 'session-initialize)
  ;; 前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1))
;; minibuf-isearch
;; minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)

;;====================================
;; emacsclient
;;====================================
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))
;; 編集が終了したらEmacsをアイコン化する
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
;; C-x C-c に割り当てる
(global-set-key (kbd "C-x C-c") 'server-edit)
;; M-x exitで終了
(defalias 'exit 'save-buffers-kill-emacs)

(eval-when-compile
  (require 'skk-vars)
  (require 'skk-autoloads)
)

;; ~/.skk にいっぱい設定を書いているのでバイトコンパイルしたい
(setq skk-byte-compile-init-file t)
;; 注) 異なる種類の Emacsen を使っている場合は nil にします

;; SKK を Emacs の input method として使用する
;;   C-\ で DDSKK が起動します
(setq default-input-method
      "japanese-skk"			; (skk-mode 1)
;;    "japanese-skk-auto-fill"		; (skk-auto-fill-mode 1)
      )

;; ~/.skk* なファイルがたくさんあるので整理したい
(setq skk-user-directory "~/.ddskk")

;; migemo を使うから skk-isearch にはおとなしくしていて欲しい
(setq skk-isearch-start-mode 'latin)

;; YaTeX のときだけ句読点を変更したい
(add-hook 'yatex-mode-hook
	  (lambda ()
	    (require 'skk)
	    (setq skk-kutouten-type 'en)))

;; Emacs 起動時に SKK を前もってロードする
(setq skk-preload t)

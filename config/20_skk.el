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

;; Enter で改行しない
(setq skk-egg-like-newline t)
;;"「"を入力したら"」"も自動で挿入
(setq skk-auto-insert-paren t)
;; 句読点変換ルール
(setq skk-kuten-touten-alist
  '(
    (jp . ("。" . "、" ))
    (en . ("．" . "，"))
    ))
;; jp でも ".""," を使う. ←最近不評でどうしたモンかしらん.
(setq skk-kutouten-type 'en)
;; 全角記号の変換
;; (setq skk-rom-kana-rule-list
;;       (append skk-rom-kana-rule-list
;;               '(("!" nil "!")
;;                 (":" nil ":")
;;                 (";" nil ";")
;;                 ("?" nil "?")
;;                 ("z " nil "　")
;;                 )))
;; 全角英語モードで U+FF0D, U+FF5E を入力する?
;; (when (not (string< mule-version "6.0"))
;;   (aset skk-jisx0208-latin-vector ?- (string #xFF0D))
;;   (aset skk-jisx0208-latin-vector ?~ (string #xFF5E)))
;; @で挿入する日付表示を西暦&半角に
(setq skk-date-ad t)
(setq skk-number-style nil)
;; 送り仮名が厳密に正しい候補を優先
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書の共有
(setq skk-share-private-jisyo t)

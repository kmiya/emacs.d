(require 'helm-config)
(helm-mode 1)
(require 'helm-descbinds)
(helm-descbinds-mode)
(require 'helm-migemo)
(setq helm-use-migemo t)

(global-set-key (kbd "C-x b") 'helm-for-files)
(global-set-key (kbd "C-x f") 'helm-for-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(require 'helm-c-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

(define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)

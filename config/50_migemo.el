;; Migemoが必要
;; C/Migemoがあれば優先して使う

(when (and (or (executable-find "migemo")
               (executable-find "cmigemo"))
           (require 'migemo nil t))
  ;; C/Migemoがある場合
  (when (executable-find "cmigemo")
    ;; コマンド定義
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))
    ;; 辞書指定
    (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
    (setq migemo-coding-system 'utf-8-unix)
    (setq migemo-user-dictionary nil)
    (setq migemo-regex-dictionary nil)))

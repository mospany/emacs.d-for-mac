(add-to-list 'load-path "~/.emacs.d/config")

;(load "init-elpa.el")
(load "init-base.el")
(load "init-face.el")
(load "init-func.el")
(load "init-dev.el")
(load "init-misc.el")
(load "init-misc-lazy.el")
(load "init-clipboard.el")
(load "init-evil.el")
(load "init-kbd.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cnblogs-blog-id "mosp")
 '(cnblogs-server-url "http://www.cnblogs.com/mosp/services/metaweblog.aspx")
 '(cnblogs-user-name "mosp")
 '(cnblogs-user-passwd "yxh_bir")
 '(ecb-options-version "2.40")
 '(go-add-tags-style (quote snake-case))
 '(markdown-command
   "pandoc -s -c ~/.emacs.d/style/markdown_github_style.css --mathjax --highlight-style espresso")
 '(org-agenda-files
   (quote
    ("~/github/mospany/private/mydoc/notes/gtd/life.org" "~/github/mospany/private/mydoc/notes/gtd/study.org" "~/github/mospany/private/mydoc/notes/gtd/home.org" "~/github/mospany/private/mydoc/notes/gtd/project.org" "~/github/mospany/private/mydoc/notes/gtd/task.org" "~/github/mospany/private/mydoc/notes/gtd/note.org")))
 '(package-selected-packages
   (quote
    (yasnippet yaml-mode yagist writeroom-mode wgrep w3m unfill undo-tree textile-mode tagedit string-edit smex simple-httpd session scss-mode scratch sass-mode rvm robe rinari regex-tool rainbow-mode rainbow-delimiters quack pomodoro pointback paredit page-break-lines neotree mwe-log-commands multiple-cursors multi-term move-text markdown-mode lua-mode link less-css-mode legalese json-mode js2-mode idomenu ibuffer-vc htmlize hl-sexp haskell-mode guide-key groovy-mode gitignore-mode gitconfig-mode git-timemachine git-link git-gutter ggtags fringe-helper flyspell-lazy flymake-sass flymake-ruby flymake-python-pyflakes flymake-lua flymake-jslint flymake-css flymake-coffee flx-ido fakir expand-region exec-path-from-shell erlang emmet-mode dsvn dropdown-list dired-details dired+ diminish dictionary define-word csharp-mode crontab-mode cpputils-cmake connection company-c-headers company-anaconda color-theme coffee-mode cmake-mode buffer-move bookmark+ bbdb auto-compile async ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-even-diff-A ((((class color) (background dark)) (:background "dark green"))))
 '(ediff-even-diff-B ((((class color) (background dark)) (:background "dark red"))))
 '(ediff-odd-diff-A ((((class color) (background dark)) (:background "dark green"))))
 '(ediff-odd-diff-B ((((class color) (background dark)) (:background "dark red"))))
 '(mumamo-background-chunk-major ((((class color) (background dark)) (:background "black"))))
 '(mumamo-background-chunk-submode1 ((((class color) (background dark)) (:background "black"))))
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))

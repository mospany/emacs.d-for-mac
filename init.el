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
 '(markdown-command "pandoc -s -c ~/.emacs.d/style/markdown_github_style.css --mathjax --highlight-style espresso")
 '(org-agenda-files (quote ("~/KuaiPan/mydoc/notes/gtd/life.org" "~/KuaiPan/mydoc/notes/gtd/study.org" "~/KuaiPan/mydoc/notes/gtd/home.org" "~/KuaiPan/mydoc/notes/gtd/project.org" "~/KuaiPan/mydoc/notes/gtd/task.org" "~/KuaiPan/mydoc/notes/gtd/note.org"))))
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
 '(mumamo-background-chunk-submode1 ((((class color) (background dark)) (:background "black")))))

(add-to-list 'load-path "~/.emacs.d/lib/ecb-2.40")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
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

(require 'ecb)
(require 'ecb-autoloads)

;;; ### ECB ###
;;; --- 代码浏览器
(setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1) ;;设置可以使用鼠标点击各个窗口的东东
;;(custom-set-variables '(ecb-options-version "2.4")) ;ECB的版本, 以使启动时不检查
(setq ecb-layout-window-sizes                        ;定制ECB窗口的布局
      (quote (("left8" (0.20967741935483872 . 0.27586206896551724)
               (0.20967741935483872 . 0.2413793103448276)
               (0.20967741935483872 . 0.27586206896551724)
               (0.20967741935483872 . 0.1724137931034483)))))
(setq ecb-tip-of-the-day nil)           ;启动ECB时不显示每日提示

(provide 'ecb-settings)


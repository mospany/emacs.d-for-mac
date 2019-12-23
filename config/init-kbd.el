;;设置emacs全屏的快捷键为f11
(global-set-key [f11] 'fullscreen-toggle)

;;启动时自动开启窗口半透明效果C-f5键用来切换
(global-set-key [C-f5] 'loop-alpha)

;;窗口的切换,光标移到上下左右窗口
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
;使用control-window-p/n/f/b移动窗口光标
(global-set-key (kbd "C-s-b") 'windmove-left)
(global-set-key (kbd "C-s-f") 'windmove-right)
(global-set-key (kbd "C-s-p") 'windmove-up)
(global-set-key (kbd "C-s-n") 'windmove-down)

;;对eshell的一些配置
;;目的是开一个shell的小buffer，用于更方便地测试程序(也就是运行程序了)，我经常会用到。
;;f8就是另开一个buffer然后打开shell，C-f6则是在当前的buffer打开shell,shift+f6清空eshell
(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  ;;(split-window-vertically)
  (split-window-horizontally)
  (eshell))
(defun my-eshell-clear-buffer ()
  "Eshell clear buffer."
  (interactive)
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))
;; (global-set-key [S-f6] 'my-eshell-clear-buffer)
(defun my-eshell-hook()
  (local-set-key "\C-l" 'my-eshell-clear-buffer))
(add-hook 'eshell-mode-hook 'my-eshell-hook)

;; 在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)

;; 按下C-x k立即关闭掉当前的buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;;跳到某一行
(global-set-key (kbd "C-x j") 'goto-line)

;; 快速移动
;;向下移动五行，绑定到 C-S-n
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))
;;向上移动五行
(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))
;;向前移动五行
(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))
;;向后移动五行
(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

;;重定义C-h键，将其改为向前删除一个字符
(global-set-key (kbd "C-h") 'delete-backward-char)

;;重定义M-h
(global-set-key (kbd "M-h") 'help-command)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)))

;;重命名当前缓冲区
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

;;将当前行向上，向下移动
(global-set-key (kbd "<M-down>") 'move-line-down)
(global-set-key (kbd "<M-up>") 'move-line-up)

;;C-return 在当前行上新开一行
;;C-S-return 在当前行下新开一行
(global-unset-key (kbd "C-o") )
(global-set-key (kbd "C-o") 'open-line-below)
(global-set-key (kbd "C-S-o") 'open-line-above)

;;代码注释的功能
(global-set-key "\M-;" 'qiang-comment-dwim-line) 

;;shell-pop
;;需先安装: sudo apt-get install ipython
(global-set-key [(C-f4)] 'shell-pop)

;;重做快捷键
(global-set-key (kbd "C-.") 'redo)

;;定义pylook的快捷键
(global-set-key [(C-f8)] 'pylookup-lookup);;搜索文档

;;ace-jump-mode 的快捷键
(define-key global-map [f5] 'ace-jump-mode)
(define-key global-map [f9] 'ace-jump-buffer)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x b") 'ace-jump-buffer)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;column-marker 快捷键
;; (global-set-key [?\C-c ?m] 'column-marker-1)

;; expand-region 快捷键
(global-set-key (kbd "C-c w") 'er/mark-word)
(global-set-key (kbd "C-c s") 'er/mark-symbol)
(global-set-key (kbd "C-c i p") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c o p") 'er/mark-outside-pairs)
(global-set-key (kbd "C-c i q") 'er/mark-inside-quotes)
(global-set-key (kbd "C-c o q") 'er/mark-outside-quotes)

;; tabbar的快捷键
(global-set-key [C-up] 'tabbar-backward-group)
(global-set-key [C-down] 'tabbar-forward-group)
(global-set-key [C-left]   'tabbar-backward)
(global-set-key [C-right]   'tabbar-forward)
;使用shift-window-p/n/f/b移动标签页
(global-set-key (kbd "s-P") 'tabbar-backward-group)
(global-set-key (kbd "s-N") 'tabbar-forward-group)
(global-set-key (kbd "s-B") 'tabbar-backward)
(global-set-key (kbd "s-F") 'tabbar-forward)
; 翻页
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)

;;hide region
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)
;; hide lines
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)

;书签功能
;; C-F2 在当前行设置或取消书签
;; F2 查找下一个书签
;; S-F2 查找上一个书签
;; C-S-F2 清空当前文件的所有书签
(global-set-key (kbd "<C-f2>") 'bm-toggle)     
(global-set-key (kbd "<f2>")   'bm-next)      
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "<C-S-f2>") 'bm-remove-all-current-buffer) 

;;compile
;在Emacs源代码窗口中按F5就可以进行编译
(define-key c-mode-base-map [(f6)] 'compile)

;; 高亮指定关键字
(global-set-key (kbd "C-c M-h") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c M-r") 'highlight-symbol-remove-all)
(global-set-key (kbd "C-c M-n") 'highlight-symbol-next)
(global-set-key (kbd "C-c M-p") 'highlight-symbol-prev)


;;高亮显示设置
(global-set-key (kbd "C-c / M-f") 'highlight-fixmes-mode)

;使用C-x C-m代替M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;使用 backward-kill-word (向后删一词)而不是 Backspace（向后删一字）
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
;使用M-x qrr 别名为M-x query-replace-regexp
(defalias 'qrr 'query-replace-regexp)

;Shift+Space设置标记（set-mark)。
;;C-SPC 用来给中文输入法使用了
;;(global-set-key (kbd "C-SPC") 'set-mark-command)
;(global-set-key (kbd "C-SPC") nil)
(global-set-key [?\S- ] 'set-mark-command)

;;gdb
;将control-F6、F,F7、F8分别绑定到gud-go、gud-step和gud-next
(add-hook 'gdb-mode-hook '(lambda ()
                                                        (define-key c-mode-base-map [(C-f6)] 'gud-go)
                                                        (define-key c-mode-base-map [(C-f7)] 'gud-step)
                                                        (define-key c-mode-base-map [(C-f8)] 'gud-next)))
(setq gdb-many-windows t)
(setq gud-tooltip-mode t)

;一些窗口全局配置
(global-unset-key [f10])
(global-unset-key [f12])
(global-set-key [f10] 'ibuffer)
;;f3就是另开一个buffer然后打开shell
(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))
(global-set-key [(f3)] 'open-eshell-other-buffer)
(global-set-key [C-f3] 'man)
(global-set-key [f4] 'eshell)
(global-set-key [C-f9] 'ecb-activate)
(global-set-key [S-f9] 'ecb-deactivate)
(global-set-key [C-f10] 'imenu-list-smart-toggle) ;;imenu-list-smart-toggle按键绑定
(global-set-key [S-f10] 'sr-speedbar-toggle) ;;sr-speedbar按键绑定
(global-set-key [C-f11] 'ediff)
(global-set-key [S-f11] 'ediff-directories)
(global-set-key [f12] 'svn-status)
(global-set-key [S-f12] 'git-status)

;;shell配置
(setq shell-file-name "/bin/zsh")
;shell着色
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
;(global-set-key (kbd "<f10>") 'eshell)
;(global-set-key (kbd "<C-f10>") 'rename-buffer)
;使用 Ctrl-c ← （对，就是向左的箭头键）组合键，退回你的上一个窗口设置。
 (when (fboundp 'winner-mode)
    (winner-mode)
        (windmove-default-keybindings))

;;插入日期
(defun my-insert-date ()
    (interactive)
    (insert (format-time-string "%Y/%m/%d " (current-time))))
    (global-set-key (kbd "C-c C-d") 'my-insert-date)
;;插入时间
(defun my-insert-time ()
    (interactive)
    (insert (format-time-string "%Y/%m/%d %H:%M:%S " (current-time))))
    (global-set-key (kbd "C-c C-t") 'my-insert-time)

;;Buffer管理
;; 按下C-x k立即关闭掉当前的buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;;在历史编辑中跳转 http://www.emacswiki.org/emacs/GotoChg
;(global-set-key (kbd "C-c c") 'goto-last-change) ;;设置跳转快捷键

;;历史文件访问
(global-set-key (kbd "C-c f") 'recentf-open-files-in-simply-buffer)

;;emacs中管理多个终端的工具
(global-set-key "\C-x." 'multi-term)
(global-set-key "\C-x," 'multi-term-dedicated-open)

;;注释工具
(global-set-key (kbd "C-c / C-c") 'comment) ;;智能加注释
(global-set-key (kbd "C-c / M-c") 'uncomment) ;;智能去注释

;;--------------------------------org mode-------------------------------------------
;常用属性格式
;#+STYLE: <link rel="stylesheet" type="text/css" href="/root/.emacs.d/style/style.css" />
;#+OPTIONS: ^:{} H:5 toc:5
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cp" 'org-capture)
(global-set-key "\C-cv" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;-------------------------(星际译王)stardict--------------------------------------
;需先安装: sudo apt-get install stardict 
;词库: http://abloz.com/huzheng/stardict-dic/zh_CN/
(require 'stardict)
(global-set-key (kbd "C-c t") 'view-stardict-in-buffer)

;;;-----------ecb-----------------------------------------
(global-set-key (kbd "C-c p") 'ecb-goto-window-edit-last)
(global-set-key (kbd "C-c s") 'ecb-goto-window-sources)
(global-set-key (kbd "C-c d") 'ecb-goto-window-directories)
(global-set-key (kbd "C-c m") 'ecb-goto-window-methods)
(global-set-key (kbd "C-c h") 'ecb-goto-window-history)
(global-set-key (kbd "C-c r") 'ecb-redraw-layout)

;;;emacs evil (vim-mode)
;这个是打开文件后默认进入emacs模式 
;(setq evil-default-state 'emacs) ;; emacs-mode 
(setq evil-default-state 'normal) ;; vim-normal-mode 
; C-u按键调用vim功能（就是临时进入normal模式，然后自动回来）
(define-key evil-emacs-state-map (kbd "C-u") 'evil-execute-in-normal-state) 
; 下面4行是设置使用C-d作为ESC按键，这个自己看吧 
(define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state) 
(define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state) 
(define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state) 
(define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state) 
;以下设置时使用t作为多剪贴板的起始按键，比如 tay(不是 "ay哦) tap(就是"ap啦)~ 
(define-key evil-normal-state-map "t" 'evil-use-register) 

;;org-remember启动的快捷键, 新版org 8.x 以后已使用org-capture代替
(global-set-key (kbd "C-c C-r") 'org-remember)
(global-set-key (kbd "C-c C-,") 'org-priority)

;;org-capture启动的快捷键
(define-key global-map "\C-cm" 'org-capture)

;; -------------emacs w3m--------------------
(global-set-key "\C-xm" 'browse-url-at-point)  
(global-set-key "\C-xn" 'browse-url)  

;;---------evernote-mode-----------------------
(define-prefix-command 'my-evernote-map)
(global-set-key (kbd "\C-ce") 'my-evernote-map)
(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)
(global-set-key "\C-cep" 'evernote-post-region)
(global-set-key "\C-ceb" 'evernote-browser)

;;code fold/unfold
;; 函数折叠
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C-c 0") 'semantic-tag-folding-fold-all)
(define-key semantic-tag-folding-mode-map (kbd "C-c 1") 'semantic-tag-folding-show-all)
(define-key semantic-tag-folding-mode-map (kbd "C-c 2") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c 3") 'semantic-tag-folding-show-block)
(define-key c-mode-map (kbd "C-c 4") 'hs-hide-block)
(define-key c-mode-map (kbd "C-c 5") 'hs-show-block)
(define-key c-mode-map (kbd "C-c 6") 'hide-ifdef-block)
(define-key c-mode-map (kbd "C-c 7") 'show-ifdef-block)

;;;---------------go-mode-------------------------------
(add-hook 'before-save-hook 'gofmt-before-save)
;; define my own go mode key binds ::super
(setq go-mode-map
      (let ((m (make-sparse-keymap)))
        (define-key m "}" #'go-mode-insert-and-indent)
        (define-key m ")" #'go-mode-insert-and-indent)
        (define-key m "," #'go-mode-insert-and-indent)
        (define-key m ":" #'go-mode-insert-and-indent)
        (define-key m "=" #'go-mode-insert-and-indent)
        (define-key m (kbd "C-c C-a") #'go-import-add)
        (define-key m (kbd "C-c C-j") #'godef-jump)
        ;; go back to point after called godef-jump.  ::super
        (define-key m (kbd "C-c C-b") #'pop-tag-mark)
        (define-key m (kbd "C-x 4 C-c C-j") #'godef-jump-other-window)
        (define-key m (kbd "C-c C-d") #'godef-describe)
        m))
;; use goimports instead of gofmt ::super
(setq gofmt-command "goimports")
;;按键绑定
(defun go-compile-debug ()
  "compile project"
  (interactive)
  (compile "go build"))

(defun go-compile-release ()
  "clean project"
  (interactive)
  (compile (concat "go build -ldflags -s" ))
  )

(defun go-clean-project ()
  "clean project"
  (interactive)
  (compile "go clean -i"))

(defun go-key-bindings ()
  (setq default-tab-width 4)
  (define-key go-mode-map [f6] 'go-compile-debug)     ;;F6 编译工程-debug
  (define-key go-mode-map [C-f6] 'go-compile-debug)   ;;Ctrl+f6 编译工程-release
  (define-key go-mode-map [S-f6] 'go-clean-project)   ;;Shift+f6 清理工程
  )

(add-hook 'go-mode-hook 'go-key-bindings )
; snake-case lower-camel-case upper-camel-case original
(custom-set-variables
 '(go-add-tags-style 'snake-case))
; '(go-add-tags-style 'lower-camel-case))

;(with-eval-after-load 'go-mode
;  (define-key go-mode-map (kbd "C-c t") #'go-add-tags))

;--------------阅读代码快捷键-------------------------------------
;;cscope python-mode
(define-key global-map [(C-f6)]  'pycscope-find-functions-calling-this-function)
(define-key global-map [(f7)]  'pycscope-pop-mark)
(define-key global-map [(f8)]  'pycscope-find-global-definition-no-prompting)
;cscope c/c++-mode
(define-key c-mode-base-map [(C-f6)] 'cscope-find-functions-calling-this-function)
(define-key c-mode-base-map [(f7)] 'cscope-pop-mark)
(define-key c-mode-base-map [(f8)] 'cscope-find-global-definition-no-prompting)
;;cscope go-mode
(define-key go-mode-map [(C-f7)] 'cscope-pop-mark)
(define-key go-mode-map [(C-f8)] 'cscope-find-global-definition-no-prompting)
(define-key go-mode-map [(f7)] 'gocscope-pop-mark)
(define-key go-mode-map [(f8)] 'godef-jump)
;java-mode
(define-key java-mode-map [(f7)] 'meghanada-back-jump)
(define-key java-mode-map [(f8)] 'meghanada-jump-declaration)

;;swith-window
(global-set-key (kbd "C-x o") 'switch-window)

;; smex -> A smart M-x enhancement for Emacs.
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; to used it 使用像其他编辑器的tab键 add by mosp, 2015/08/22 18:48:13
;tab绑定键名称为: <tab>, shift+tab键绑定名称为: <backtab>
;emacs的tab键为语法补全， 为了能使用tab的语法补全，先
;把下面的注释掉，使用tab键对齐时直接输入命令即可。
;(global-set-key (kbd "<tab>")    'abs-indent)
;(global-set-key (kbd "<backtab>")  'abs-unindent)

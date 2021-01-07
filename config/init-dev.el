(add-to-list 'load-path "~/.emacs.d/lib/site-lisps/")
(add-to-list 'load-path "~/.emacs.d/lib/yasnippet/")
(add-to-list 'load-path "~/.emacs.d/lib/parentheses/")
(add-to-list 'load-path "~/.emacs.d/lib/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/lib/pylookup/")
(add-to-list 'load-path "~/.emacs.d/lib/pyflakes/")
(add-to-list 'load-path "~/.emacs.d/lib/flymake-easy/")
(add-to-list 'load-path "~/.emacs.d/lib/flymake-cursor/")
(add-to-list 'load-path "~/.emacs.d/lib/ace-jump-buffer/")
(add-to-list 'load-path "~/.emacs.d/lib/ace-jump-mode/")
(add-to-list 'load-path "~/.emacs.d/lib/multiple-cursors/")
(add-to-list 'load-path "~/.emacs.d/lib/popwin/")
(add-to-list 'load-path "~/.emacs.d/lib/expand-region/")
(add-to-list 'load-path "~/.emacs.d/lib/python-mode/")
(add-to-list 'load-path "~/.emacs.d/lib/cc-mode-5.32.2/")
(add-to-list 'load-path "~/.emacs.d/lib/go-mode/")
(add-to-list 'load-path "~/.emacs.d/lib/Fill-Column-Indicator/")
(add-to-list 'load-path "~/.emacs.d/lib/evil/")
(add-to-list 'load-path "~/.emacs.d/lib/evil-surround/")
(add-to-list 'load-path "~/.emacs.d/lib/evil-mark-replace")
(add-to-list 'load-path "~/.emacs.d/lib/evil-leader")
(add-to-list 'load-path "~/.emacs.d/lib/evil-matchit")
(add-to-list 'load-path "~/.emacs.d/lib/evil-nerd-commenter")
(add-to-list 'load-path "~/.emacs.d/lib/evil-escape")
(add-to-list 'load-path "~/.emacs.d/lib/evil-matchit")
(add-to-list 'load-path "~/.emacs.d/lib/window-numbering")
(add-to-list 'load-path "~/.emacs.d/lib/sdcv")
(add-to-list 'load-path "~/.emacs.d/lib/simpleclip")
(add-to-list 'load-path "~/.emacs.d/lib/find-file-in-project")
(add-to-list 'load-path "~/.emacs.d/lib/chinese-fonts-setup")

(setq exec-path (cons "/usr/local/bin" exec-path))  

(require 'eval-after-load)
(require 'ahei-misc)
;conf-font存在放大字体时中文不变的问题 alter by mosp,2015/08/23 11:26:33
;(require 'conf-font)  
;bhj-fonts存在org-mode下中英文不等宽问题，alter by mosp, 2016/02/19 23:43:06 
;(require 'bhj-fonts) 
(require 'chinese-fonts-setup) 

;;设置redo
(require 'redo+)

;; 所有关于括号的配置
(require 'all-paren-settings)

;; 自动给你加上括号
(require 'autopair-settings)



;; 所有的自动补全的配置
;(require 'all-auto-complete-settings)     ;; 这两行影响到java-meg-mode暂屏蔽，by mosp, 2019-12-22
;(setq-default global-auto-complete-mode t)
;使用commany-mode
(add-hook 'after-init-hook 'global-company-mode)

;;先设置缩进
;;设置TAB宽度为4
(setq default-tab-width 4) 
;;以下设置缩进
;;用tab缩进
;; (setq c-indent-level 4)
;; (setq c-continued-statement-offset 4)
;; (setq c-brace-offset -4)
;; (setq c-argdecl-indent 4)
;; (setq c-label-offset -4)
;; (setq c-basic-offset 4)
(setq c-default-style "linux"
	  c-basic-offset 4)

;; 回车后indent
(eal-define-keys
 `(lisp-mode-map emacs-lisp-mode-map lisp-interaction-mode-map sh-mode-map
                 java-mode-map
                 ruby-mode-map c-mode-base-map tcl-mode-map org-mode-map
                 python-mode-map perl-mode-map)
 `(("RET" newline-and-indent)))

;; 语法高亮
(global-font-lock-mode t)

;;代码折叠
(require 'hs-minor-mode-settings)

;; doxygen
(require 'doxymacs-settings)

;; 动态检查语法错误
;;(require 'flymake-settings)

;;配置shell-pop
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/usr/bin/ipython")
(shell-pop-set-window-height 60) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
(shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom". 

;;配置markdown-mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;;配置shell脚本的开发环境
(require 'sh-mode-settings)

;;对org模式的配置
(require 'org-settings)

;;配置python开发环境

;;安装pylook
;; add pylookup to your loadpath, ex) ~/.emacs.d/pylookup
(setq pylookup-dir "~/.emacs.d/lib/pylookup")
(add-to-list 'load-path pylookup-dir)

;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; set search option if you want
(setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

;;开启python的flymake，检查错误
;;需先安装pyflakes: sudo apt-get install pyflakes
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;;在minibuffer显示错误
(require 'flymake-cursor-autoloads)

;; `gdb'
(require 'gud-settings)

;;鼠标指针快速移动
;;安装ace-jump
(require 'ace-jump-mode-autoloads)

;;快速跳转到某一buffer
(require 'ace-jump-buffer-autoloads)

;;添加多指针的功能
;;(require 'multiple-cursors)

;;添加popwin,按C-g能让消息窗口消失
(require 'popwin)
(popwin-mode 1)

;;smart-operator
;; (require 'smart-operator)
;; (defun my-c-mode-common-hook()
;;   (smart-insert-operator-hook)

;;   (local-unset-key (kbd "."))
;;   (local-unset-key (kbd ":"))
;;   (local-set-key (kbd "*") 'c-electric-star))
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; 安装php+-mode
;; (require 'php+-mode)
;; (php+-mode-setup)

;; 安装expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; 安装python-mode
;; (setq py-install-directory "~/.emacs.d/lib/python-mode/")
;; (require 'python-mode)

;; 语法高亮
(require 'highlight-symbol)

;; psvn
(require 'psvn)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq session-save-file "~/.emacs.session")
(load "desktop")
(desktop-save-mode 1)
(setq desktop-dirname "~/.emacs.desktop")

;;hide region
(require 'hide-region)
;; hide lines
(require 'hide-lines)

;;bookmark
(require 'bookmark-settings)

;--------java mode(meghanada) -----------------
(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            ;; enable telemetry
            (meghanada-telemetry-enable t)
            (flycheck-mode +1)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(cond
   ((eq system-type 'windows-nt)
    (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
    (setq meghanada-maven-path "mvn.cmd"))
   (t
    (setq meghanada-java-path "java")
    (setq meghanada-maven-path "mvn")))

;CC-MODE c语言开发环境
; Make a non-standard key binding.  We can put this in
; c-mode-base-map because c-mode-map, c++-mode-map, and so on,
; inherit from it.
;(require 'cc-mode) 
(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)


;; offset customizations not in my-c-style
;; This will take precedence over any setting of the syntactic symbol
;; made by a style.
(setq c-offsets-alist '((member-init-intro . ++)))


;; Create my personal style.
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t))
  "My C Programming Style")
(c-add-style "PERSONAL" my-c-style)


;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; set my personal style for the current buffer
  (c-set-style "PERSONAL")
  ;; other customizations
  (setq tab-width 4
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode nil)
  ;; we like auto-newline, but not hungry-delete
  (c-toggle-auto-newline 1))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;; 加载cscope，用来阅读代码
;; 需要先安装： sudo apt-get install cscope
(setq scope-program "/usr/local/bin/cscope")
;;;http://www.emacswiki.org/emacs/CScopeAndEmacs
(require 'xcscope)
(require 'xcscope+);;;;;;cscope的插件扩展  http://www.emacswiki.org/emacs/xcscope+.el
(setq cscope-do-not-update-database t)

;;;pycscope for python
(require 'xpycscope)

;;intel Hex 读取模式 http://www.emacswiki.org/emacs/IntelHexMode
(require 'intel-hex-mode)

;;typedef
(require 'ctypes)
(ctypes-auto-parse-mode 1)

;; 高亮指定关键字
(require 'highlight-symbol)

;;高亮显示设置
(require 'generic-x);;更加丰富的高亮
;;(require 'crosshairs) ;;高亮显示光标所在行和列 没啥好用的http://www.emacswiki.org/emacs/CrosshairHighlighting
(require 'hl-line+) ;;http://www.emacswiki.org/emacs/HighlightCurrentLine
(toggle-hl-line-when-idle 1) ;;仅在emacs空闲时高亮本行
;(hl-line-when-idle-interval 1) ;;在n秒后高亮当前行
;;高亮显示关键字
(require 'highlight-fixmes-mode)
(highlight-fixmes-mode);;启用关键字高亮功能

;;---------go-mode------------------------------------
(require 'go-mode)
(require 'go-mode-load)
(require 'go-mode-setting)
(require 'go-autocomplete)
(require 'auto-complete-config)
(require 'go-guru)
(require 'go-add-tags)
(require 'gotests)
(add-to-list 'ac-dictionary-directories (concat  "~/.emacs.d/lib/auto-complete/dict"))
(ac-config-default)

;; 高亮局部变量，和sourceinsight类似(感觉颜色有点别扭，先用试用一下再说 2011-11-24)
(require 'zjl-hl)
(zjl-hl-enable-global-all-modes)

;;自动编码识别
(require 'unicad)

;;以下两个配置可使emacs能同时识别两种编码的文件。
;;查看emacs支持的编码M-x list-coding-systems
;;查看当前编码C-h v current-language-environment 或 M-x decribe-coding-system
;;emacs如果没能自动识别编码可手工更改:M-x revert-buffer-with-coding-system
;; UTF-8 settings
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
;;; ### Coding ###
;;; --- 编码设置
(setq default-buffer-file-coding-system 'utf-8-unix)            ;缓存文件编码
(setq default-file-name-coding-system 'utf-8-unix)              ;文件名编码
(setq default-keyboard-coding-system 'utf-8-unix)               ;键盘输入编码
(setq default-process-coding-system '(utf-8-unix . utf-8-unix)) ;进程输出输入编码
(setq default-sendmail-coding-system 'utf-8-unix)               ;发送邮件编码
(setq default-terminal-coding-system 'utf-8-unix)               ;终端编码

;;tramp
;;由于emacs22以上已经集成tramp，所以如下两行配置注掉
;;(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/")
;; for Emacs
;;(add-to-list 'Info-default-directory-list "/usr/local/share/info/tramp/")
;(setq tramp-syntax 'url)
(setq tramp-chunksize 328)
(require 'ange-ftp)
(require 'tramp)
;记住密码
(setq password-cache-expiry nil)
;用 M-x tramp-compile 和 M-x tramp-recompile编译远程程序
(defun wcy-tramp-compile (arg-cmd)
  "reimplement the remote compile."
  (interactive "scompile:")
  (with-parsed-tramp-file-name default-directory foo
        (let* ((key (format "/plink:%s@%s:" foo-user foo-host))
                  (passwd (password-read "PASS:" key))
                  (cmd (format "plink %s -l %s -pw %s \"(cd %s ; %s)\""
                                           foo-host foo-user
                                           passwd
                                           (file-name-directory foo-localname)
                                           arg-cmd)))
 (password-cache-add key passwd)
 (save-some-buffers nil nil)
 (compile-internal cmd "No more errors")
 ;Set comint-file-name-prefix in the compilation buffer so
 ;compilation-parse-errors will find referenced files by ange-ftp.
 (with-current-buffer compilation-last-buffer
 (set (make-local-variable 'comint-file-name-prefix)
 (format "/plink:%s@%s:" foo-user foo-host))))))
;tramp配置
(setq password-cache-expiry nil)
(setq tramp-auto-save-directory "~/trampbuf")
(setq tramp-default-method "ssh")
(setq tramp-default-user "root")
(setq tramp-default-host "10.1.5.254")

;;======================                        拷贝代码自动格式化                =====================
;;Emacs 里对代码的格式化支持的非常好，不但可以在编辑的时候自动帮你格式化，还可以选中一块代码，
;;按 Ctrl-Alt-\ 对这块代码重新进行格式化.如果要粘贴一块代码的话，粘贴完了紧接着按 Ctrl-Alt-\,
;;就可以把新加入的代码格式化好。可是，对于这种粘贴加上重新格式化的机械操作，Emacs 应该可以将
;;它自动化才能配得上它的名气，把下面的代码加到配置文件里，你的 Emacs 就会拥有这种能力了
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
          (and (not current-prefix-arg)
                   (member major-mode
                                   '(
                                         c-mode
                                         c++-mode
                                         go-mode
                                         clojure-mode
                                         emacs-lisp-mode
                                         haskell-mode
                                         js-mode
                                         latex-mode
                                                lisp-mode
                                         objc-mode
                                         perl-mode
                                         cperl-mode
                                         plain-tex-mode
                                         python-mode
                                         rspec-mode
                                                ruby-mode
                                         scheme-mode))
                   (let ((mark-even-if-inactive transient-mark-mode))
                         (indent-region (region-beginning) (region-end) nil))))))
;;----------------------                        End 拷贝代码自动格式化          ---------------------


;;; ### Indent ###
;;; --- 缩进设置
(setq-default indent-tabs-mode t)       ;默认不用空格替代TAB
(setq default-tab-width 4)              ;设置TAB默认的宽度
(dolist (hook (list                     ;设置用空格替代TAB的模式
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-hook
               'c++-mode-hook
               'go-mode-hook               
               'java-mode-hook
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook
               ))
  (add-hook hook '(lambda () (setq indent-tabs-mode nil))))

;; 用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 1024)
(setq max-lisp-eval-depth 40000)        ;lisp最大执行深度
(setq max-specpdl-size 10000)           ;最大容量
(setq undo-outer-limit 5000000)         ;撤销限制
(setq message-log-max t)                ;设置message记录全部消息, 而不用截去
(setq eval-expression-print-length nil) ;设置执行表达式的长度没有限制
(setq eval-expression-print-level nil)  ;设置执行表达式的深度没有限制
(setq global-mark-ring-max 1024)        ;设置最大的全局标记容量
(setq history-delete-duplicates t)      ;删除minibuffer的重复历史

;;让 Emacs 可以直接打开和显示图片。
(setq auto-image-file-mode t)

;; 可以保存你上次光标所在的位置
(require 'saveplace)
(setq-default save-place t)

;语法高亮
(global-font-lock-mode t)
(which-function-mode t)   ;在状态条上显示当前光标在哪个函数体内部
(auto-compression-mode 1) ;打开压缩文件时自动解压缩

;;显示空格
(require 'show-wspace)   ;空格提示 http://www.emacswiki.org/emacs/ShowWhiteSpace

;;菜单增强
(require 'menu-bar+)

;;在历史编辑中跳转 http://www.emacswiki.org/emacs/GotoChg
;(require 'goto-last-change)

;;历史文件访问
;(require 'recentf)
;(require 'recentf-ext)
;(setq recentf-max-saved-items 100)      ;最近打开文件的最大数量
;(setq recentf-auto-cleanup 300)         ;自动清理最近打开文件列表中重复或其他文件的时间间隔 (秒)
;;;(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
;(recentf-mode 1) ;;启用历史文件模式
;(load "recentf-buffer")

(require 'color-moccur)                 ;人性化的搜索功能 http://www.emacswiki.org/emacs/color-moccur.el
(require 'moccur-edit)                  ;搜索编辑 依赖于color-moccur http://www.emacswiki.org/emacs/moccur-edit.el
;;; ### Color moccur ###
;;; --- 增强的Buffer搜索
(setq moccur-kill-moccur-buffer t)         ;退出buffer时自动关闭其buffer
(setq moccur-edit-highlight-edited-text t) ;高亮编辑过的内容
(defadvice moccur-edit-change-file         ;编辑过后自动保存buffer
  (after save-after-moccur-edit-buffer activate)
  "Automatically save buffer when edit in moccur."
  (save-buffer))
;;使用M-sr和M-sl 代替 rgrep(当前目录递归搜索)/lgrep(当前目录本层搜索非递归)
(define-key search-map "r" 'rgrep)
(define-key search-map "l" 'lgrep)

(require 'ediff)                        ;文件比较功能 emacs库 http://www.emacswiki.org/emacs/EdiffMode
(require 'ediff+)                       ;ediff增强 http://www.emacswiki.org/emacs/ediff+.el

(require 'browse-kill-ring)             ;超强恢复 http://www.emacswiki.org/emacs/BrowseKillRing


(require 'org-extension) ;;org模式增强
(require 'buffer-extension) ;;buffer操作增强

;; 用ibuffer代替默认的buffer switch
;; 参考 http://www.emacswiki.org/emacs/IbufferMode
;; http://www.emacswiki.org/emacs/ibuffer%E6%A8%A1%E5%BC%8F
;; ibuffer是emacs自带的，可用 M-x ibuffer 调出来
;; 下面只是将快捷键 C-x C-b 映射为调出ibuffer的命令
;; 在ibuffer中的操作方式和dired mode一样
;; n和p是上下，m是选中该文件，可选多个，D是kill buffer
;; 回车或者按e(就是edit)来编辑文件
;; 在ibuffer页面，用英文斜线来通过关键字过滤缩小显示文件范围
;; 比如 “ /日记 ” ，就会只显示buffer名称中有日记这两个字的
;; / 后面支持正则表达式 如 /200?
;; 撤销过滤按两下/，就是按 “ // ”
;; 在ibuffer中，按英文等号 “ = ” 对为保存文件和它上一个保存版本做diff
;; 按 g 刷新文件目录
(require 'ibuffer)
;(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;;显示时默认隐藏所有以*开头的的文件
(require 'ibuf-ext)
;;(add-to-list 'ibuffer-never-show-predicates "^\\*") ;;启用这句话时就忽略所有以*开头的文件
;;http://www.emacswiki.org/emacs/BufferMenuPlus
(require 'buff-menu+)

;;; --- 交互式Buffer
(setq ibuffer-sorting-mode 'recency)    ;用最近打开模式显示

;;emacs中管理多个终端的工具
;;http://www.emacswiki.org/emacs/MultiTerm
;; --------shade by mosp for debug emacs24.5, 2016-05-20-----------------
;(require 'multi-term)
;(setq multi-term-program "/bin/zsh")
;(setq multi-term-buffer-name "term")
;(setq multi-term-dedicated-select-after-open-p t)

;;注释工具
;;;代码加框注释
;;;还未添加其快捷键
(require 'rebox2)
(require 'edit-misc) ;;ahei写的一些快捷编辑的插件

;;doxymacs注释工具
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode);;访问C/C++文件时启用doxymacs模式
(add-hook 'go-mode-hook 'doxymacs-mode);;访问go文件时启用doxymacs模式
;;If you want Doxygen keywords fontified use M-x doxymacs-font-lock
;;doxymacs 快捷键
;; 命令 英文解释 中文解释
;; C-c d ? will look up documentation for the symbol under the point.查找当前鼠标点下的符号的文档
;; C-c d r will rescan your Doxygen tags file.重新扫描tags文件
;; C-c d f will insert a Doxygen comment for the next function.为函数插入Doxygen注释
;; C-c d i will insert a Doxygen comment for the current file.为文件插入Doxygen注释
;; C-c d ; will insert a Doxygen comment for the current member.为当前成员插入Doxygen注释
;; C-c d m will insert a blank multiline Doxygen comment.插入多行注释
;; C-c d s will insert a blank singleline Doxygen comment.插入单行注释
;; C-c d @ will insert grouping comments around the current region.插入环绕当前区域的注释
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(setq doxymacs-doxygen-style "C++") ;;设置默认模板为C++
;;Doxymacs C/C++注释模板
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c/c++ header include guard
(defun insert-include-guard ()
  "insert include guard for c and c++ header file.
for file filename.ext will generate:
#ifndef __FILENAME_EXT__
#define __FILENAME_EXT__

original buffer content

#endif /*__FILENAME_EXT__*/
"
  (interactive)
  (setq file-macro
        (concat "__" (replace-regexp-in-string "\\." "_" (upcase (file-name-nondirectory buffer-file-name))) "__"))
  (setq guard-begin (concat "#ifndef " file-macro "\n"
                            "#define " file-macro "\n\n"))
  (setq guard-end
        (concat "\n\n#endif /*" file-macro "*/\n"))
  (setq position (point))
;  (goto-char (point-min))
  (insert guard-begin)
  (goto-char (point-max))
  (insert guard-end)
  (goto-char (+ position (length guard-begin))))

;;;doxymacs C/C++文件头注释模板
(defconst doxymacs-C++-file-comment-template
  '(
    "/" "*!*****************************************************************************" > n
    "*" "    Copyright (C) 2010-2020  " my-company  > n
    "*" "******************************************************************************" > n
    "*" " @file    "
    (if (buffer-file-name)
        (file-name-nondirectory (buffer-file-name))
    "") > n
    "*" " @brief   " (p "Brief description of this file: ") > n
    "*" " @version " "1.0"> n
    "*" " @date    " (concat (format-time-string "%Y/%m/%d %H:%M:%S") ) > n
    "*" " @author  " (user-full-name) (concat " , " user-mail-address) > n
    "*" " @remarks " > n
    "*" "******************************************************************************" > n
    "*" " @1.0   " (concat (user-full-name) "  ")  (concat (format-time-string "%Y/%m/%d %H:%M:%S") " , create orignal file")  > n
    "*" "*****************************************************************************/" > n
      (if (string-equal (file-name-extension (buffer-file-name)) "h")
            ;如果后缀为.h，要添加头文件保护
            (insert-include-guard)
      )
      )
  "Default C++-style template for file documentation.")

;;;Doxymacs C/C++函数注释模板
(defconst doxymacs-C++-function-comment-template
  '((let ((next-func (doxymacs-find-next-func)))
      (if next-func
          (list
           'l
           "/** " '> 'n
           " * " 'p '> 'n
           " * " '> 'n
           (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
           (unless (string-match
                    (regexp-quote (cdr (assoc 'return next-func)))
                    doxymacs-void-types)
             '(l " * " > n " * " (doxymacs-doxygen-command-char)
                 "return " (p "Returns: ") > n))
           " */" '>)
        (progn
          (error "Can't find next function declaration.")
          nil))))
  "Default C++-style template for function documentation.")
(defconst doxymacs-C++-function-comment-template
  '((let ((next-func (doxymacs-find-next-func)))
      (if next-func
          (list
           'l
           " " '> 'n
;           "/" "*!******************************************************************************" '> 'n
           "/" "*!" '> 'n           
               "*" " " (cdr (assoc 'func (doxymacs-find-next-func))) "(): "
           (if (string-match (regexp-quote "static") (cdr (assoc 'return next-func)))
               "<private>") '> 'n
               (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
               (unless (string-match
                        (regexp-quote (cdr (assoc 'return next-func)))
                        doxymacs-void-types)
                 '(l                  
                     "* @return  " (p  "Returns: ") > n))
                "*" " @remarks " '> 'n
               "*/" '> 'n)
        (progn
          (error "Can't find next function declaraton.")
          nil))))
  "Default C++-style template for function documentation.")

;;;Doxymacs 单行C/C++注释模板
(defconst doxymacs-C++-blank-singleline-comment-template
  '("/*!< " p "  */")
  "Default C++-style template for a blank single line doxygen comment.")


;;;Doxymacs 多行C/C++注释模板
(defconst doxymacs-C++-blank-multiline-comment-template
  '(
    > n
      "/*! " > n
      "* " p > n
;      "* " > n
;      "* " "Add by " (user-full-name) (concat " , " (current-time-string)) > n
      "*/" > n)
  "Default C++-style template for a blank multiline doxygen comment.")

;;IDO模式
;;lets you interactively do things with buffers and files.
;;http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
;;http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(require 'idomenu)
(autoload 'idomenu "idomenu" nil t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t);;启用ido模式 有一段时间无法启用ido的原因 是由于ido.el是emacs23自带的 而我在我的插件目录下有ido.el有冲突，所以去掉就可以初始化了
;;(setq ido-enable-flex-matching t)                   ;模糊匹配



;;智能拷贝 使用alt-w在没有选择区域时拷贝当前行，否则拷贝区域
;        使用alt-k从光标处拷贝到行尾
;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;;--------------------------w3m----------------------------------------------
;需先安装: sudo apt-get install w3m
;(add-to-list 'load-path "~/.emacs.d/lib/emacs-w3m/share/emacs/site-lisp/w3m")
;(require 'w3m-load)
;(require 'mime-w3m)
;;(require 'w3m-settings)
;;; w3m
;;load & init 
;(autoload 'w3m "w3m" "interface for w3m on emacs" t)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
;;settings
;;; 设置w3m主页
;(setq w3m-home-page "https://www.google.com.hk")
;;; 默认显示图片
;(setq w3m-default-display-inline-images t)
;(setq w3m-default-toggle-inline-images t)
;;; 使用cookies
;(setq w3m-use-cookies t)
;;;设定w3m运行的参数，分别为使用cookie和使用框架  
;(setq w3m-command-arguments '("-cookie" "-F"))               
;;; 使用w3m作为默认浏览器
;(setq browse-url-browser-function 'w3m-browse-url)                
;(setq w3m-view-this-url-new-session-in-background t)
;;;显示图标                                                      
;(setq w3m-show-graphic-icons-in-header-line t)                  
;(setq w3m-show-graphic-icons-in-mode-line t) 
;;;C-c C-p 打开，这个好用                                        
;(setq w3m-view-this-url-new-session-in-background t)  
;
;(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)                                    
;(defun remove-w3m-output-garbages ()                            
;  "去掉w3m输出的垃圾."                                            
;  (interactive)                                                   
;  (let ((buffer-read-only))                                       
;    (setf (point) (point-min))                                      
;    (while (re-search-forward "[\200-\240]" nil t)                  
;      (replace-match " "))                                            
;    (set-buffer-multibyte t))                                       
;  (set-buffer-modified-p nil))

;;--------------------------------graphviz dot mode-------------------------------------------
;; Graphviz dot mode
;; 要使用graphviz画图功能需先安装： sudo apt-get install "graphviz*" 
; 如下这两句是为了解决auto-pair-mode与graphviz-mode之间的冲突，只能放在此位置
(setq graphviz-dot-mode-syntax-table (syntax-table))
(set-default 'autopair-dont-activate #'(lambda () (eq major-mode 'graphviz-dot-mode)))
(load-file "~/.emacs.d/lib/site-lisps/graphviz-dot-mode.el")
;;使用graphviz画数据结构流程图
;# 1: 打开一个 C 文件
;如内核代码中的 drivers/usb/storage/usb.h
;# 2: 打开一个 dot 文件(/tmp/usb.dot)
;auto-insert 会自动插入一些文件内容.
;# 3: 选中 struct us_data 的定义，并执行 yyc/datastruct-to-dot。(注：只能用M+x,不能用C-x C-m)
;执行完成后， us_data 的数据填写到了 tmp.dot 中，将该 buffer 中的所有内容 kill 掉，
;并 yank 到 usb.dot 中 XXX 这一行的下面。此时，保存 sub.dot ， 并按下快捷键 : C-cc ， 然后按下 Enter ，
;就会自动编译。然后再按下 C-cp 就可以在另外一个 buffer 中预览它了。
;其实到这里，一个 C 语言的 struct 数据结构就已经被画出来了，后面的两个步骤，
;是为了介绍怎样将多个数据结构联系起来。
;# 4: 添加其他的 subgraph
;我们可以继续添加其他的 subgraph ， 例如 struct usb_ctrlrequest *cr ，以及 struct usb_sg_request，
;并全部做为 subgraph 添加到 usb.dot 中。
;# 5: 为 subgraph 建立关联
;很简单，通过 “->” 画两条线就可以了。
(load-file "~/.emacs.d/lib/graphviz_ds/draw_ds.el")


;;--------------------------------org mode-------------------------------------------
;常用属性格式
;#+STYLE: <link rel="stylesheet" type="text/css" href="/root/.emacs.d/style/style.css" />
;#+OPTIONS: ^:{} H:5 toc:5
(require 'ox-md nil t)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.orgx\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
;让不同级别的标题采用不同大小的字体 add by mosp, 2015/08/22 18:02:11 
(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)
            (set-face-attribute 'org-level-1 nil :height 1.5 :bold t)
            (set-face-attribute 'org-level-2 nil :height 1.4 :bold t)
            (set-face-attribute 'org-level-3 nil :height 1.3 :bold t)
            (set-face-attribute 'org-level-4 nil :height 1.2 :bold t)            
            (set-face-attribute 'org-level-5 nil :height 1.1 :bold t)))
(add-hook 'org-mode-hook 
(lambda () (setq truncate-lines nil)))
(setq org-log-done t)
(setq org-src-fontify-natively t)
;(setq org-startup-indented t) /*自动格式化，但目前有点问题是标题行都是奇数*/
;;;【htmlize.el】把 buffer 中的内容连同颜色转为 html 格式。
(autoload 'htmlize-buffer "htmlize" "HTMLize mode" t)
;;当输入普通到a_b不会转义为下标，如果需要转义需写成a_{b}
(setq org-export-with-sub-superscripts '{})
;;为每个分节的标题添加标号 add by mosp, 2015/08/22 17:31:52 
(setq org-export-with-section-numbers 5)
;;不关闭中文输入法，输入章节标题里面的星号
(defun org-mode-my-init ()
  (define-key org-mode-map (kbd "×") (kbd "*"))
  (define-key org-mode-map (kbd "－") (kbd "-")))
(add-hook 'org-mode-hook 'org-mode-my-init)
;; org-mode < 8.0
(setq org-latex-to-pdf-process '("xelatex -interaction nonstopmode %f"
                                 "xelatex -interaction nonstopmode %f"))
;;  org-mode 8.0
;;(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
;;                              "xelatex -interaction nonstopmode %f"))
;;当出现"cannot open load file:org-nil"时，是由于没有require相关文件
(require 'org)
(require 'org-install)
;(require 'org-latex) ;-----shade by mosp for debug emacs24.5 in 2016-05-20--------------
;(require 'org-publish)
;(require 'org-latex)
;(require 'org-beamer)
;(require 'org-odt)
(require 'org-src)
;(require 'org-html)
;(require 'org-ascii)
;(require 'org-docbook)
(require 'org-table)
;(require 'org-remember)
;(require 'htmlize)
;(require 'org-export-pdf)
;;+evernote-mode+org-mode
;;基本想法是：在org-remember完成时,调用一函数来处理此remember的内容,将此内容转化为一个evernote的笔记.

;;添加处理函数到rememer的hook
;(add-hook 'org-remember-before-finalize-hook 'evernote-this-org-note) ;; 关闭传入evernote 2014/05/13 17:23:48 

;;当调用到hook时,调用此函数,处理remember的内容,
(defun evernote-this-org-note(&optional arg)
  "select note"
  (interactive "P")
  (beginning-of-buffer)
  (re-search-forward "^\*.*")
  (backward-word 1)
  (beginning-of-line )
  (copy-line)
  (forward-line)
  (evernote-post-region-4-org-mode (point) (point-max) "test")
  )

;;此函数将remember的内容做为evernote笔记内容,标题的remember是标题,同时,会在minibuffer中询问tag,tag以“,”间隔
(defun evernote-post-region-4-org-mode (begin end arg)
  "Post the region as a note"
  (interactive "r\np")
  (enh-command-with-auth
   (save-excursion
     (save-restriction
       (narrow-to-region begin end)
       (if (and (enutil-neq arg nil) (enutil-neq arg 1))

                                        ;           (pop-to-buffer (enh-base-create-note-common (buffer-name) t t t))
           (enh-base-create-note-common (current-kill 0) nil nil
                                        nil t))))))


;-----------org-gdt--------------------
(setq org-todo-keywords
        '((sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
;        (sequence "TODO(t!)" "|" "DONE(d@)3" "CANCELED(c@/!)")
        (sequence "TODO(t!)" "START(s!)" "CONTINUE(c@/!)" "NEXT(n@/!)" "WAITTING(w@/!)" "SOMEDAY(o!)" "|" "DONE(d@/!)" "ABORT(a@/!)")
        ))
(setq org-todo-keyword-faces
      '(("REPORT" .      (:background "red" :foreground "white" :weight bold))
        ("BUG" .      (:background "white" :foreground "red" :weight bold))
        ("KNOWNCAUSE" .      (:foreground "MediumBlue" :weight bold))
        ("FIXED" .      (:foreground "green" :weight bold))
        ("TODO" .      (:background "DarkOrange" :foreground "black" :weight bold))
        ("START" .      (:background "yellow" :foreground "black" :weight bold))
        ("CONTINUE" .      (:background "green" :foreground "white" :weight bold))                
        ("NEXT" .      (:background "blue" :foreground "black" :weight bold))        
        ("WAITING" .   (:background "LightGreen" :foreground "gray" :weight bold))
        ("DONE" .      (:background "azure" :foreground "Darkgreen" :weight bold)) 
        ("ABORT" .     (:background "gray" :foreground "black"))
        ))
;; 优先级范围和默认任务的优先级
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?E)
(setq org-default-priority ?E)
;; 优先级醒目外观
(setq org-priority-faces
      '((?A . (:background "red" :foreground "white" :weight bold))
        (?B . (:background "DarkOrange" :foreground "white" :weight bold))
        (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
        (?D . (:background "DodgerBlue" :foreground "black" :weight bold))
        (?E . (:background "SkyBlue" :foreground "black" :weight bold))
        ))
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(setq org-log-done 'note)
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("projects" . ?p) ("study" . ?s) 
                      ("ALL" . ?a) ("莫生平" . ?m) ("魏海通" . ?c) ("李朋飞" . ?d) ("赵航" . ?e)
                      ("张玉辰" . ?f) ("张毅" . ?g) ("刘冬冬" . ?i) ("芈成洋" . ?j) ("邵永珍" . ?k)
                      ("陆军" . ?l) ("韩丽娟" . ?o)
                      ))
(setq org-agenda-files (list "~/github/mospany/private/mydoc/notes/gtd/inbox.org"
                             "~/github/mospany/private/mydoc/notes/gtd/project.org"
                             "~/github/mospany/private/mydoc/notes/gtd/task.org"
                             "~/github/mospany/private/mydoc/notes/gtd/note.org"
                             "~/github/mospany/private/mydoc/notes/gtd/study.org"
                             "~/github/mospany/private/mydoc/notes/gtd/home.org"
                             "~/github/mospany/private/mydoc/notes/gtd/life.org"                                                                                       
                             ))
;(org-remember-insinuate)  ;------------shade by mosp for debug emacs24.5 in 2016-05-20 -----------------
(setq org-directory "~/github/mospany/private/mydoc/notes/gtd/") 
;(setq org-remember-templates '(("New" ?n "* %? %t \n %i\n %a" "~/.gtd/inbox.org" ) 
;                               ("Task" ?t "** TODO %?\n %i\n %a" "~/.gtd/task.org" "Tasks") 
;                               ("Calendar" ?c "** TODO %?\n %i\n %a" "~/.gtd/task.org" "Tasks") 
;                               ("Idea" ?i "** %?\n %i\n %a" "~/.gtd/task.org" "Ideas") 
;                               ("Note" ?r "* %?\n %i\n %a" "~/.gtd/note.org" ) 
;                               ("Project" ?p "** %?\n %i\n %a" "~/.gtd/project.org" %g) ))
;;;相当于上面注释的，去掉了%a，代表写入时不自动插入当前光标所在标题的链接, 2014/06/20 15:10:30 alter by mosp
(setq org-capture-templates
      `(("x" "New" entry (file+datetree,"~/github/mospany/private/mydoc/notes/gtd/inbox.org" "New")
            "* %? %t\n  %i\n ")
        ("t" "Task" entry (file+datetree ,"~/github/mospany/private/mydoc/notes/gtd/task.org" "Task")
            "* TODO %?\n  %i\n  ")
        ("c" "Calendar" entry (file+datetree,"~/github/mospany/private/mydoc/notes/gtd/task.org" "Task")
            "* TODO %?\n  %i\n  ")
        ("i" "Idea" entry (file+datetree ,"~/github/mospany/private/mydoc/notes/gtd/task.org" "Idea")
            "* %?\n  %i\n  ")
        ("n" "Note" entry (file+datetree ,"~/github/mospany/private/mydoc/notes/gtd/note.org" "Note")
            "* %?\n  %i\n  ")
        ("s" "Study" entry (file+datetree ,"~/github/mospany/private/mydoc/notes/gtd/study.org" "Study")
            "* %?\n  %i\n  ")
        ("h" "Home" entry (file+datetree,"~/github/mospany/private/mydoc/notes/gtd/home.org" "Home")
            "* %?\n  %i\n  ")
        ("l" "Life" entry (file+datetree,"~/github/mospany/private/mydoc/notes/gtd/life.org" "Life")
            "* %?\n  %i\n  ")
        ("p" "Project" entry (file+datetree,"~/github/mospany/private/mydoc/notes/gtd/project.org" "Project")
            "* %?\n  %i\n  ")))
(setq org-remember-templates '(("New" ?n "* %? %t \n %i\n" "~/github/mospany/private/mydoc/notes/gtd/inbox.org" ) 
                               ("Task" ?t "** TODO %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/task.org" "Tasks") 
                               ("Calendar" ?c "** TODO %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/task.org" "Tasks") 
                               ("Idea" ?i "** %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/task.org" "Ideas") 
                               ("Note" ?r "* %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/note.org" )
                               ("Study" ?s "* %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/study.org" )                                
                               ("Home" ?h "* %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/home.org" )
                               ("Life" ?l "* %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/life.org" )                                                               
                               ("Project" ?p "** %?\n %i\n" "~/github/mospany/private/mydoc/notes/gtd/project.org" %g) )) 

(setq org-default-notes-file (concat org-directory "/inbox.org"))

;;org-mode里嵌入多种语言并可以执行出结果
;如果出现No org-babel-execute function for XXX. 是由于XXX语言没有加入下列激活。
;[注意]：#+BEGIN_SRC XXX ; XXX之后必须有空格，否则提示如上错误,html导不出执行结果只当成普通文本输出。
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (ditaa . t)
   (plantuml . t)
   (dot . t)
   (latex . t)
   ))

(setq org-confirm-babel-evaluate nil)
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

;此时输入 C-c C-c 生成图像, C-c C-x C-v 开关内联图像显示
(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))


;;-----------------------------evernote----------------------------------------------------
;先安装：gem install evernote_oauth
;快捷键	    命令	                        说明
;C-c e c 	evernote-create-note 	        新建笔记
;C-c e o 	evernote-open-note 	            打开笔记
;C-x C-s 	evernote-save-note 	            保存笔记
;C-c e w 	evernote-write-note 	        从当前buffer创建新笔记
;C-c e p 	evernote-post-region 	        使用当前选中的区域的内容创建笔记
;C-c e t 	evernote-edit-tags 	            修改当前笔记的标签
;C-c e e 	evernote-change-edit-mode 	    改变编辑模式 (TEXT,XHTML可选)
;C-c e r 	evernote-rename-note 	        重命名当前笔记
;C-c e d 	evernote-delete-note 	        删除当前笔记
;C-c e s 	evernote-search-notes 	        搜索
;C-c e S 	evernote-do-saved-search 	    使用已保存的搜索条件进行笔记搜索
;           evernote-create-search 	        为一个搜索分配一个名字,以备后用
;           evernote-edit-search 	        编辑已保存搜索的搜索条件
;C-x C-q 	evernote-toggle-read-only 	    设置笔记的只读属性
;           evernote-enml-formatter-command 格式化XHTML笔记
;C-c e b 	evernote-browser 	            打开evernote-browser
;b 	        移动到前一页
;f 	        移动到后一页
;t 	        创建一个标签列表页面并显示.如果已存在标签页面,直接将其打开.
;S 	        创建一个搜索列表页面并显示.如果已存在,将其打开.
;s 	        输入搜索条件,并显示符合搜索结果的笔记列表.
;N 	        创建一个笔记本列表页面.如果笔记本列表已经存在,将其打开.
;o 	        等同\C-m,但是光标并不移动到打开的笔记buffer.
;n 	        如果在笔记列表,打开当前笔记,并移动到下一行.
;p 	        如果在笔记列表,打开当前笔记,并移动到前一行
;d 	        从Evernote Browser删除当前页面.
(add-to-list 'load-path "~/.emacs.d/lib/evernote-mode")
(setq evernote-ruby-command "/usr/bin/ruby")
(setq evernote-username "moshengping")
;登陆https://www.evernote.com/api/DeveloperToken.action生成token
(setq evernote-developer-token "S=s272:U=224c205:E=14b9008abf2:C=14438577ff4:P=1cd:A=en-devtoken:V=2:H=727256d10ec5221a3007fda0bf572af7")
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))
;(require 'evernote-mode) ;; shade by mosp for emacs26

;;emacs24内置cedet
;(require 'cedet)
;;;; 使用官方的cedet1.1
(setq stack-trace-on-error t)
;;去掉红线
(setq semantic-show-unmatched-syntax-mode 0 )
(require 'cedet1.1-settings)
(require 'ecb-settings)

(require 'eassist)  ;;这个工具不错   ;h, cpp文件跳转函数, 支持即时按键选择 http://www.emacswiki.org/emacs/EAssist
(require 'sourcepair) ;;头文件导航
(define-key global-map "\C-xz" 'sourcepair-jump-to-headerfile) ;;跳转到头文件的设置
(setq sourcepair-source-path    '( "." "../*" "../../*" ))
(setq sourcepair-header-path    '( "." "include" "../include" "../*" "../../*"))
(setq sourcepair-recurse-ignore '( "CVS"  "Debug" "Release" ))


(defun my-c-mode-common-hook ()
  (define-key c-mode-base-map (kbd "M-o") 'eassist-switch-h-cpp)
  (define-key c-mode-base-map (kbd "M-l") 'eassist-list-methods))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-go-mode-common-hook ()
  (define-key go-mode-map (kbd "M-l") 'eassist-list-methods))
(add-hook 'go-mode-hook 'my-go-mode-common-hook)

(defun my-python-mode-hook ()
  (define-key python-mode-map (kbd "M-l") 'eassist-list-methods))
(add-hook 'python-mode-hook 'my-python-mode-hook)

(define-key lisp-mode-shared-map (kbd "M-l") 'eassist-list-methods)

;;-----------------web开发配置-----------------------------------------------------
;; zencoding for web dev
(require 'zencoding-mode)
;; Auto-start on any markup mode
(add-hook 'sgml-mode-hook 'zencoding-mode)
(require 'php-mode)
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
;;Emacs 24中自带了js-mode，可以使用js2-mode增强一些功能。
;;安装方法：M-x list-packages的包列表中，选择js2-mode，之后点击安装。
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;安装方法：M-x list-packages的包列表中，选择rainbow-mode，之后点击安装。
(require 'rainbow-mode)
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
(add-hook hook 'rainbow-turn-on))

;;;自动补全括号等
(defun my-c-mode-auto-pair ()
    (interactive)
    (make-local-variable 'skeleton-pair-alist)
    (setq skeleton-pair-alist '(
    	  (?\" _"\"")
    	  (?\( _ ")")
    	  (?\[ _ "]")
    	  (?{ \n > _ \n ?} >)))
    (setq skeleton-pair t)
    (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
    (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
	(local-set-key (kbd "\"") 'skeleton-pair-insert-maybe) ;;下面的配置已包含
    (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(defun my-web-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
                              (?\" _"\"")
                              (?\( _ ")")
                              (?\[ _ "]")
                              (?\[ _ "}")                              
                             ))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)  
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe) ;;下面的配置已包含
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)
(add-hook 'python-mode-hook 'my-c-mode-auto-pair)
(add-hook 'html-mode-hook 'my-web-mode-auto-pair)
(add-hook 'css-mode-hook 'my-web-mode-auto-pair)
(add-hook 'javascript-mode-hook 'my-c-mode-auto-pair)
(add-hook 'org-mode-hook 'my-c-mode-auto-pair)
(add-hook 'go-mode-hook 'my-c-mode-auto-pair)
(add-hook 'java-mode-hook 'my-c-mode-auto-pair)
;;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。

;;;-------------------------org2blog--------------------------------------
;(setq load-path (cons "~/.emacs.d/lib/org2blog/" load-path))
;(require 'org2blog-autoloads)
;(require 'xml-rpc)
;(require 'org2blog-autoloads)
;;(setq url-using-proxy t)
;;(setq url-proxy-services '(("http" . "our-proxy:8118")))
;;(setq url-proxy-services '(("http" . "127.0.0.1:80")))
;(setq org2blog/wp-blog-alist
;      `(("wordpress"
;         :url "http://mosp.wordpress.com.cn/xmlrpc.php"
;         :username "mosp"
;         :password "8tmdCfSmZiSJ"
;         :keep-new-lines t
;         :confirm t
;         :wp-code nil
;         :tags-as-categories nil)
;        ("cnblogs"
;         :url "http://www.cnblogs.com/mosp/services/metaWeblog.aspx"
;         :username "mosp"
;         ;:default-categories ("emacs")
;         :keep-new-lines t
;         :confirm t
;         :wp-code nil
;         :tags-as-categories nil)
;        ))
;
;(setq org2blog/wp-buffer-template
;      "#+DATE: %s
;#+STYLE: <link rel=\"stylesheet\" type=\"text/css\" href=\"~/.emacs.d/style/style.css\" />
;#+OPTIONS: ^:{} H:5
;#+CATEGORY: Heart
;#+TAGS:
;#+PERMALINK:
;#+TITLE:
;\n")
;;-------------------------cnblogs----------------------------------------------------
;由于cnblogs支持api比较少，使用org2blog会有些问题，写cnblogs时可以用cnblogs的配置
;先设置博客M-x cnblogs-setup-blog，其中blog ID就是博客地址中的那个博客名称（如我的就是 Open_Source  ）。
;之后询问是否将网上的博客同步到本地，如果博客较多，可能需要很长时间。
;然后可以M-x cnblogs-import-file或者cnblogs-import-folder将本地的博客文件（即你的org源文件或者html源文件）导入，
;导入过程中遇到同名的博客会问是否将这个源文件与网络上的博客关联起来。 
;快捷键	    命令	                   功能	            备注
;C-c c c	cnblogs-get-categories	   将分类获取到本地	目前没什么实际用处
;C-c c d	cnblogs-delete-post	       删除博文	        常用
;C-c c e	cnblogs-edit-post	       更新博文	        常用
;C-c c g	cnblogs-get-post	       获取指定ID的博文	估计用户不会用到
;C-c c p	cnblogs-new-post	       发布博文	        常用
;C-c c r	cnblogs-get-recent-posts   获取最近N篇博文	一般只在配置扩展时使用
;C-c c s	cnblogs-save-draft	       将草稿保存到服务器	不知道有什么实际用途
;C-c c u	cnblogs-get-users-blogs	   获取用户信息	    对用户没什么用处
(add-to-list 'load-path "~/.emacs.d/lib/cnblogs/")
(require 'cnblogs)
(add-hook 'org-mode-hook (lambda ()
                           (cnblogs-minor-mode)))


;--------------------------mew收发邮件-------------------------------------
;在emacs中用 mew 命令接收邮件之后，Mew进入 summary-mode ，这时候常用命令如下：
;w                     撰写新邮件
;a                     回复邮件，不带引用
;A                     回复邮件，带引用
;f                     转发邮件
;r                     重新发送邮件
;SPC                   阅读邮件
;y                     保存文件（可以保存信件全文、信件正文、附件）
;C-c C-l               转换当前邮件的编码格式
;C-c C-a               加入地址薄
;C-u C-c C-a           比 C-c C-a 多加入昵称和名字
;也可以直接使用 mew-send 命令来撰写新邮件，撰写新邮件的时候常用命令如下：
;C-c C-q              不保存退出
;C-c C-a              准备插入附件
;mew-attach-copy      用复制方式加入附件
;mew-attach-link      用链接方式加入附件
;mew-attach-delete    删除附件
;C-c C-c              发送邮件
;C-c RET              保存邮件到发送队列
;注意，对附件的操作都要在 C-c C-a 命令之后。还有两个命令很重要：
;C                    如果设置了多个邮箱，用 C 命令切换
;Q                    退出Mew
;需先安装: sudo apt-get install mew
;(autoload 'mew-send "mew" nil t)
;(if (boundp 'read-mail-command)
;    (setq read-mail-command 'mew))
;(autoload 'mew-user-agent-compose "mew" nil t)
;(if (boundp 'mail-user-agent)
;    (setq mail-user-agent 'mew-user-agent))
;(if (fboundp 'define-mail-user-agent)
;    (define-mail-user-agent
;      'mew-user-agent
;      'mew-user-agent-compose
;      'mew-draft-send-message
;      'mew-draft-kill
;      'mew-send-hook))

;(set-default 'mew-decode-quoted t)
;(when (boundp 'utf-translate-cjk)
;  (setq utf-translate-cjk t)
;  (custom-set-variables
;   '(utf-translate-cjk t)))
;(if (fboundp 'utf-translate-cjk-mode)
;    (utf-translate-cjk-mode 1))
;(require 'mew-w3m) ;需要w3m支持，看html邮件
;(setq mew-use-w3m-minor-mode t)
;(setq mew-w3m-auto-insert-image t)
;(setq mew-mime-multipart-alternative-list '("Text/Html" "Text/Plain" "*."))
;(condition-case nil
;    (require 'mew-w3m)
;  (file-error nil))
;(setq mew-use-text/html t)
;summary-mode显示控制 spam
;(setq mew-summary-form
;      '(type (5 date) " " (14 from) " " t (0 subj)))
;(setq mew-summary-form-extract-rule '(name))
;(setq mew-summary-form-mark-spam t)
;unread mark 标记未读邮件
;(setq mew-use-unread-mark t)
;(setq mew-unread-mark-list '((t t)))
;(setq mew-delete-unread-mark-by-mark nil)

;;-------git-emacs----------------------------------
(add-to-list 'load-path "~/.emacs.d/lib/git-emacs/")
;(require 'git-emacs) ;; shade by mosp for emacs26

;; Use the command j to list common directories and to jump to them.
(require 'eshell-autojump)

;;---------switch-window-------------------------------
(require 'switch-window)

;;---------fill-column-indicator-------------------------------
;(require 'fill-column-indicator)
;;所有模式都显示
;(define-globalized-minor-mode global-fci-mode fci-mode 
;    (lambda () (fci-mode 1)))
;;单个模式显示设置
;(add-hook 'c-mode-hook 'fci-mode)
;(add-hook 'c++-mode-hook 'fci-mode)
;(add-hook 'python-mode-hook 'fci-mode)
;(add-hook 'emacs-lisp-mode-hook 'fci-mode)
;(global-fci-mode t)
;(setq fci-rule-column 80)
;(setq fci-rule-color "light green")

;; {{ move focus between sub-windows
(require 'window-numbering)
(custom-set-faces '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold)))))
(window-numbering-mode 1)
;; }}

;-----------Org Mode打开Markdown文档的转换功能-----------------
(setq org-export-backends (quote (md ascii html icalendar latex)))

;;---------emacs blog form org-mode to hugo -------------------------------
(require 'org2hugo-single)
(require 'org2hugo-subtree)

(require 'imenu-list)



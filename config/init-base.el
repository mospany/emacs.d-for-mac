;;设置个人信息
(setq user-full-name    "mosp")
(setq user-mail-address "moshengping@163.com")
(defconst my-company "Beijing Technology Co.,Ltd." "公司名称")

;;设置默认工作目录
;;
(setq default-directory "~/") 

;;提示
;;M-X 输入命令时有提示
(icomplete-mode t)

;;打开文件时有提示
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)
;;ido模式中不保存目录列表,解决退出Emacs时ido要询问编码的问题。
(setq ido-save-directory-list-file nil)


;; buffer在外部改动时，自动刷新buffer
(global-auto-revert-mode 1)

;;无菜单栏
(menu-bar-mode 0)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;;配置emacs安装包的软件源
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
)

;; Emacs找不到合适的模式时，缺省使用text-mode
(setq default-major-mode 'text-mode)

;; 在fringe上显示一个小箭头指示当前buffer的边界
(setq-default indicate-buffer-boundaries 'left)

;; 尽快显示按键序列
(setq echo-keystrokes 0.01)

(setq system-time-locale "C")


;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; 不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; 可以递归的使用minibuffer
(setq enable-recursive-minibuffers t)

;; 当你在shell、telnet、w3m等模式下时，必然碰到过要输入密码的情况,此时加密显出你的密码
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; 可以保存你上次光标所在的位置
(require 'saveplace)
(setq-default save-place t)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;; 不保存连续的重复的kill
(setq kill-do-not-save-duplicates t)

;; 先格式化再补全
(setq tab-always-indent 'complete)

;; 默认80列
(setq-default fill-column 80)

;; time-stamp, 在文件头记录修改时间, 并动态更新
(setq time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S %:a by %u")
(add-hook 'write-file-hooks 'time-stamp)

;; 不要闪烁光标, 烦不烦啊
(blink-cursor-mode -1)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;;标题栏显示文件路径
(setq frame-title-format
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))

;; 设置默认编码
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default make-backup-files -1)

;解决Emacs的Shell Mode显示乱码
(ansi-color-for-comint-mode-on)
;;不产生备份
(setq backup-inhibited t)
;不生成名为#filename# 的临时文件
(setq auto-save-default -1)
;tab大小为4个空格
(setq default-tab-width 4)
(setq-default indent-tabs-mode -1)

;;CUA-MODE 矩形块复制粘贴操作 http://www.emacswiki.org/emacs/CuaMode
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands 矩形操作后不TAB对齐
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;;; ### Uniquify ###
;;; --- 相同缓存名字时加上路径以区别
(require 'uniquify)    ;如果有两个重名buffer, 则再前面加上路径区别 emacs库
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ;反方向的显示重复的Buffer名字
(setq uniquify-separator "/")                                  ;分隔符
(setq uniquify-after-kill-buffer-p t)                          ;删除重复名字的Buffer后重命名

(setq dired-listing-switches "-aluh")                  ;传给 ls 的参数

;; 雅黑字体
;(set-default-font "-apple-Microsoft_YaHei-medium-normal-normal-*-12-*-*-*-p-0-iso10646-1")
(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")
;(set-default-font "Courier New-13")
;(set-default-font "Monaco-14")
;(set-default-font "Inconsolata-13")
;(set-default-font "Anonymous Pro-15")
;;; shade by mospan, 2016-05-18, use in emacs24.5 error
;(set-fontset-font "fontset-default" 'unicode '("WenQuanYi Zen Hei" . "unicode-ttf"))


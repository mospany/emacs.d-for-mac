;;收集的一些比较好的函数

;;快捷键 C-x C-r重命名当前缓冲区
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

;;将一行上移 下移
(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

;;平分窗格
(defun wenshan-split-window-vertical (&optional wenshan-number)
  (interactive "P")
  (setq wenshan-number (if wenshan-number
                           (prefix-numeric-value wenshan-number)
                         3))
  (while (> wenshan-number 1)
    (split-window-right)
    (setq wenshan-number (- wenshan-number 1)))
  (balance-windows))

;;C-return 在当前行上新开一行
;;C-S-return 在当前行下新开一行
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)

;; 自动为 C/C++ 的头文件添加 #define 保护。
(define-auto-insert
  '("\\.\\([Hh]\\|hh\\|hxx\\|hpp\\)\\'" . "C / C++ header")
  '((upcase (concat "_"
                    (replace-regexp-in-string
                     "[^a-zA-Z0-9]" "_"
                     (format "%s" (file-name-nondirectory buffer-file-name)))))
    "#ifndef " str \n
    "#define " str "\n\n"
    _ "\n\n#endif"))
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

;;代码注释的功能
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

;; 自动为 C/C++ 的头文件添加 #define 保护。
(define-auto-insert
  '("\\.\\([Hh]\\|hh\\|hxx\\|hpp\\)\\'" . "C / C++ header")
  '((upcase (concat "_"
                    (replace-regexp-in-string
                     "[^a-zA-Z0-9]" "_"
                     (format "%s" (file-name-nondirectory buffer-file-name)))))
    "#ifndef " str \n
    "#define " str "\n\n"
    _ "\n\n#endif"))

;; 复制和剪切当前行
;; copy region or whole line
(global-set-key "\M-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line")))))


;; kill region or whole line
(global-set-key "\C-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line")))))

;; 删除当前缓冲区对应的文件
(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)

;;eshell中输入cls清空eshell
(defun eshell/cls ()
  "Clears the shell buffer ala Unix's clear or DOS' cls"
  (interactive)
  ;; the shell prompts are read-only, so clear that for the duration
  (let ((inhibit-read-only t))
    ;; simply delete the region
    (delete-region (point-min) (point-max))))


;;*** simple indent/unindent just like other editors
;; unlike emacs' default settings, this would not use syntax-based indent, but:
;;  - if region selected, indent/unindent the region (tab-width)
;;    * the region mark would not deactivated automatically
;;  - if no region selected, <TAB> would
;;    * if cursor lies in line leading, always indent tab-width
;;    * if cursor lies in word ending and `tab-always-indent' is `complete', try complete
;;    * otherwise, always insert a TAB char or SPACEs
;;  - if no region selected, <S-TAB> would
;;    * if cursor lies in line leading, always unindent tab-width 
;;    * otherwise, the cursor would move backwards (tab-width)
;; Note: this implementation would hornor `tab-always-indent', `indent-tabs-mode' and `tab-with'.

(defun abs-indent (arg)
  "Absolutely indent current line or region. Mimic other editors' indent."
  (interactive "P")
  (let ( (width (or arg tab-width)) )
    (if mark-active
        ;;DONE: how to restore region after `indent-rigidly'
        (let ( (deactivate-mark nil) )
          (indent-rigidly (region-beginning) (region-end) width))
      (let ( (pt           (point))
             (pt-bol       (line-beginning-position))
             (pt-bol-nonws (save-excursion (back-to-indentation) (point))) )
        (if (<= pt pt-bol-nonws)  ;;in leading whitespaces
            (progn
              (back-to-indentation)
              (if (looking-at "$")  ;;all chars in this line are whitespaces or tabs
                  (indent-to (+ (current-column) width))
                (progn
                  (indent-rigidly pt-bol (line-end-position) width)
                  (back-to-indentation))))
          (if (and (eq tab-always-indent 'complete)
                   (looking-at "\\>"))
              (call-interactively abs-indent-complete-function)
            (if indent-tabs-mode
                (insert-char ?\t 1)
              (insert-char ?  width))))))))

(defvar abs-indent-complete-function 'dabbrev-expand
  "The function used in `abs-indent' for completion.")
(make-variable-buffer-local 'abs-indent-complete-function)

(defun abs-unindent (arg)
  "Absolutely unindent current line or region."
  (interactive "P")
  (if mark-active
      (let ( (deactivate-mark nil) )
        (indent-rigidly (region-beginning) (region-end) (- tab-width)))
    (let ( (pt           (point))
           (pt-bol       (line-beginning-position))
           (pt-bol-nonws (save-excursion (back-to-indentation) (point))) )
      (if (> pt pt-bol-nonws)  ;;in content
          (move-to-column (max 0 (- (current-column) tab-width)))
        (progn
          (back-to-indentation)
          (backward-delete-char-untabify (min tab-width (current-column))))))))


